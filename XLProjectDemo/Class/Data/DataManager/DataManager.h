//
//  DataManager.h
//  FrameWork-1.0
//
//  Created by qinhu  on 13-3-27.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <sqlite3.h>
#import "DBHelper.h"

#define k_key_UserModel                 @"UserModel"
#define k_key_IsLogin                   @"IsLogin"
#define k_go_login                      @"GO_LOGIN"
#define k_auto_login                    @"Auto_Login"//

#define k_auto_reload_plan_data         @"Auto_Reload_Plan_Data"//重新加载计划数据

#define k_key_BindStuModel              @"k_key_BindStuModel"//保存绑定学员key
#define k_go_bind_stu                   @"k_key_Bind_Stu"//跳转到绑定页面

#define k_go_load_week                   @"k_go_load_week"//加载周列表

#define k_reload_study_data              @"k_reload_study_data"//重新加载学习首页数据
#define k_reload_timetable_data          @"k_reload_timetable_data"//重新加载课表首页数据
#define k_reload_personal_data           @"k_reload_study_data"//重新加载我首页数据

#define k_key_IsNightMode                @"IsNightMode"//是否夜间模式
#define k_key_DefaultSubject             @"DefaultSubject"//视频默认科目

#define k_key_NotifyFlag                 @"NotifyFlag"//是否接受通知

@interface DataManager : NSObject
{
    sqlite3 *db;
}

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isShowNavBg;
@property (nonatomic, strong) UserModel *userModel;;

@property (nonatomic, assign) BOOL isSlide;
@property (nonatomic, assign) BOOL isNightMode;//是否是夜间模式

@property (nonatomic, assign) BOOL isReceiveNotify;//是否接收通知



+ (DataManager *)getInstance;
- (NSString *)filePath:(NSString *)name;
- (NSString *)sandBoxFilePath:(NSString *)fileName;
- (void)saveData:(id)data toKey:(NSString *)key;
- (id)dataOfKey:(NSString *)key;
- (id)dataModelOfKey:(NSString *)key;
- (NSString *)uniqueId;


@end
