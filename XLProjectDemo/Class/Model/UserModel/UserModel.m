//
//  UserModel.m
//  Hospital
//
//  Created by ShinSoft on 14-3-12.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#import "UserModel.h"
#import "DataManager.h"
#import <objc/runtime.h>
#define PRINT_OBJ_LOGGING 1


//**************用户登陆************start*****************
@implementation UserModel

static UserModel *userModel;

+ (UserModel *)getInstance
{
    @synchronized(self){
        if (userModel == nil) {
            userModel = [[DataManager getInstance] dataModelOfKey:k_key_UserModel];
            if (userModel == nil) {
                userModel = [[UserModel alloc] init];
            }
        }
        return userModel;
    }
}


-(id)initWithCoder: (NSCoder*)coder
{
    if(self= [super init])
    {
        self.isBindStuInfo = [[coder decodeObjectForKey:@"isBindStuInfo"] boolValue];//是否绑定学员信息
        self.UserId=[coder decodeObjectForKey:@"UserId"];//用户ID
        self.NickName=[coder decodeObjectForKey:@"NickName"];//用户昵称
        self.HideMobile = [coder decodeObjectForKey:@"HideMobile"];//手机号(隐私)
        self.HideEmail = [coder decodeObjectForKey:@"HideEmail"];//邮箱(隐私)
        self.Mobile = [coder decodeObjectForKey:@"Mobile"];//手机号(公开)
        self.Email = [coder decodeObjectForKey:@"Email"];//邮箱(公开)
        
        self.UserName = [coder decodeObjectForKey:@"UserName"];//账户
        self.Password = [coder decodeObjectForKey:@"Password"];//密码
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.isBindStuInfo?@"1":@"0" forKey:@"isBindStuInfo"];
    [coder encodeObject:self.UserId?self.UserId:@"" forKey:@"UserId"];
    [coder encodeObject:self.NickName?self.NickName:@"" forKey:@"NickName"];
    [coder encodeObject:self.HideMobile?self.HideMobile:@"" forKey:@"HideMobile"];
    [coder encodeObject:self.HideEmail?self.HideEmail:@"" forKey:@"HideEmail"];
    [coder encodeObject:self.Mobile?self.Mobile:@"" forKey:@"Mobile"];
    [coder encodeObject:self.Email?self.Email:@"" forKey:@"Email"];
    [coder encodeObject:self.UserName?self.UserName:@"" forKey:@"UserName"];
    [coder encodeObject:self.Password?self.Password:@"" forKey:@"Password"];
}



+ (NSDictionary *)dictionary:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self getObjectInternal:[obj valueForKey:propName]];
            if(value != nil) {
                [dic setObject:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            [self logError:exception];
        }
        
    }
    return dic;
}


+ (id)getObjectInternal:(id)obj
{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self dictionary:obj];
}

+ (void)logError:(NSException*)exp
{
    #if PRINT_OBJ_LOGGING
    NSLog(@"PrintObject Error: %@", exp);
    #endif
}


+ (UserModel *)instanceFromDictionary:(NSDictionary *)aDictionary {
    UserModel *instance = [[UserModel alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [self setValuesForKeysWithDictionary:aDictionary];
}

@end



