//
//  UINavigationController+Rotation_IOS6.h
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Rotation_IOS6)

- (BOOL)shouldAutorotate;

- (NSUInteger)supportedInterfaceOrientations;

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;


@end
