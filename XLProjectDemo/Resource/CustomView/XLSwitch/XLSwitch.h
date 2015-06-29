//
//  XLSwitch.h
//  CustomLibrary
//
//  Created by Chino Hu on 14-4-18.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLSwitch : UIControl


@property (nonatomic, assign) BOOL on;
@property (nonatomic, strong) UIColor *inactiveColor;
@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *onColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *knobColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) BOOL isRounded;
@property (nonatomic, strong) UIImage *onImage;
@property (nonatomic, strong) UIImage *offImage;
@property (nonatomic, retain) NSString *onText;
@property (nonatomic, retain) NSString *offText;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (BOOL)isOn;

@end
