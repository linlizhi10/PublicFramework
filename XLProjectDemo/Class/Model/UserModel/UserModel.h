//
//  UserModel.h
//  Hospital
//
//  Created by ShinSoft on 14-3-12.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//**************用户基本信息************start*****************
@interface UserModel : NSObject

@property (nonatomic, assign) BOOL isBindStuInfo;//是否绑定学员信息
@property (nonatomic, strong) NSString *UserId;//用户ID
@property (nonatomic, strong) NSString *NickName;//用户昵称
@property (nonatomic, strong) NSString *HideMobile;//手机号(隐私)
@property (nonatomic, strong) NSString *HideEmail;//邮箱(隐私)
@property (nonatomic, strong) NSString *Mobile;//手机号(公开)
@property (nonatomic, strong) NSString *Email;//邮箱(公开)
@property (nonatomic, strong) NSString *UserName;//账户
@property (nonatomic, strong) NSString *Password;//密码

+ (UserModel *)getInstance;

+ (NSDictionary *)dictionary:(id)obj;
+ (UserModel *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end


