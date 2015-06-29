//
//  XLRadioButton.m
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "XLRadioButton.h"

@implementation XLRadioButton

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


- (id)initWithFrame:(CGRect)frame text:(NSString *)text aligment:(XLRadioButtonAligment)aligment isChecked:(BOOL)check
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _check = check;
        _aligment = aligment;
        _text = text;
        /* 添加target */
        [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventTouchUpInside];
        //更具字的size 计算本控件的frame
//        _textSize = [_text sizeWithFont:[XLUITool getDefaultFont:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        _textSize = [_text sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(kAppWidth, kAppHeight)];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, RadioButton_WHeight + _textSize.width + RadioButton_Space, RadioButton_WHeight > _textSize.height ? RadioButton_WHeight : _textSize.height);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (!_imageLayer && !_labelLayer) {
        _imageLayer = [CALayer layer];
        //计算_imageLayer 与_labelLayer 的frame
        _imageLayer.frame = _aligment == XLRadioButtonAligmentLeft ? CGRectMake(_textSize.width + 5, _textSize.height > RadioButton_WHeight ? (_textSize.height - RadioButton_WHeight)/2.0 : 0, RadioButton_WHeight, RadioButton_WHeight) : CGRectMake(0, _textSize.height > RadioButton_WHeight ? (_textSize.height - RadioButton_WHeight)/2.0 : 0, RadioButton_WHeight, RadioButton_WHeight);
        [self.layer addSublayer:_imageLayer];
        
        _labelLayer = [CATextLayer layer];
        _labelLayer.string = _text;
        _labelLayer.fontSize = 16;
        _labelLayer.contentsScale = [[UIScreen mainScreen] scale]; //消除CATextLayer锯齿
        _labelLayer.frame = _aligment == XLRadioButtonAligmentLeft ? CGRectMake(0, _textSize.height > RadioButton_WHeight ? 0 : (RadioButton_WHeight - _textSize.height) / 2.0, _textSize.width, _textSize.height > RadioButton_WHeight ? _textSize.height : RadioButton_WHeight) : CGRectMake(RadioButton_WHeight+RadioButton_Space, (self.frame.size.height - _textSize.height)/2.0, _textSize.width, _textSize.height);
        [self.layer addSublayer:_labelLayer];
    }
    
    /*重新切换图片，字体颜色（选中为红色）*/
    if(!_imageName) {
        _imageName = @"jkda_radio";
    }
    _image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", _imageName, _check ? @"_select" : @""]];
//    _image = [UIImage imageNamed:_check ? @"jkda_radio_select" : @"jkda_radio"];
//    _textColor = _check ? [UIColor redColor] : [XLUITool getDefaultTextColor];
    _textColor = [UIColor blackColor];
    _imageLayer.contents = (id)_image.CGImage;
    _labelLayer.foregroundColor = _textColor.CGColor;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self setNeedsDisplay];
}

- (void)valueChanged
{
    if (!_check) {
        _check = !_check;
        if (_delegate && [_delegate respondsToSelector:@selector(onCheckedChanged:)]) {
            [_delegate onCheckedChanged:self];
        }
    }
}

- (void)setCheck:(BOOL)check
{
    _check = check;
    [self setNeedsDisplay];
}

@end
