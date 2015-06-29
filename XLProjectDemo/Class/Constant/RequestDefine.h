//
//  RequestDefine.h
//  Hospital
//
//  Created by ShinSoft on 14-3-10.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#ifndef XL_RequestDefine_h
#define XL_RequestDefine_h

/**
 *  定义网络请求相关常量
 命名规则为：Request_Method_方法名
 字段命名采用驼峰表示(首字母大写)
 */

//***************相关参数*************************************
#define REQUEST_FINISH void (^)(BaseResponse *response)
#define isTest  YES
#define REQUEST_GET     @"GET"
#define REQUEST_POST    @"POST"
#define REQUEST_PUT     @"PUT"
#define REQUEST_DELETE  @"DELETE"

#define isTestHJ  0

#if isTestHJ//1:测试环境  0：正式环境

#define K_IP                    @"117.79.239.194:8080/nhshop"//外网--测试环境
#define K_SERVICE_ADDRESS       [NSString stringWithFormat:@"http://%@%@",K_IP,@"/rest"]//

#else

#define K_IP                    @"www.xinhuan.mobi"//外网--测试环境
#define K_SERVICE_ADDRESS       [NSString stringWithFormat:@"http://%@%@",K_IP,@"/rest"]//


#endif

//****************其它*******************************************
#define Request_Method_PersonCenter                  @"/center/%@"//个人中心 /center/{userId}



#endif
