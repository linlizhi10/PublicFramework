//
//  HttpHelper.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManagerSub.h"



@interface HttpHelper : NSObject


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

+ (AFHTTPRequestOperationManager *)requestWithPrameters:(id)request  withFiles:(NSArray *)files  isShowProgress:(BOOL)isShow finished:(REQUEST_FINISH)finished;

@end
