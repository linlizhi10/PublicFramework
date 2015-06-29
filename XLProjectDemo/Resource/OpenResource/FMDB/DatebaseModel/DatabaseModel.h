//
//  DatabaseModel.h
//  真题词汇
//
//  Created by Tom on 15/3/10.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface DatabaseModel : NSObject

{
    FMDatabase *fmdb;
    
}
//单利
+ (DatabaseModel *)sharedDatabaseModel;

- (NSMutableArray *)wordsFrom:(NSArray *)group;
- (NSMutableArray *)queryWordDetailByWordId:(NSString *)wordId;

@end
