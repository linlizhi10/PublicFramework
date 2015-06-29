
//  QHBasicViewController.m
//  helloworld
//
//  Created by chen on 14/6/30.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "BaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HttpHelper.h"

#define kTARGET @"target"
#define kSUCCESSSELECTOR @"successSelector"
#define kFAILEDSELECTOR @"failedSelector"
#define kFINISHSELECTOR @"finishSelector"

#define kSecondsToShow  3.5
#define kShowAnimationDuration  0.2
#define kHideAnimationDuration  0.2

@interface BaseViewController ()
{
    float _nSpaceNavY;
}

@end

@implementation BaseViewController

- (id)initWithFrame:(CGRect)frame param:(NSArray *)arParams
{
    self.arParams = arParams;
    
    self = [super init];
    
    [self.view setFrame:frame];
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseView];
}

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem
{
    UIImageView *navIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nSpaceNavY, self.view.width, 64 - _nSpaceNavY)];
    navIV.tag = 98;
    [self.view addSubview:navIV];
    [self reloadImage];
    
    /* { 导航条 } */
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, 320, 44.f)];
    ((UIImageView *)_navView).backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    
    UILabel *titleLabel;
    if (szTitle != nil)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_navView.width - 200)/2, (_navView.height - 40)/2, 200, 40)];
        [titleLabel setText:szTitle];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [_navView addSubview:titleLabel];
    }
    
    UIView *item1 = menuItem(0);
    if (item1 != nil)
    {
        [_navView addSubview:item1];
    }
    UIView *item2 = menuItem(1);
    if (item2 != nil)
    {
        _rightV = item2;
        [_navView addSubview:item2];
    }
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerReloadImage:) name:RELOADIMAGE object:nil];
    
    
}


- (void)observerReloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage:notif];
}

- (void)reloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage];
}


- (void)reloadImage
{
    //    NSString *imageName = nil;
    //    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    //    {
    //        imageName = @"header_bg_ios7.png";
    //    }else
    //    {
    //        imageName = @"header_bg.png";
    //    }
    //    UIImage *image = [QHCommonUtil imageNamed:imageName];
    //    UIImageView *navIV = (UIImageView *)[self.view viewWithTag:98];
    //    [navIV setImage:image];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}

- (void)subReloadImage
{
    NSLog(@"subReloadImage");
}


//**************************************************************************

- (void)initBaseView{
    
    
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    
    if(kIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        //        self.view.backgroundColor = [UIColor whiteColor];
        
        //把状态栏的颜色改为白色：在info.plist中添加一个字段：view controller -base status bar 设置为NO
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    //self.view.backgroundColor = MAIN_BG_COLOR;
    //    [self.navigationController.navigationBar dropShadowWithOffset:CGSizeMake(0, 2)
    //                                                           radius:2
    //                                                            color:[UIColor darkGrayColor]
    //                                                          opacity:1];
    
    [self addLeftNavigationImageButton:[QHCommonUtil imageNamed:@"nav_back"]];
    
    //初始化导航栏背景
    //    [self initNavBarBg:nil];
    //ios7
//    self.navigationController.navigationBar.barTintColor = NAV_BAR_BGCOLOR;
    
    
    
    if (kIOS7) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    _dataManager = [DataManager getInstance];
    
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.managedObjectContext;
    
    [self initToolBar];
    //    [self initLoginData];
    
    
    DLog(@"%@",self.navigationController.navigationBar.titleTextAttributes);
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}



- (void)showActivityIndicator{
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake((kScreenWidth - 30) / 2, kScreenHeight / 2, 30, 30);
    }
    [indicator startAnimating];
    [self.window addSubview:indicator];
}

- (void)hideActivityIndicator{
    [indicator stopAnimating];
    [indicator removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [[self navigationController] setNavigationBarHidden:YES];
    //UMeng统计开始
    //[MobClick beginLogPageView:@"PageOne"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //UMeng统计结束
    //[MobClick endLogPageView:@"PageOne"];
    
    if (indicator) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }
    
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
}

- (void)initNavBarBg:(NSString *)imageName{
    
    
    if (IsNilString(imageName)) {
        UIImage *navBtnImage = [QHCommonUtil imageNamed:[NSString stringWithFormat:@"header_bg%@" ,kIOS7 ? @"_ios7" : @""]];
        [self.navigationController.navigationBar setBackgroundImage:navBtnImage forBarMetrics:UIBarMetricsDefault];
    } else {
        UIImage *navBtnImage = [QHCommonUtil imageNamed:[NSString stringWithFormat:@"%@%@",imageName ,kIOS7 ? @"_ios7" : @""]];
        [self.navigationController.navigationBar setBackgroundImage:navBtnImage forBarMetrics:UIBarMetricsDefault];
    }
    
    //    if (IsNilString(imageName)) {
    //        imageName = @"nav_bar_bg";
    //    }
    
//    if (IsNilString(imageName)) {
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"header_bg%@" ,ios7 ? @"_ios7" : @""]] forBarMetrics:UIBarMetricsDefault];
//    } else {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",imageName ,ios7 ? @"_ios7" : @""]] forBarMetrics:UIBarMetricsDefault];
//    }
}


