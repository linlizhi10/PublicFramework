//
//  BaseRequestModel.h
//  IOS FrameWork
//
//  Created by Chino Hu on 13-12-9.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject
@property (nonatomic, strong) NSString *requestMethod;// GET/POST/PUT/DELETE
@property (nonatomic, strong) NSString *url;

@end

@interface BaseResponse : NSObject
@property (nonatomic, assign) BOOL status;//存放状态信息
@property (nonatomic, strong) NSString *result;//返回的结果
@property (nonatomic, strong) NSString *error;//是AFNetworking返回给我们的错误信息(error.localizedDescription 错误信息)
@property (nonatomic, strong) id responseObject;// 是页面返回来的原始信息
@end