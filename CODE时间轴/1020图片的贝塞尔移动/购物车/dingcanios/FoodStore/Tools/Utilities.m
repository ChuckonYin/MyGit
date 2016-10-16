//
//  Utilities.m
//  Utilities
//
//  Created by liuguopan on 14-12-4.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

@end

@implementation Utilities (identifier)

+ (NSString *)identifierFromUUID
{
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)identifierWithPrefix:(NSString *)pref suffix:(NSString *)suff
{
    return [pref stringByAppendingFormat:@"||%@", suff];
}

+ (NSString *)prefixOfIdentifier:(NSString *)identifier
{
    return [Utilities stringOfIdentifire:identifier flag:NO];
}

+ (NSString *)suffixOfIdentifier:(NSString *)identifier
{
    return [Utilities stringOfIdentifire:identifier flag:YES];
}

+ (NSString *)stringOfIdentifire:(NSString *)identifier flag:(BOOL)isSuff
{
    int index = (int)isSuff;
    NSArray *arr = [identifier componentsSeparatedByString:@"||"];
    if (arr.count >= index) {
        return [arr objectAtIndex:index];
    }
    return nil;
}

@end

@implementation Utilities (Date)

+ (NSString *)currentDate
{
    return [Utilities currentDateWithFormat:@"YYYYMMddHHmmss"];
}

+ (NSString *)currentDateWithDefaultFormat
{
    return [Utilities currentDateWithFormat:@"YYYY-MM-dd HH:mm:ss"];
}

+ (NSString *)currentDateWithFormat:(NSString *)format
{   
    if (nil != format && format.length >= 2) {
        return [[Utilities dateFormatter:format] stringFromDate:[NSDate date]];
    }
    return nil;
}

+ (NSString *)transformDate:(NSString *)date fromOldFormat:(NSString *)oldf toNewFormat:(NSString *)newf
{
    if (nil == date || date.length < 2 ||
        nil == oldf || oldf.length < 2 ||
        nil == newf || newf.length < 2) {
        return nil;
    }
    NSDate *d = [[Utilities dateFormatter:oldf] dateFromString:date];
    if (nil == d) {
        return nil;
    }
    return [[Utilities dateFormatter:newf] stringFromDate:d];
}

+ (NSDateFormatter *)dateFormatter:(NSString *)format
{
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:format];
    return datef;
}

@end

@implementation Utilities (Path)

+ (NSString *)sandboxPath
{
    return NSHomeDirectory();
}

+ (NSString *)bundlePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)documentsPath
{
    return [[Utilities paths:NSDocumentDirectory] objectAtIndex:0];
}

+ (NSString *)libraryPath
{
    return [[Utilities paths:NSLibraryDirectory] objectAtIndex:0];
}

+ (NSString *)cachesPath
{
    return [[Utilities paths:NSCachesDirectory] objectAtIndex:0];
}

+ (NSString *)tmpPath;
{
    return NSTemporaryDirectory();
}

+ (NSString *)fileAtDocuments:(NSString *)fileName
{
    return [[Utilities documentsPath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)fileAtLibrary:(NSString *)fileName
{
    return [[Utilities libraryPath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)fileAtCaches:(NSString *)fileName
{
    return [[Utilities cachesPath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)fileAtTmp:(NSString *)fileName
{
    return [[Utilities tmpPath] stringByAppendingPathComponent:fileName];
}

+ (NSArray *)paths:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
}


#pragma mark Local

+ (NSString *)localPath
{
    return [Utilities fileAtDocuments:@"Local"];
}

@end

@implementation Utilities (File)

+ (BOOL)fileExistAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)fileAtDocumentsExist:(NSString *)fileName
{
    return [Utilities fileExistAtPath:[Utilities fileAtDocuments:fileName]];
}

+ (BOOL)fileAtLibraryExist:(NSString *)fileName
{
    return [Utilities fileExistAtPath:[Utilities fileAtLibrary:fileName]];
}

+ (BOOL)fileAtCachesExist:(NSString *)fileName
{
    return [Utilities fileExistAtPath:[Utilities fileAtCaches:fileName]];
}

+ (BOOL)fileAtTmpExist:(NSString *)fileName
{
    return [Utilities fileExistAtPath:[Utilities fileAtTmp:fileName]];
}

+ (BOOL)createFolderAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)createFolderAtDocument:(NSString *)folderName
{
    return [Utilities createFolderAtPath:[Utilities documentsPath] folderName:folderName];
}

+ (BOOL)createFolderAtLibrary:(NSString *)folderName
{
    return [Utilities createFolderAtPath:[Utilities libraryPath] folderName:folderName];
}

+ (BOOL)createFolderAtCaches:(NSString *)folderName
{
    return [Utilities createFolderAtPath:[Utilities cachesPath] folderName:folderName];
}

+ (BOOL)createFolderAtTmp:(NSString *)folderName
{
    return [Utilities createFolderAtPath:[Utilities tmpPath] folderName:folderName];
}

+ (BOOL)createFolderAtPath:(NSString *)path folderName:(NSString *)folderName
{
    if (![NSString availableString:folderName lengthNotZero:YES]) {
        return NO;
    }
    NSString *fullPath = [path stringByAppendingPathComponent:folderName];
    if ([Utilities fileExistAtPath:fullPath]
        || [Utilities createFolderAtPath:fullPath]) {
        return YES;
    }
    
    fullPath = path;
    NSArray *arr = [folderName componentsSeparatedByString:@"/"];
    for (int i = 0; i < arr.count; i++) {
        fullPath = [fullPath stringByAppendingPathComponent:arr[i]];
        if (![Utilities fileExistAtPath:fullPath]
            && ![Utilities createFolderAtPath:fullPath]) {
            return NO;
        }
    }
    return YES;
}


#pragma 复制数据库food.db到Local文件夹下

//+ (BOOL)copy

@end
