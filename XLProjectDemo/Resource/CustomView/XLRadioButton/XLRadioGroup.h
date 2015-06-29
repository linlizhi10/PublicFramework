//
//  XLRadioGroup.h
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLRadioButton.h"
typedef enum {
    XLRadioGroupOrientationHorizental,  //RadioGroup水平放置
    XLRadioGroupOrientationVertical
} XLRadioGroupOrientation;

@protocol XLRadioGroupDelegate;

@interface XLRadioGroup : UIView
<XLRadioButtonDelegate>/*实现RadioButton代理 */
{
@private
    NSMutableArray *_buttonArray;
    XLRadioButton *_currentButton;
}

@property (assign, nonatomic) NSUInteger checkedIndex;
@property (assign, nonatomic) id<XLRadioGroupDelegate> delegate;

- (id)initWithFrame:(CGRect)frame bgImage:(NSString *)imgName buttonTitle:(NSArray *)array orientation:(XLRadioGroupOrientation)orientation;
- (id)initWithFrame:(CGRect)frame buttonTitle:(NSArray *)array orientation:(XLRadioGroupOrientation)orientation;
- (void)checkIndex:(NSUInteger)index;
- (XLRadioButton *)getCheckedRadioButton:(NSUInteger)checkId;
@end

@protocol XLRadioGroupDelegate <NSObject>

- (void)onCheckedChanged:(XLRadioGroup *)radioGroup index:(NSUInteger)checkId;

@end
