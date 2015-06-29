//
//  XLRadioGroup.m
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "XLRadioGroup.h"

@implementation XLRadioGroup

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame bgImage:(NSString *)imgName buttonTitle:(NSArray *)array orientation:(XLRadioGroupOrientation)orientation
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        _buttonArray = [NSMutableArray array];
        CGFloat tempY = 0;
        for (int i = 0; i < array.count; i++) {
            XLRadioButton *radioButton = nil;
            switch (orientation) {
                case XLRadioGroupOrientationVertical:
                    radioButton = [[XLRadioButton alloc] initWithFrame:CGRectMake(0, tempY, 0, 0) text:[array objectAtIndex:i] aligment:XLRadioButtonAligmentRight isChecked:NO];
                    radioButton.imageName = imgName;
                    tempY += 50;
                    break;
                case XLRadioGroupOrientationHorizental:
                    radioButton = [[XLRadioButton alloc] initWithFrame:CGRectMake(i * self.frame.size.width/array.count, 0, 0, 0) text:[array objectAtIndex:i] aligment:XLRadioButtonAligmentRight isChecked:NO];
                    radioButton.imageName = imgName;
                    break;
            }
            radioButton.tag = i;
            if (i == 0) {
                _currentButton = radioButton;
            }
            radioButton.delegate = self;
            [self addSubview:radioButton];
            [_buttonArray addObject:radioButton];
            
            
        }
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame buttonTitle:(NSArray *)array orientation:(XLRadioGroupOrientation)orientation
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArray = [NSMutableArray array];
        CGFloat tempY = 0;
        for (int i = 0; i < array.count; i++) {
            XLRadioButton *radioButton = nil;
            switch (orientation) {
                case XLRadioGroupOrientationVertical:
                    radioButton = [[XLRadioButton alloc] initWithFrame:CGRectMake(0, tempY, 0, 0) text:[array objectAtIndex:i] aligment:XLRadioButtonAligmentRight isChecked:NO];
                    tempY += 10;
                    break;
                case XLRadioGroupOrientationHorizental:
                    radioButton = [[XLRadioButton alloc] initWithFrame:CGRectMake(i * self.frame.size.width/array.count, 0, 0, 0) text:[array objectAtIndex:i] aligment:XLRadioButtonAligmentRight isChecked:NO];
                    break;
            }
            radioButton.tag = i;
            if (i == 0) {
                _currentButton = radioButton;
            }
            radioButton.delegate = self;
            [self addSubview:radioButton];
            [_buttonArray addObject:radioButton];
        }
    }
    return self;
}

- (void)checkIndex:(NSUInteger)index
{
    _currentButton = [_buttonArray objectAtIndex:index];
    _currentButton.check = YES;
    _checkedIndex = index;
}

- (XLRadioButton *)getCheckedRadioButton:(NSUInteger)checkId
{
    return (XLRadioButton *)[_buttonArray objectAtIndex:checkId];
}

#pragma mark - XLRadioButtonDelegate
- (void)onCheckedChanged:(XLRadioButton *)button
{
    [_currentButton setCheck:NO];
    _currentButton = button;
    [_currentButton setCheck:YES];
    _checkedIndex = button.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(onCheckedChanged:index:)]) {
        [_delegate onCheckedChanged:self index:button.tag];
    }
}



@end
