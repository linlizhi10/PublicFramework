//
//  AFHTTPRequestOperationManagerSub.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperationManager_Ex.h"

@interface AFHTTPRequestOperationManagerSub : AFHTTPRequestOperationManager

/**
 *  自定义，为了兼容各个不同的请求方式
 *
 *  @param AFHTTPRequestOperation
 *
 *  @return return value description
 */
- (AFHTTPRequestOperation *)requestWithURL:(NSString *)URLString
                                HTTPMethod:(NSString *)httpMethod
                                     files:(NSArray *)files
                                parameters:(id)parameters
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
