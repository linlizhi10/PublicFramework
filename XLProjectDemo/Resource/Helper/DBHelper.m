//
//  DBHelper.m
//  MommySecure
//
//  Created by ShinSoft on 14-6-6.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "DBHelper.h"


static sqlite3 *db = nil;
@implementation DBHelper


+ (sqlite3 *)open
{
    if (db) {
        return db;
    }
        //bundle路径
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"sqlite3"];
    
//        NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //目标路径
//        NSString *targetPath = [documentPath stringByAppendingPathComponent:@"info.sqlite"];
//        NSFileManager *fm = [NSFileManager defaultManager];
//        BOOL success = NO;
//    
//        if ([fm fileExistsAtPath:targetPath] == NO)
//        {
//                success = [fm copyItemAtPath:bundlePath toPath:targetPath error:nil];
//            
//                if (success == YES)
//                {
//                    sqlite3_open([targetPath UTF8String], &db);
//                }
//        }
        sqlite3_open([bundlePath UTF8String], &db);
        return db;
}
    //关闭数据库
+ (void)close
{
    if (db) {
        sqlite3_close(db);
    }
}



@end
