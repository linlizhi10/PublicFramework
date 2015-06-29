//
//  FMDatabaseEx.m
//  Truekey
//
//  Created by Truekey on 09/02/2014.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FMDatabaseEx.h"
@interface FMDatabaseEx(Ex)
+ (BOOL) copyDatabaseIfNeeded:(NSString *)dbPath;
@end

@implementation FMDatabaseEx

+ (NSString *) getDbPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *path = [documentsDir stringByAppendingPathComponent:@"words.sqlite"];
    NSLog(@"%@",path);
	[self copyDatabaseIfNeeded:path];
	return path;
}

+ (BOOL) copyDatabaseIfNeeded:(NSString *)dbPath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	// TODO
//  	[fileManager removeItemAtPath:dbPath error:NULL];//zzl
	
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

@end
