//
//  ViewController.m
//  HttpRequestSecondPackageTest
//
//  Created by ShinSoft on 15/6/12.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DLog(@"1:%f---%f",kCtrlViewWidth,kCtrlViewHeight);
    //DLog(@"1:%f---%f",CurrentViewWidth ,CurrentViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    self.view.backgroundColor = [UIColor grayColor];
    DLog(@"2:%f---%f",kCtrlViewWidth,kCtrlViewHeight);
}

- (void)initData{
    
    BaseRequest *request = [[BaseRequest alloc] init];
    request.requestMethod = REQUEST_GET;
    request.url = [NSString stringWithFormat:Request_Method_PersonCenter,@"402888874cb870d1014cbaca3960002d"];
    
    [self requestWithPrameters:request withFiles:nil isShowProgress:NO finished:^(BaseResponse *response) {
        NSLog(@"===%@",response);
        
//        [[response dictionaryFromAttributes] JSONString];
        
        if (response.status) {//成功
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        } else {//失败
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",response.error]];
        }
    }];
    
}

@end
