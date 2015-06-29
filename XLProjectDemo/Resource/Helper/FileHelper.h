//
//  FileHelper.h
//  MommySecure
//
//  Created by ShinSoft on 14-5-12.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+FixOrientation.h"

@interface FileHelper : NSObject

+ (NSString *)pathInCacheDirectory:(NSString *)fileName;
+ (NSString *)pathInDocumentDirectory:(NSString *)fileName;

+ (BOOL)createDirInCache:(NSString *)dirName;
+ (BOOL)createDirInDocument:(NSString *)dirName;

+ (BOOL)deleteDirInCache:(NSString *)dirName;
+ (BOOL)deleteDirInDocument:(NSString *)dirName;

// save Image to the caches directory
+ (BOOL)saveImageToCacheDir:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType;
// save Image to the document directory
+ (BOOL)saveImageToDocumentDir:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType;

+ (BOOL)deleteImageFromDocumentWithImageName:(NSString *)imageName withImageType:(NSString *)imageType;

+ (NSData *)loadImageData:(NSString *)directoryPath withImageName:(NSString *)imageName;

//按照某一宽度，等比例压缩图片
+ (UIImage *)compressImage:(UIImage *)image withScaleWidth:(NSInteger)width;

//按照某一高度，等比例压缩图片
+ (UIImage *)compressImage:(UIImage *)image withScaleHeight:(NSInteger)height;


//获取文件全路径
+ (NSString *)getFilePathInDocumentDirectory:(NSString *)fileName;
//获取图片文件全路径
+ (NSString *)getImageFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check;
//获取音频文件全路径
+ (NSString *)getVoiceFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check;
//获取所有类型文件全路径
+ (NSString *)getFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check;
//获取临时文件全路径
+ (NSString *)getTempFilePathInDocumentDirectory:(NSString *)fileName;


//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path;

//计算文件夹下文件的总大小
+ (float)cacheFolderSize;

//清除缓存文件:包括document下的files和缓存路径的文件
+ (BOOL)clearCache;

//保存nsdata数据到指定路径的文件夹中
+  (BOOL)saveData:(NSData *)data withName:(NSString *)name toPath:(NSString *)path;

//通过全路径获取该路径的文件名
+ (NSString *)obtainFileNameFromPath:(NSString *)filePath;

//通过文件名获取document下的xxx/xxx/路径下的全路径
+ (NSString *)obtainFullPathInDocumentWithPath:(NSString *)path withFileName:(NSString *)fileName;

@end
