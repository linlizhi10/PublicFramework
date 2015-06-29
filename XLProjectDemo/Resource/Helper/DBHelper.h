//
//  DBHelper.h
//  MommySecure
//
//  Created by ShinSoft on 14-6-6.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

@interface DBHelper : NSObject

+ (sqlite3 *)open;
+ (void)close;

@end
