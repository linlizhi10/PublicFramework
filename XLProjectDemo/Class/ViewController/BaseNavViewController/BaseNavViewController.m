//
//  LNavViewController.m
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/5.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "BaseNavViewController.h"


@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//*****************处理旋转屏幕*******************

// 是否支持屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}
// 支持的旋转方向
- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;//UIInterfaceOrientationMaskAllButUpsideDown;
    
//    if([[[self viewControllers] objectAtIndex:0] isKindOfClass:[PlayVideoViewController class]])
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    else
        return UIInterfaceOrientationMaskAllButUpsideDown;
    
}
// 一开始的屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
