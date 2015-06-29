//
//  UINavigationBar_TNDropShadow.h
//  Hospital
//
//  Created by Chino Hu on 13-12-16.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (TNDropShadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

@end
