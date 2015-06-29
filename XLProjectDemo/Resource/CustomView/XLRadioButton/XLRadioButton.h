//
//  XLRadioButton.h
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#define RadioButton_WHeight 25
#define RadioButton_Space 5
typedef enum {
    XLRadioButtonAligmentLeft,  //图片在左方
    XLRadioButtonAligmentRight
} XLRadioButtonAligment;

@protocol  XLRadioButtonDelegate;

@interface XLRadioButton : UIControl
{
@private
    XLRadioButtonAligment _aligment;
    CGSize _textSize;
    //使用layer减少内存消耗
    CALayer *_imageLayer;
    CATextLayer *_labelLayer;
}

@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, strong) UIImage *image;   //图片
@property (nonatomic, strong) UIColor *textColor;  //字体颜色
@property (assign, nonatomic) id<XLRadioButtonDelegate> delegate;
@property (nonatomic, getter = isChecked, setter = setCheck:) BOOL check;
@property (nonatomic, strong) NSString *text;

- (id)initWithFrame:(CGRect)frame text:(NSString *)text aligment:(XLRadioButtonAligment)aligment isChecked:(BOOL)check;
- (void)setCheck:(BOOL)check;
@end

@protocol XLRadioButtonDelegate <NSObject>

- (void)onCheckedChanged:(XLRadioButton *)button;
@end
