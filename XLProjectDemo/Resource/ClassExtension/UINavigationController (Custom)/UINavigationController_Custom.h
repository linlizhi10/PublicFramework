//
//  UINavigationController_Custom.h
//  Hospital
//
//  Created by Chino Hu on 13-12-10.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIViewControllerTransitAnimationFade,
    UIViewControllerTransitAnimationMoveIn,
    UIViewControllerTransitAnimationPush,
    UIViewControllerTransitAnimationReveal
}UIViewControllerTransitAnimation;

typedef enum {
    UIViewControllerTransitFromNull,
    UIViewControllerTransitFromTop,
    UIViewControllerTransitFromBottom,
    UIViewControllerTransitFromLeft,
    UIViewControllerTransitFromRight
}UIViewControllerTransitFromLocation;

enum {
    /** Left direction */
    PPRevealSideDirectionLeft = 1 << 1,
    /** Right direction */
    PPRevealSideDirectionRight = 1 << 2,
    /** Top direction */
    PPRevealSideDirectionTop = 1 << 3,
    /** Bottom direction */
    PPRevealSideDirectionBottom = 1 << 4,
    /** This cannot be used as a direction. Only for internal use ! */
    PPRevealSideDirectionNone = 0,
};
typedef NSUInteger PPRevealSideDirection;

@interface UINavigationController (CustomAnimation)

- (CATransition *)CATransitionWithTransitAnimation:(UIViewControllerTransitAnimation)animation
                                      fromLocation:(UIViewControllerTransitFromLocation)fromLocation;
#pragma mark - // 子类重载 下面的方法，来添加淡入淡出的动画
- (void)pushViewController:(UIViewController *)viewController
                 animation:(UIViewControllerTransitAnimation)animation
              fromLocation:(UIViewControllerTransitFromLocation)fromLocation;
- (void)popViewControllerWithAnimation:(UIViewControllerTransitAnimation)animation
                          fromLocation:(UIViewControllerTransitFromLocation)fromLocation;
- (void)popToRootViewControllerWithAnimation:(UIViewControllerTransitAnimation)animation;

- (void) pushViewController:(UIViewController *)viewController OnDirection:(PPRevealSideDirection)direction withOffset:(CGFloat)offset animated:(BOOL)animated;

@end
