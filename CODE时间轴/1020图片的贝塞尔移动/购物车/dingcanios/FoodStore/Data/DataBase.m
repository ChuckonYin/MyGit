//
//  DataBase.m
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "DataBase.h"
#import "FMDatabase.h"
#import "Model.h"
#import "Public.h"

#if DEBUG
#define Log(content) NSLog(@"\n\nDataBase -- %@\n\n", content)
#define Log_Format(format, ...) NSLog(@"\n\n"format@"\n\n", ## __VA_ARGS__);
#else
#define Log(content)
#define Log_Format(format, ...)
#endif

#define Client_Database_Name    @"food.db"

@interface DataBase () {
@private
    NSString    *_dbName;
    FMDatabase  *_dataBase;
    BOOL        _openDBOk;
}

@end

@implementation DataBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dbName = Client_Database_Name;
        _openDBOk = NO;
        NSString *dbPath = [self copyDBFileToDocument:_dbName];
        if (dbPath) {
            _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
            [self openDB];
        } else {
            Log(@"Database path is nil!");
        }
    }
    return self;
}

- (void)dealloc
{
    [_dataBase close];
    _dataBase = nil;
}

- (NSString *)copyDBFileToDocument:(NSString *)sqlName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *localPath = [documentDir stringByAppendingPathComponent:@"Local"];
    if (![fileManager fileExistsAtPath:localPath]) {
        [fileManager createDirectoryAtPath:localPath
                         withIntermediateDirectories:YES
                         attributes:nil
                         error:nil];
    }
    
    NSString *dbPath = [localPath stringByAppendingPathComponent:_dbName];
    if ([fileManager fileExistsAtPath:dbPath]) {
        return dbPath;
    }
    
    NSString *resourceDBPath = [[[NSBundle mainBundle] bundlePath]
                                   stringByAppendingPathComponent:sqlName];
    if (![fileManager fileExistsAtPath:resourceDBPath]) {
        Log(@"Resource `food.db` file is not exist!");
        return nil;
    }
    
    if (![fileManager copyItemAtPath:resourceDBPath toPath:localPath error:&error]) {
        Log_Format(@"Failed to create writable database %@, %@", sqlName, error.localizedFailureReason);
    }
    return dbPath;
}

- (void)openDB
{
    if (![_dataBase open]) {
        Log(@"Client sqlite open FAIL!");
    } else {
        _openDBOk = YES;
        Log(@"Client sqlite open OK!");
    }
}

- (void)closeDB
{
    if (![_dataBase close]) {
        Log(@"Client sqlite close FAIL!");
    } else {
        _openDBOk = NO;
        Log(@"Client sqlite close OK!");
    }
}

+ (NSString *)getSafeValueWithDict:(NSDictionary *)dict key:(NSString *)key
{
    NSString *value = nil;
    if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
        value = NULL;
    } else {
        value = [NSString stringWithFormat:@"%@", [dict objectForKey:key]];
    }
    return value;
}

- (BOOL)modifyDatabaseWithSqlSentence:(NSString *)sqlSentence
{
    @synchronized(self) {
        if (!_openDBOk) {
            [self openDB];
        }
        
        NSError *error = 0x00;
        BOOL result = [_dataBase update:sqlSentence withErrorAndBindings:&error];
        
        if (!result) {
            Log_Format(@"Database modify failed%@%@",
                           error ? @" error is " : @"",
                           error ? error.localizedFailureReason : @"");
        } else {
            Log(@"Database modify successed!");
        }
        return result;
    }
}

- (NSMutableArray *)selectWithSqlSentence:(NSString *)sqlSentence
{
    @synchronized(self) {
        if (!_openDBOk) {
            [self openDB];
        }
        
        FMResultSet *resultSet = [_dataBase executeQuery:sqlSentence];
        NSMutableArray *resultArr = [[NSMutableArray alloc] init];
        
        while ([resultSet next]) {
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[resultSet resultDictionary]];
            [resultArr addObject:dict];
        }
        return resultArr;
    }
}

@end
