//
//  SystemDefine.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/18.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#ifndef XL_SystemDefine_h
#define XL_SystemDefine_h

// 取系统版本，e.g.  4.0 5.0
#define kSystemVersion               [[[UIDevice currentDevice] systemVersion] floatValue]

#define kIOS7                        (kSystemVersion >= 7)
#define kIOSe7                       (kSystemVersion >= 7 && kSystemVersion < 8)
#define kIOS8                        (kSystemVersion >= 8)


#pragma mark - 屏幕大小
//屏幕的总高度和宽度.包括状态栏和导航栏
#define kScreenFrame                 [[UIScreen mainScreen] bounds]
#define kScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                [UIScreen mainScreen].bounds.size.height

// 应用的高度，不包含状态栏,但包含导航栏
#define kAppFrame                    [UIScreen mainScreen].applicationFrame
#define kAppHeight                   kAppFrame.size.height
#define kAppWidth                    kAppFrame.size.width
#define kAppHeightWithoutNav         kAppFrame-44.0f //不包含导航栏的高度

//当前视图宽高,(在UIView中使用)
#define kViewWidth                   self.bounds.size.width
#define kViewHeight                  self.bounds.size.height

//当前ViewController中视图宽高(在ViewController中使用)
#define kCtrlViewWidth               self.view.bounds.size.width
#define kCtrlViewHeight              self.view.bounds.size.height


#define kStatusBarHeight             20.0f
#define kNavBarHeight                44.0f
#define kTabBarHeight                49.0f


//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


//System version utils
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)




//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//大于等于8.0的ios版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

//iOS6时，导航VC中view的起始高度
#define YH_HEIGHT (iOS7_OR_LATER ? 64:0)

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]


// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define kIsRetina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIP5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIP6    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIP6Plus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) : NO)

#define kIsPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIsIOS7OrLater ([mSystemVersion floatValue] >= 7.0 ? YES : NO)
#define kIsIOS8OrLater ([mSystemVersion floatValue] >= 8.0 ? YES : NO)

//#define kSystemVersion   ([[UIDevice currentDevice] systemVersion])
#define kDeviceOpenUDID  ([OpenUDID value])
#define kDeviceModel     ([[UIDevice currentDevice] model])
#define kDeviceName      ([[UIDevice currentDevice] name])
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define kAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#endif
