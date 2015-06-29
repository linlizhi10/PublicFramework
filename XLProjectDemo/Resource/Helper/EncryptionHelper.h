//
//  EncryptionHelper.h
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/22.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>


#define __BASE64( text )        [EncryptionHelper base64StringFromText:text]
#define __TEXT( base64 )        [EncryptionHelper textFromBase64String:base64]

@interface EncryptionHelper : NSObject

//+(int)getEncryLen:(NSString *) strinput;
//+(NSString *) AES_Block_Encrypt:(NSString *) strinput ByKey:(NSString *) strkey;
//+(NSString *) AES_Block_Decrypt:(NSString *) strinput ByKey:(NSString *) strkey;



//md5 16位加密 （小写）
+ (NSString *)md5With16L:(NSString *)str;
//md5 16位加密 （大写）
+ (NSString *)md5With16U:(NSString *)str;
//md5 32位加密 （小写）
+ (NSString *)md5With32L:(NSString *)str;
//md5 32位加密 （大写）
+ (NSString *)md5With32U:(NSString *)str;



/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

//URL编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

//URL解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

@end
