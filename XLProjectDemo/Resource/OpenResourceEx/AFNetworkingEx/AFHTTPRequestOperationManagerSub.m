//
//  AFHTTPRequestOperationManagerSub.m
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "AFHTTPRequestOperationManagerSub.h"

@implementation AFHTTPRequestOperationManagerSub

- (AFHTTPRequestOperation *)requestWithURL:(NSString *)URLString
                                HTTPMethod:(NSString *)httpMethod
                                     files:(NSArray *)files
                                parameters:(id)parameters
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:httpMethod URLString:URLString parameters:parameters success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}


@end
