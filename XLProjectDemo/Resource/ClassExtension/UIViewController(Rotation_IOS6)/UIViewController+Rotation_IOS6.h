//
//  UIViewController+Rotation_IOS6.h
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Rotation_IOS6)


// IOS5默认支持竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

// IOS6默认不开启旋转，如果subclass需要支持屏幕旋转，重写这个方法return YES即可
- (BOOL)shouldAutorotate;

// IOS6默认支持竖屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;


@end
