//
//  NSMutableDictionary_AutoDescription.h
//  FrameWork-1.0
//
//  Created by Chino Hu on 13-10-31.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Custom)

- (id)nObjectForKey:(id)aKey;

- (NSString *)autoDescription;

@end
