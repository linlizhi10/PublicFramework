//
//  UINavigationBar_TNDropShadow.m
//  Hospital
//
//  Created by Chino Hu on 13-12-16.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#import "UINavigationBar_TNDropShadow.h"
#import <QuartzCore/QuartzCore.h>

@implementation UINavigationBar (TNDropShadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    self.clipsToBounds = NO;
}

@end
