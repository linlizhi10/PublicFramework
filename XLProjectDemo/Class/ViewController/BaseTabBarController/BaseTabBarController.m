//
//  MyTabBarController.m
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController()

@end

@implementation BaseTabBarController


// 是否支持屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}
// 支持的旋转方向
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;//UIInterfaceOrientationMaskAllButUpsideDown;
    
    
}
// 一开始的屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
