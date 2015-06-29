//
//  DatabaseModel.m
//  真题词汇
//
//  Created by Tom on 15/3/10.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "DatabaseModel.h"
#import "FMDatabaseEx.h"

@implementation DatabaseModel

+ (DatabaseModel *)sharedDatabaseModel
{
    static DatabaseModel *instance = nil;;
    @synchronized(instance)
    {
        if (instance == nil) {
            instance = [[DatabaseModel alloc] init];
        }
    }
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@^^^^^^^^^^^^^^^",[FMDatabaseEx getDbPath]);
        fmdb = [[FMDatabase alloc] initWithPath:[FMDatabaseEx getDbPath]];
//        [self openDB];
//        NSString *sqlstr = [NSString stringWithFormat:@"DELETE from coinruleUpdate" ];
//        if ([fmdb executeUpdate:sqlstr]) {
//            NSLog(@"删除成功");
//        }
    }
    return self;
}

- (BOOL)openDB {
    BOOL type = [fmdb open];
    return type;
}

- (void)closeDB {
    [fmdb close];
}

#pragma mark -
- (BOOL) copyDatabaseIfNeeded:(NSString *)dbPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if(!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"words.sqlite"];
        NSLog(@"defaultDBPath:%@",defaultDBPath);
        NSLog(@"dbPath:%@",dbPath);
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return NO;
        }
    }
    return YES;
}
- (NSString *) getDBpath {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"words.sqlite"];
    NSLog(@"%@",path);
//    [self copyDatabaseIfNeeded:path];
    return path;
}

- (NSString *)stringNil:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    return str;
}

- (NSMutableArray *)wordsFrom:(NSArray *)group
{
    NSMutableArray *words = [NSMutableArray array];
    if ([self openDB]) {
        NSString *cond = @"";
        for(NSDictionary *dic in group) {
            cond = [cond stringByAppendingString:[NSString stringWithFormat:@"\'%@\',", [dic objectForKey:@"id"]]];
        }
        NSString *sqlStr = [NSString stringWithFormat:@"select * from Thesaurus where wordId in ( %@ \'\')", cond];
        FMResultSet *rs = [fmdb executeQuery:sqlStr];
        while ([rs next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[rs stringForColumn:@"wordId"] forKey:@"wordId"];
            [dic setValue:[rs stringForColumn:@"wordType"] forKey:@"wordType"];
            [dic setValue:[rs stringForColumn:@"wordHead"] forKey:@"wordHead"];
            [dic setValue:[rs stringForColumn:@"wordEnPhonetic"] forKey:@"wordEnPhonetic"];
            [dic setValue:[rs stringForColumn:@"wordUsPhonetic"] forKey:@"wordUsPhonetic"];
            [dic setValue:[rs stringForColumn:@"wordMacroAttribute"] forKey:@"wordMacroAttribute"];
            [dic setValue:[rs stringForColumn:@"wordMeaning"] forKey:@"wordMeaning"];
            [dic setValue:[rs stringForColumn:@"wordEnSentence"] forKey:@"wordEnSentence"];
            [dic setValue:[rs stringForColumn:@"wordChSentence"] forKey:@"wordChSentence"];
            [dic setValue:[rs stringForColumn:@"englishExample"] forKey:@"englishExample"];
            [dic setValue:[rs stringForColumn:@"chineseExample"] forKey:@"chineseExample"];
            [words addObject:dic];
        }
    }
    [self closeDB];
    
    return words;
}


- (NSMutableArray *)queryWordDetailByWordId:(NSString *)wordId
{
    NSMutableArray *words = [NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from Thesaurus where wordId = '%@'", wordId];
        FMResultSet *rs = [fmdb executeQuery:sqlStr];
        while ([rs next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[rs stringForColumn:@"wordId"] forKey:@"wordId"];
            [dic setValue:[rs stringForColumn:@"wordType"] forKey:@"wordType"];
            [dic setValue:[rs stringForColumn:@"wordHead"] forKey:@"wordHead"];
            [dic setValue:[rs stringForColumn:@"wordEnPhonetic"] forKey:@"wordEnPhonetic"];
            [dic setValue:[rs stringForColumn:@"wordUsPhonetic"] forKey:@"wordUsPhonetic"];
            [dic setValue:[rs stringForColumn:@"wordMacroAttribute"] forKey:@"wordMacroAttribute"];
            [dic setValue:[rs stringForColumn:@"wordMeaning"] forKey:@"wordMeaning"];
            [dic setValue:[rs stringForColumn:@"wordEnSentence"] forKey:@"wordEnSentence"];
            [dic setValue:[rs stringForColumn:@"wordChSentence"] forKey:@"wordChSentence"];
            [dic setValue:[rs stringForColumn:@"englishExample"] forKey:@"englishExample"];
            [dic setValue:[rs stringForColumn:@"chineseExample"] forKey:@"chineseExample"];
            [words addObject:dic];
        }
    }
    [self closeDB];
    
    return words;
}

@end