- (void)initToolBar{
    //上下选择工具栏
    if (!keyboardToolbar) {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        //        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"上一行", @"")
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(previousField:)];
        
        UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"下一行", @"")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(nextField:)];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(resignKeyboard:)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, spaceBarItem, spaceBarItem, doneBarItem, nil]];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
            //iOS 5
            [keyboardToolbar setBackgroundImage:[UIImage imageNamed:@"toolbar_bg"] forToolbarPosition:0 barMetrics:0];
        } else {
            //iOS 4
            [keyboardToolbar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolbar_bg"]] atIndex:0];
        }
    }
}

#pragma mark -ToolBar
- (void)previousField:(id)sender{
    
}

- (void)nextField:(id)sender{
}

- (void)resignKeyboard:(id)sender{
    //    [self.view endEditing:YES];
}



- (void)viewDidLayoutSubviews
{
    
}

- (UIWindow *)window
{
    return [[UIApplication sharedApplication] keyWindow];
}

- (void)showProgressHud:(NSString *)message
{
    [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeClear];
}

- (void)showSuccessHud:(NSString *)message
{
    if(message) {
        [SVProgressHUD showSuccessWithStatus:message];
        return;
    }
    [SVProgressHUD showSuccessWithStatus:@"操作成功!"];
}

- (void)dismissProgressHud
{
    [SVProgressHUD dismiss];
}

- (void)showFailedHud:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message ? message : @"操作失败！"];
}

- (void)showAlertView:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showAlertView:(NSString *)title Message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)addLeftNavigationTitleButton:(NSString *)title
{
    UIBarButtonItem *leftButton = [self barButtonItem:title action:@selector(leftBarButtonClicked)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)addLeftNavigationImageButton:(UIImage *)image{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;//自定义返回按钮后，右滑返回失效；
    //    self.navigationItem.backBarButtonItem = leftButton;
    [button addTarget:self action:@selector(leftBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addLeftNavigationButton:(UIBarButtonSystemItem)style
{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style target:self action:@selector(leftBarButtonClicked)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)addRightNavigationButton:(UIBarButtonSystemItem)style
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style target:self action:@selector(rightBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightNavigationTitleButton:(NSString *)title
{
    UIBarButtonItem *rightButton = [self barButtonItem:title action:@selector(rightBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightNavigationInfoButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    [button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightNavigationImageButton:(UIImage *)image
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    [button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightNavigationBarButton:(UIButton *)button{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftButton;
    [button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (UIBarButtonItem *)barButtonItem:(NSString *)title action:(SEL)clicked
{
    float bWidth = [CommonMethod getLabelWidth:title WithFont:[UIFont boldSystemFontOfSize:15.0] withHeight:30];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, bWidth, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:clicked forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBarButtonClicked { }
- (void)leftBarButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToNextController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animation:UIViewControllerTransitAnimationMoveIn fromLocation:UIViewControllerTransitFromRight];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (kIOS7) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}


- (void)showAlertBannerInView:(UIButton *)button {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBannerPosition position = (ALAlertBannerPosition)button.tag;
    ALAlertBannerStyle randomStyle = (ALAlertBannerStyle)(arc4random_uniform(4));
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.view style:randomStyle position:position title:@"温馨提示" subtitle:@"" tappedBlock:^(ALAlertBanner *alertBanner) {
        NSLog(@"tapped!");
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}

- (void)showSuccessWithStatus:(NSString *)subTitle {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:_appDelegate.window style:ALAlertBannerStyleSuccess position:ALAlertBannerPositionUnderNavBar title:subTitle subtitle:nil tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}

- (void)showErrorWithStatus:(NSString *)subTitle {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:_appDelegate.window style:ALAlertBannerStyleFailure position:ALAlertBannerPositionUnderNavBar title:subTitle subtitle:nil tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}

- (void)showWarningWithStatus:(NSString *)subTitle {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:_appDelegate.window style:ALAlertBannerStyleWarning position:ALAlertBannerPositionUnderNavBar title:subTitle subtitle:nil tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}

- (void)showNotifyWithStatus:(NSString *)subTitle {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:_appDelegate.window style:ALAlertBannerStyleNotify position:ALAlertBannerPositionUnderNavBar title:subTitle subtitle:nil tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}



//显示在状态栏下
- (void)showZWarningWithStatus:(NSString *)subTitle {
    [[ALAlertBannerManager sharedManager] hideAllAlertBanners];
    
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:_appDelegate.window style:ALAlertBannerStyleWarning position:ALAlertBannerPositionTop title:subTitle subtitle:nil tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = kSecondsToShow;
    banner.showAnimationDuration = kShowAnimationDuration;
    banner.hideAnimationDuration = kHideAnimationDuration;
    [banner show];
}

- (void)presentLoginVC
{
    [[NSNotificationCenter defaultCenter] postNotificationName:k_go_login object:self userInfo:nil];
}

- (void)presentBindVC
{
    [[NSNotificationCenter defaultCenter] postNotificationName:k_go_bind_stu object:self userInfo:nil];
}




- (AFHTTPRequestOperationManager *)requestWithPrameters:(id)request  withFiles:(NSArray *)files  isShowProgress:(BOOL)isShow finished:(REQUEST_FINISH)finished{
    return [HttpHelper requestWithPrameters:request withFiles:files isShowProgress:isShow finished:finished];
}


//*****************处理旋转屏幕*******************

// 是否支持屏幕旋转
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//// 支持的旋转方向
////- (NSUInteger)supportedInterfaceOrientations {
////    return UIInterfaceOrientationMaskAllButUpsideDown;//UIInterfaceOrientationMaskAllButUpsideDown;
////}
//// 一开始的屏幕旋转方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}

@end
