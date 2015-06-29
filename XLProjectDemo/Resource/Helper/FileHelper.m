//
//  FileHelper.m
//  MommySecure
//
//  Created by ShinSoft on 14-5-12.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper


// get file absolutely path in the caches directory
+ (NSString *)pathInCacheDirectory:(NSString *)fileName{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathInDocumentDirectory:(NSString *)fileName{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}


// create directory in the caches directory
+ (BOOL)createDirInCache:(NSString *)dirName
{
    NSString *fileDir = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    bool isCreated = false;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return isCreated;
}

// create directory in the caches directory
+ (BOOL)createDirInDocument:(NSString *)dirName
{
    NSString *fileDir = [self pathInDocumentDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        isCreated = YES;
    }
    return isCreated;
}

// delete directory in the caches directory
+ (BOOL)deleteDirInCache:(NSString *)dirName{
    NSString *fileDir = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:fileDir error:nil];
    }
    
    return isDeleted;
}

// delete directory in the document directory
+ (BOOL)deleteDirInDocument:(NSString *)dirName{
    NSString *fileDir = [self pathInDocumentDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:fileDir error:nil];
    }
    
    return isDeleted;
}

// save Image to the caches directory
+ (BOOL)saveImageToCacheDir:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType{

    BOOL existed = [self createDirInCache:@"images"];
    bool isSaved = false;
    if (existed == YES ){
        NSString *directoryPath = [self pathInCacheDirectory:@"images"];
        if ([[imageType lowercaseString] isEqualToString:@"png"]) {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        } else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageType lowercaseString] isEqualToString:@"jpeg"]){
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        } else {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        }
    }
    return isSaved;
}

// save Image to the document directory
+ (BOOL)saveImageToDocumentDir:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType{
    
    BOOL existed = [self createDirInDocument:@"images"];
    BOOL isSaved = NO;
    if (existed == YES ){
        NSString *directoryPath = [self pathInDocumentDirectory:@"images"];
        if ([[imageType lowercaseString] isEqualToString:@"png"]) {
            //保存原图
            isSaved = [UIImagePNGRepresentation([image fixOrientation]) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
            
            //保存小图
            if (isSaved) {
               isSaved = [UIImagePNGRepresentation([FileHelper compressImage:image withScaleHeight:320]) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
            }
            
            
        } else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageType lowercaseString] isEqualToString:@"jpeg"]) {
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        } else {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        }
    }
    return isSaved;
}

+ (BOOL)deleteImageFromDocumentWithImageName:(NSString *)imageName withImageType:(NSString *)imageType{
//    NSString *fileDir = [self pathInDocumentDirectory:dirName];
    NSString *directoryPath = [self pathInDocumentDirectory:@"images"];
    NSString *smallPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.%@", imageName,imageType!=nil?imageType:@"png"]];
    NSString *normalPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,imageType!=nil?imageType:@"png"]];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    //删除大图
    BOOL existed = [fileManager fileExistsAtPath:normalPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == NO && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:normalPath error:nil];
        
        if (isDeleted) {
            //删除小图
            existed = [fileManager fileExistsAtPath:smallPath isDirectory:&isDir];
            isDeleted = false;
            if ( isDir == NO && existed == YES )
            {
                isDeleted = [fileManager removeItemAtPath:smallPath error:nil];
            }
        }
    }
    
    return isDeleted;
}

// load Image from caches dir to imageview
+ (NSData *)loadImageData:(NSString *)directoryPath withImageName:(NSString *)imageName{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted;
    if (directoryPath) {
        dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    } else {
        directoryPath = [self pathInDocumentDirectory:@"images/"];;
        dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    }
    
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",directoryPath,imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : imagePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}

//按照某一宽度，等比例压缩图片
+ (UIImage *)compressImage:(UIImage *)image withScaleWidth:(NSInteger)width{
    //设置image的尺寸
    CGSize imagesize = image.size;
    if (imagesize.width>width) {//不足要放大的尺寸，则按原尺寸显示
        imagesize.height = width / imagesize.width * imagesize.height;
        imagesize.width = width;
    }
    
    //对图片大小进行压缩--
    image = [self imageWithImage:image scaledToSize:imagesize];
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.00001);
    
    return [[UIImage imageWithData:imageData] fixOrientation];
//    return [UIImage imageWithData:imageData];
}

//按照某一宽度，等比例压缩图片
+ (UIImage *)compressImage:(UIImage *)image withScaleHeight:(NSInteger)height{
    //设置image的尺寸
    CGSize imagesize = image.size;
    if (imagesize.height>height) {//不足要放大的尺寸，则按原尺寸显示
        imagesize.width = height / imagesize.height * imagesize.width;
        imagesize.height = height;
    }
    
    //对图片大小进行压缩--
    image = [self imageWithImage:image scaledToSize:imagesize];
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.00001);
    
    return [[UIImage imageWithData:imageData] fixOrientation];
//    return [UIImage imageWithData:imageData];
}


//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}


// 判断文件夹是否存在，不存在则创建
+ (BOOL)checkFileIsExist:(NSString *)dirName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirName isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        isCreated = YES;
    }
    return isCreated;
}

