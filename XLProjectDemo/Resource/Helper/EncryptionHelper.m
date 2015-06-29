//
//  EncryptionHelper.m
//  XDFSecurePlan
//
//  Created by ShinSoft on 15/1/22.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "EncryptionHelper.h"

#import "NSString+Base64.h"
//#import "opensslconf.h"
//#import "opensslv.h"
//#import "aes.h"
#import "NSData+Base64.h"


//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation EncryptionHelper





//+(int) getEncryLen:(NSString *) strinput
//{
//    static int blockSize = AES_BLOCK_SIZE;
//    int iLength = [[strinput dataUsingEncoding:NSUTF8StringEncoding] length];
//    int mk = iLength;
//    if (iLength % blockSize != 0) {
//        mk = iLength + blockSize - (iLength % blockSize);
//    } else {
//        mk = iLength;
//    }
//    return mk;
//}


//+(NSString *) AES_Block_Encrypt:(NSString *) strinput ByKey:(NSString *) strkey{
//    AES_KEY key;
//    int nr_of_bits = 8 * strlen([strkey UTF8String]);
//    AES_set_encrypt_key([[strkey dataUsingEncoding:NSUTF8StringEncoding] bytes], nr_of_bits, &key);
//    
//    int outLen = [self getEncryLen:strinput];
//    unsigned char ciphertext [outLen];
//    memset(ciphertext, 0,outLen);
//    
//    int iLength = [[strinput dataUsingEncoding:NSUTF8StringEncoding] length];
//    if (iLength < outLen) {
//        NSMutableString *addString = [NSMutableString stringWithString:@""];
//        for (int i = 0; i < (outLen - iLength); i++) {
//            [addString appendString:@"\0"];
//        }
//        
//        strinput = [NSString stringWithFormat:@"%@%@",strinput,addString];
//    }
//    
//    NSData * inputData = [strinput dataUsingEncoding:NSUTF8StringEncoding];
//    const unsigned char * enCodeData = [inputData bytes];
//    
//    for (int i = 0; i < outLen/AES_BLOCK_SIZE; i++) {
//        
//        int len = ([inputData length] - AES_BLOCK_SIZE * i)<AES_BLOCK_SIZE ? ([inputData length] - AES_BLOCK_SIZE * i) : AES_BLOCK_SIZE;
//        unsigned char tempIn [len];
//        memset(tempIn, 0 , len);
//        
//        memcpy(tempIn, enCodeData + AES_BLOCK_SIZE * i, len);
//        
//        unsigned char tempOut [AES_BLOCK_SIZE];
//        memset(tempOut, 0,AES_BLOCK_SIZE);
//        NSData *tempData = [NSData dataWithBytes:tempIn length:len];
//        AES_encrypt([tempData bytes],tempOut,&key);
//        
//        memcpy(ciphertext + AES_BLOCK_SIZE * i, tempOut, AES_BLOCK_SIZE);
//    }
//    return [NSString base64StringFromData:[NSData dataWithBytes:ciphertext length:outLen] length:outLen];
//}
//
//+(NSString *) AES_Block_Decrypt:(NSString *) strinput ByKey:(NSString *) strkey{
//    
//    NSData *data = [NSData dataWithBase64EncodedString:strinput];
//    
//    int len4Decrypt = [data length];
//    unsigned char decode [len4Decrypt];
//    memset(decode, 0, len4Decrypt);
//    
//    NSData *outputData = data;
//    const unsigned char * ciphertext = [outputData bytes];
//    
//    AES_KEY keyOut;
//    int nr_of_bits = 8 * strlen([strkey UTF8String]);
//    AES_set_decrypt_key([[strkey dataUsingEncoding:NSUTF8StringEncoding] bytes], nr_of_bits, &keyOut);
//    for (int i = 0; i < len4Decrypt/AES_BLOCK_SIZE; i++) {
//        int len = ([outputData length] - AES_BLOCK_SIZE * i)<AES_BLOCK_SIZE ? ([outputData length] - AES_BLOCK_SIZE * i) : AES_BLOCK_SIZE;
//        
//        unsigned char tempIn [len];
//        memset(tempIn, 0 , len);
//        
//        memcpy(tempIn, ciphertext + AES_BLOCK_SIZE * i, len);
//        
//        unsigned char tempOut [AES_BLOCK_SIZE];
//        memset(tempOut, 0,AES_BLOCK_SIZE);
//        NSData *tempData = [NSData dataWithBytes:tempIn length:len];
//        AES_decrypt([tempData bytes], tempOut, &keyOut);
//        memcpy(decode + i * AES_BLOCK_SIZE, tempOut, len);
//    }
//    
//    NSString *strtemp = [[NSString alloc] initWithData:[NSData dataWithBytes:decode length:len4Decrypt] encoding:NSUTF8StringEncoding];
//    return strtemp;
//}


//md5 16位加密 （小写）
+ (NSString *)md5With16L:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);//最新代码
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


//md5 16位加密 （大写）
+ (NSString *)md5With16U:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
//    CC_MD5( cStr, strlen(cStr), result );
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




//md5 32位加密 （小写）
+ (NSString *)md5With32L:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15],
            result[16], result[17], result[18], result[19],
            result[20], result[21], result[22], result[23],
            result[24], result[25], result[26], result[27],
            result[28], result[29], result[30], result[31]
            ];
}


//md5 32位加密 （大写）
+ (NSString *)md5With32U:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    
//    CC_MD5( cStr, strlen(cStr), result );
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15],
            result[16], result[17], result[18], result[19],
            result[20], result[21], result[22], result[23],
            result[24], result[25], result[26], result[27],
            result[28], result[29], result[30], result[31]
            ];
}





+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


//URL编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}
//URL解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
