//
//  UINavigationController_Custom.m
//  Hospital
//
//  Created by Chino Hu on 13-12-10.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#import "UINavigationController_Custom.h"

@implementation UINavigationController (CustomAnimation)

- (NSString *)caTransitionSubtypeFromLocation:(UIViewControllerTransitFromLocation)fromLocation
{
    NSString *subType = nil;
    if (fromLocation == UIViewControllerTransitFromLeft) {
        subType = kCATransitionFromLeft;
    }else if (fromLocation == UIViewControllerTransitFromRight){
        subType = kCATransitionFromRight;
    }else if (fromLocation == UIViewControllerTransitFromTop) {
        subType = kCATransitionFromTop;
    }else{
        subType = kCATransitionFromBottom;
    }
    return subType;
}

- (CATransition *)CATransitionWithTransitAnimation:(UIViewControllerTransitAnimation)animation
                                      fromLocation:(UIViewControllerTransitFromLocation)fromLocation{
    CATransition *transition =  [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    switch (animation) {
        case UIViewControllerTransitAnimationFade:
            transition.type = kCATransitionFade;
            //transition.subtype = kCATransitionFromTop;
            break;
        case UIViewControllerTransitAnimationMoveIn:
            transition.type = kCATransitionMoveIn;
            //transition.subtype = kCATransitionFromTop;
            break;
        case UIViewControllerTransitAnimationPush:
            transition.type = kCATransitionPush;
            //transition.subtype = kCATransitionFromRight;
            break;
        case UIViewControllerTransitAnimationReveal:
            transition.type = kCATransitionReveal;
            break;
        default:
            break;
    }
    if (fromLocation != UIViewControllerTransitFromNull) {
        transition.subtype = [self caTransitionSubtypeFromLocation:fromLocation];
    }else{
        transition.subtype = nil;
    }
    
    return transition;
}

- (void)pushViewController:(UIViewController *)viewController
                 animation:(UIViewControllerTransitAnimation)animation
              fromLocation:(UIViewControllerTransitFromLocation)fromLocation{
    
    CATransition *anmiation = [self CATransitionWithTransitAnimation:animation fromLocation:fromLocation];
    [self.view.layer addAnimation:anmiation forKey:@"pushViewController"];
    
    [self pushViewController:viewController animated:NO];
}

- (void)popViewControllerWithAnimation:(UIViewControllerTransitAnimation)animation fromLocation:(UIViewControllerTransitFromLocation)fromLocation{
    CATransition *anmiation = [self CATransitionWithTransitAnimation:animation fromLocation:fromLocation];
    [self.view.layer addAnimation:anmiation forKey:@"popViewController"];
    
    [self popViewControllerAnimated:NO];
}

- (void)popToRootViewControllerWithAnimation:(UIViewControllerTransitAnimation)animation {
    CATransition *anmiation = [self CATransitionWithTransitAnimation:animation fromLocation:UIViewControllerTransitFromLeft];
    [self.view.layer addAnimation:anmiation forKey:nil];
    
    [self popToRootViewControllerAnimated:NO];
}

- (void) pushViewController:(UIViewController *)viewController OnDirection:(PPRevealSideDirection)direction withOffset:(CGFloat)offset animated:(BOOL)animated
{
    
}

@end