//获取文件全路径
+ (NSString *)getFilePathInDocumentDirectory:(NSString *)fileName{
    NSString *directoryPath = [self pathInDocumentDirectory:@"images"];
    BOOL existed = [self checkFileIsExist:directoryPath];
    NSString *filePath;
    if (existed) {
        filePath = [NSString stringWithFormat:@"%@/%@.png",directoryPath,fileName];
    }
    return filePath;
}

//获取图片文件全路径
+ (NSString *)getImageFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check{
    NSString *directoryPath = [self pathInDocumentDirectory:@"images"];
    BOOL existed = [self checkFileIsExist:directoryPath];
    NSString *filePath;
    if (existed) {
        filePath = [NSString stringWithFormat:@"%@/%@.png",directoryPath,fileName];
        
        if (check) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:nil];
            if (!isExist) {
                filePath = nil;
            }
        }
        
    }
    
    return filePath;
}

//获取音频文件全路径
+ (NSString *)getVoiceFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check{
    NSString *directoryPath = [self pathInDocumentDirectory:@"voices"];
    BOOL existed = [self checkFileIsExist:directoryPath];
    NSString *filePath;
    if (existed) {
        filePath = [NSString stringWithFormat:@"%@/%@.mp3",directoryPath,fileName];
        
        if (check) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:nil];
            if (!isExist) {
                filePath = nil;
            }
        }
    }
    return filePath;
}

//获取文件全路径
+ (NSString *)getFilePathInDocumentDirectory:(NSString *)fileName checkExist:(BOOL)check{
    NSString *directoryPath = [self pathInDocumentDirectory:@"files"];
    BOOL existed = [self checkFileIsExist:directoryPath];
    NSString *filePath;
    if (existed) {
        filePath = [NSString stringWithFormat:@"%@/%@",directoryPath,fileName];
        
        if (check) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:nil];
            if (!isExist) {
                filePath = nil;
            }
        }
    }
    return filePath;
}

//获取临时文件全路径
+ (NSString *)getTempFilePathInDocumentDirectory:(NSString *)fileName{
    NSString *directoryPath = [self pathInDocumentDirectory:@"temp"];
    BOOL existed = [self checkFileIsExist:directoryPath];
    NSString *filePath;
    if (existed) {
        filePath = [NSString stringWithFormat:@"%@/%@.temp",directoryPath,fileName];
    }
    return filePath;
}


//计算文件夹下文件的总大小
+ (float)fileSizeForDir:(NSString*)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
}


//计算文件夹下文件的总大小
+ (float)cacheFolderSize{
    
    NSFileManager  *_manager = [NSFileManager defaultManager];
    
    NSArray *_cachePaths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString  *_cacheDirectory = [_cachePaths objectAtIndex:0];
    
    NSArray  *_cacheFileList;
    
    NSEnumerator *_cacheEnumerator;
    
    NSString *_cacheFilePath;
    
    float _cacheFolderSize = 0;
    
    _cacheFileList = [ _manager subpathsAtPath:_cacheDirectory];
    
    _cacheEnumerator = [_cacheFileList objectEnumerator];
    
    while (_cacheFilePath = [_cacheEnumerator nextObject]){
        NSDictionary *_cacheFileAttributes = [_manager fileAttributesAtPath:[_cacheDirectory   stringByAppendingPathComponent:_cacheFilePath]traverseLink:YES];
        _cacheFolderSize += [_cacheFileAttributes fileSize];
    }
    
    // 单位是M
    return _cacheFolderSize/ 1024.0/1024.0;
}

+ (BOOL)clearCache{
    //清除cache路径下的文件
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    DLog(@"files :%d",[files count]);
    for (NSString *p in files) {
        
        //        if ([p hasPrefix:@"net.shinsoft.HospitalOA"]) {
        //
        //        }
        
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            //            if (error) {
            //                return NO;
            //            }
        }
        
    }
    //清除document下files路径下的文件
    NSString *localPath = [self pathInDocumentDirectory:@"files"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:localPath error:nil];
    for (NSString *str in fileArray) {
        NSError *error;
        NSString *filePath = [localPath stringByAppendingPathComponent:str];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [fileManager removeItemAtPath:filePath error:&error];
            //            if (error) {
            //                return NO;
            //            }
        }
    }
    
    return YES;
}


//保存nsdata数据到指定路径的文件夹中
+  (BOOL)saveData:(NSData *)data withName:(NSString *)name toPath:(NSString *)path{
    if (IsNilString(path)) {
        NSString *directoryPath = [self pathInDocumentDirectory:@"files"];
        path = [directoryPath stringByAppendingPathComponent:name];
    }
    NSError *error;
    [data writeToFile:path options:NSAtomicWrite error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

+ (NSString *)obtainFileNameFromPath:(NSString *)filePath{
    NSString *fileName;
    NSArray *fileInfos = [filePath componentsSeparatedByString:@"/"];
    if (fileInfos) {
        fileName = [fileInfos lastObject];
    }
    return fileName;
}

//通过文件名获取document下的xxx/xxx/路径下的全路径
+ (NSString *)obtainFullPathInDocumentWithPath:(NSString *)path withFileName:(NSString *)fileName{
    NSString *fullPath = [self pathInDocumentDirectory:[NSString stringWithFormat:@"%@/%@",path,fileName]];
    DLog(@"%@",fullPath);
    return fullPath;
}

@end
