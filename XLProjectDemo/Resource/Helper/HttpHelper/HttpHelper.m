//
//  HttpHelper.m
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "HttpHelper.h"


@implementation HttpHelper



+ (AFHTTPRequestOperationManager *)requestWithPrameters:(id)request  withFiles:(NSArray *)files isShowProgress:(BOOL)isShow finished:(REQUEST_FINISH)finished{
    //是否弹出指示器
    if (isShow) {
        [SVProgressHUD show];
    }
    
    //定义HttpManager
    AFHTTPRequestOperationManagerSub *manager = [[AFHTTPRequestOperationManagerSub alloc] initWithBaseURL:[NSURL URLWithString:K_IP]];
    
    //timeout设置
    [manager.requestSerializer setTimeoutInterval:30.0f];
    //header 设置
    [manager.requestSerializer setValue:K_IP forHTTPHeaderField:@"Host"];
    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [manager.requestSerializer setValue:@"application/json,text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (![self validateNetwork:manager]) {//校验网络
        return manager;
    };
    
    BaseResponse *baseResponse = [[BaseResponse alloc] init];
    
    NSString *requestMethod;//默认POST
    NSString *serviceURL;//接口地址
    NSMutableDictionary *requestParameters;//参数
    if ([request isKindOfClass:[NSDictionary class]]) {//如果是字典对象
        requestParameters = [NSMutableDictionary dictionaryWithDictionary:request];
        NSString *requestURL = requestParameters[@"url"];
        serviceURL = [NSString stringWithFormat:@"%@/%@",K_SERVICE_ADDRESS,requestURL];
        requestMethod = IsNilString(requestParameters[@"requestMethod"])?@"POST":requestParameters[@"requestMethod"];
        
        [requestParameters removeObjectForKey:@"url"];
        [requestParameters removeObjectForKey:@"requestMethod"];
    } else if([request isKindOfClass:[BaseRequest class]]){
        requestParameters = [NSMutableDictionary dictionaryWithDictionary:[request dictionaryFromAttributes]];
        NSString *requestURL = requestParameters[@"url"];
        serviceURL = [NSString stringWithFormat:@"%@%@",K_SERVICE_ADDRESS,requestURL];
        requestMethod = IsNilString(requestParameters[@"requestMethod"])?@"POST":requestParameters[@"requestMethod"];
        
        [requestParameters removeObjectForKey:@"url"];
        [requestParameters removeObjectForKey:@"requestMethod"];
    } else {
        baseResponse.status = NO;
        baseResponse.error = @"传递的参数格式不正确";
        finished(baseResponse);
        return manager;
    }
    
    if (files) {
        [manager POST:serviceURL parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (id file in files) {
                if ([file isKindOfClass:[NSData class]]) {
                    [formData appendPartWithFileData:file
                                                name:@""
                                            fileName:@""
                                            mimeType:@"image/jpeg"];
                    
                } else if([file isKindOfClass:[NSString class]]){
                    [formData appendPartWithFileURL:[NSURL URLWithString:file] name:@"" fileName:@"" mimeType:@"image/jpeg" error:nil];
                }
                
            }
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self initResponse:baseResponse operation:operation responseObject:responseObject];
            finished(baseResponse);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self initResponse:baseResponse operation:operation error:error];
            finished(baseResponse);
        }];
    } else {
        [manager requestWithURL:serviceURL HTTPMethod:requestMethod files:files parameters:requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self initResponse:baseResponse operation:operation responseObject:responseObject];
            finished(baseResponse);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self initResponse:baseResponse operation:operation error:error];
            finished(baseResponse);
        }];
    }
    
    
    return manager;
    
}


+ (void)initResponse:(BaseResponse *)baseResponse operation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject{
    //默认
    baseResponse.status = YES;
    baseResponse.result = responseObject;
    baseResponse.responseObject = responseObject;//原始数据
    
    //实际，返回的数据结构需要进行规范，例如{"retCode":"1","item":"result","retInfo":""}
    //故也要再次判断成功失败的情况
    BOOL status = ![responseObject[@"retCode"] boolValue];
    baseResponse.status = status;
    if (status) {
        baseResponse.result = responseObject[@"item"];
    } else {
        baseResponse.error = responseObject[@"retInfo"];
    }
}

+ (void)initResponse:(BaseResponse *)baseResponse operation:(AFHTTPRequestOperation *)operation error:(NSError *)error{
    
    baseResponse.status = NO;
    baseResponse.error =  error ? error.localizedDescription : @"请求异常";
    
    if ([error code] == NSURLErrorNotConnectedToInternet) {
        baseResponse.error = @"网络未连接";
    }
}


+ (BOOL)validateNetwork:(AFHTTPRequestOperationManager*)manager {
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return true;
}

    
@end
