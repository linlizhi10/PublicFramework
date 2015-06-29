//
//  QHBasicViewController.h
//  helloworld
//
//  Created by chen on 14/6/30.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UINavigationController_Custom.h"
#import "UINavigationBar_TNDropShadow.h"
#import "SVProgressHUD.h"
#import "NSObject+AutoDescription.h"
#import "DataManager.h"
#import "JSONKit.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "FileHelper.h"
#import "CommonMethod.h"
#import "ALAlertBanner.h"
#import "ALAlertBannerManager.h"




@interface BaseViewController : UIViewController
{
    dispatch_queue_t _mainQueue;
    dispatch_queue_t _concurrentQueue;
    
    DataManager *_dataManager;
    
    AppDelegate *_appDelegate;
    NSManagedObjectContext  *_context;
    UIActivityIndicatorView *indicator;//加载指示器
    
    UIToolbar *keyboardToolbar;
}

@property (nonatomic, strong) UIImageView *statusBarView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, assign, readonly) int nMutiple;
@property (nonatomic, strong) NSArray *arParams;
@property (nonatomic, strong) UIView *rightV;

- (id)initWithFrame:(CGRect)frame param:(NSArray *)arParams;
- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;
- (void)reloadImage;
- (void)reloadImage:(NSNotificationCenter *)notif;
- (void)subReloadImage;
- (void)addObserver;


//**********************************************************************

@property (strong, nonatomic) UIWindow *window;

- (void)showProgressHud:(NSString *)message;
- (void)showSuccessHud:(NSString *)message;
- (void)showFailedHud:(NSString *)message;
- (void)dismissProgressHud;

- (void)showAlertView:(NSString *)message;
- (void)showAlertView:(NSString *)title Message:(NSString *)message;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

- (void)addLeftNavigationTitleButton:(NSString *)title;
- (void)addLeftNavigationImageButton:(UIImage *)image;
- (void)addLeftNavigationButton:(UIBarButtonSystemItem)style;
- (void)addRightNavigationButton:(UIBarButtonSystemItem)style;
- (void)addRightNavigationTitleButton:(NSString *)title;
- (void)addRightNavigationImageButton:(UIImage *)image;
- (void)addRightNavigationInfoButton;
- (void)addRightNavigationBarButton:(UIButton *)button;


- (void)rightBarButtonClicked;
- (void)leftBarButtonClicked;

- (void)goToNextController:(UIViewController *)viewController;//导航到下一个controller

- (void)initNavBarBg:(NSString *)imageName;//初始化导航栏背景


//消息提示
- (void)showSuccessWithStatus:(NSString *)subTitle;//成功提示
- (void)showErrorWithStatus:(NSString *)subTitle;//错误提示
- (void)showWarningWithStatus:(NSString *)subTitle;//警告提示
- (void)showNotifyWithStatus:(NSString *)subTitle;//通知提示

- (void)showZWarningWithStatus:(NSString *)subTitle;//警告提示


- (void)presentLoginVC;
- (void)presentBindVC;


/**
 *  网络请求
 *
 *  @param request  请求数据的对象
 字典或者NSObject
 NSObject:
 BaseRequest：基类，必须包含下面两个属性（字典也必须包含）
 requestMethod:GET/POST/PUT/DELETE，为空时默认POST
 url:网络请求地址，可以是全地址或者部分地址，可以在方法体中进行组合绝对地址
 
 *  @param files    上传文件数组：文件绝对路径的字符数组/NSData数组
 *  @param finished 返回结果：BaseResponse
 status： YES：成功，NO：失败
 result： 成功结果
 error： 错误信息
 responseObject：返回的原始数据
 
 后续待完善
 */
//- (void)requestWithPrameters:(id)request  withFiles:(NSArray *)files finished:(void(^)(BOOL status, id result, id errMsg))finished;

- (AFHTTPRequestOperationManager *)requestWithPrameters:(id)request  withFiles:(NSArray *)files  isShowProgress:(BOOL)isShow finished:(REQUEST_FINISH)finished;


@end
