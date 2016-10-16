//
//  Utilities.h
//  Utilities
//
//  Created by liuguopan on 14-12-4.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  工具类
 */
@interface Utilities : NSObject

@end

@interface Utilities (identifier)

+ (NSString *)identifierFromUUID;
+ (NSString *)identifierWithPrefix:(NSString *)pref suffix:(NSString *)suff;
+ (NSString *)prefixOfIdentifier:(NSString *)identifier;
+ (NSString *)suffixOfIdentifier:(NSString *)identifier;

@end

@interface Utilities (Date)

/**
 *  @brief      当前时间
 *  @abstract   使用默认格式`YYYYMMddHHmmss`(24h制)
 *  @return     NSString *
 */
+ (NSString *)currentDate;

/**
 *  @brief      当前时间
 *  @abstract   使用默认格式`YYYY-MM-dd HH:mm:ss`(24h制)
 *  @return     NSString *
 */
+ (NSString *)currentDateWithDefaultFormat;

/**
 *  @brief      当前时间
 *  @abstract   使用自定义格式，形如：`YYYY/MM/dd hh:mm`,`MM-dd-hh-mm`等(12h制)
 *  @return     NSString *
 */
+ (NSString *)currentDateWithFormat:(NSString *)format;

/**
 *  @brief      时间格式转化
 *  @example    `20141210165811`(`YYYYMMddHHmmss`) --> `2014-12-10 04:58:11`(`YYYY-MM-dd hh:mm:ss`)
 *                   [Utilities transformDate:@"20141210165811"
 *                              fromOldFormat:@"YYYYMMddHHmmss"
 *                                toNewFormat:@"YYYY-MM-dd hh:mm:ss"];
 *  @return     NSString *  (如果参数格式不正确，返回nil)
 */
+ (NSString *)transformDate:(NSString *)date fromOldFormat:(NSString *)oldf toNewFormat:(NSString *)newf;

@end

//  文件目录
@interface Utilities (Path)

/**
 *  @brief      获取沙盒路径
 *  @return     NSString *
 */
+ (NSString *)sandboxPath;

/**
 *  @brief      获取Documents路径
 *  @return     NSString *
 */
+ (NSString *)documentsPath;

/**
 *  @brief      获取Library路径
 *  @return     NSString *
 */
+ (NSString *)libraryPath;

/**
 *  @brief      获取Caches路径
 #  @abstract   `.../Library/Caches`
 *  @return     NSString *
 */
+ (NSString *)cachesPath;

/**
 *  @brief      获取tmp路径
 *  @return     NSString *
 */
+ (NSString *)tmpPath;

/**
 *  @brief      获取Documents文件夹下fileName全路径
 *  @example    [Utilities fileAtDocuments:@"Download/Resource/Pics"]   
 *                  返回`.../Documents/Download/Resource/Pics`(...表示沙盒路径)
 *  @return     NSString *
 */
+ (NSString *)fileAtDocuments:(NSString *)fileName;

/**
 *  @brief      获取Library文件夹下fileName全路径
 *  @example    [Utilities fileAtLibrary:@"Download/Resource/Pics"]
 *                  返回`.../Library/Download/Resource/Pics`(...表示沙盒路径)
 *  @return     NSString *
 */
+ (NSString *)fileAtLibrary:(NSString *)fileName;

/**
 *  @brief      获取Library/Caches文件夹下fileName全路径
 *  @example    [Utilities fileAtCaches:@"Download/Resource/Pics"]
 *                  返回`.../Library/Caches/Download/Resource/Pics`(...表示沙盒路径)
 *  @return     NSString *
 */
+ (NSString *)fileAtCaches:(NSString *)fileName;

/**
 *  @brief      获取tmp文件夹下fileName全路径
 *  @example    [Utilities fileAtTmp:@"Download/Resource/Pics"]
 *                  返回`.../tmp/Download/Resource/Pics`(...表示沙盒路径)
 *  @return     NSString *
 */
+ (NSString *)fileAtTmp:(NSString *)fileName;

/**
 *  @brief      获取Local文件路径
 *  @return     `~/Documents/Local`(NSString * )
 */
+ (NSString *)localPath;

@end

//  文件
@interface Utilities (File)

/**
 *  @brief      在Docements文件夹下创建目录
 *  @param      `folderName` 文件名字，如`Download`,`Download/Resource`等
 *  @return     BOOL    YES:创建成功 NO:创建失败
 */
+ (BOOL)createFolderAtDocument:(NSString *)folderName;

/**
 *  @brief      在Library文件夹下创建目录
 *  @param      `folderName` 文件名字，如`Download`,`Download/Resource`等
 *  @return     BOOL    YES:创建成功 NO:创建失败
 */
+ (BOOL)createFolderAtLibrary:(NSString *)folderName;

/**
 *  @brief      在Caches文件夹下创建目录
 *  @param      `folderName` 文件名字，如`Download`,`Download/Resource`等
 *  @return     BOOL    YES:创建成功 NO:创建失败
 */
+ (BOOL)createFolderAtCaches:(NSString *)folderName;

/**
 *  @brief      在tmp文件夹下创建目录
 *  @param      `folderName` 文件名字，如`Download`,`Download/Resource`等
 *  @return     BOOL    YES:创建成功 NO:创建失败
 */
+ (BOOL)createFolderAtTmp:(NSString *)folderName;

@end

