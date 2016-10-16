//
//  NSString+trim.h
//
//  Copyright 2012 StepLeader Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (trim)

+ (NSString *)rvl_trim:(NSString *)original;
- (NSString *)rvl_trimString;
- (BOOL) rvl_isNotEmpty;
- (BOOL) rvl_isEmpty;
- (NSString *) rvl_md5Hash32;
- (NSString *) rvl_md5HashWithSalt32: (NSString*) salt;
- (NSString *) rvl_md5Hash64;
- (NSString *) rvl_md5HashWithSalt64: (NSString*) salt;

@end
