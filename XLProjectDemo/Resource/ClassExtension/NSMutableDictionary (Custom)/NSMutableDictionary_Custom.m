//
//  NSMutableDictionary_AutoDescription.m
//  FrameWork-1.0
//
//  Created by Chino Hu on 13-10-31.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import "NSMutableDictionary_Custom.h"

@implementation NSMutableDictionary (Custom)

- (id)nObjectForKey:(id)aKey
{
    id value = [self objectForKey:aKey];

    return value ? value : @"";
}

- (NSString *)autoDescription
{
    NSString *key;
    NSString *value;
    NSString *desc = @"";
    int count = 0;
    for(key in [self allKeys]) {
        count++;
        value = [self objectForKey:key];
        desc = [desc stringByAppendingFormat:@"%@=%@", key, value];
        if(count < [self count])
            desc = [desc stringByAppendingPathExtension:@", "];
    }
    return desc;
}

@end
