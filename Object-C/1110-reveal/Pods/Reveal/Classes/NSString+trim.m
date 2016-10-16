//
//  NSString+trim.m
//
//  Copyright 2012 StepLeader Inc. All rights reserved.
//


#import "NSString+trim.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (trim)

+ (NSString *) rvl_trim:(NSString *)original {
	NSMutableString * copy = [original mutableCopy];
	return [NSString stringWithString:[copy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (NSString *) rvl_trimString {
	NSMutableString * copy = [self mutableCopy];
	return [NSString stringWithString:[copy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (BOOL) rvl_isNotEmpty {
	return ! [self isEqualToString:@""];
}

- (BOOL) rvl_isEmpty {
	return [self isEqualToString:@""]; 
}

// Function definition
// creates a 64 character hash

- (NSString *) rvl_md5Hash64 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
	return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X"
                                     @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
        result[0], result[1],
        result[2], result[3],
        result[4], result[5],
        result[6], result[7],
        result[8], result[9],
        result[10], result[11],
        result[12], result[13],
        result[14], result[15],
        result[0], result[1],
        result[2], result[3],
        result[4], result[5],
        result[6], result[7],
        result[8], result[9],
        result[10], result[11],
        result[12], result[13],
        result[14], result[15]
        ];
}

// creates a 64 character hash with salt

- (NSString *) rvl_md5HashWithSalt64: (NSString*) salt {
    NSString* str = [NSString stringWithFormat: @"%@%@", self, salt];
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X"
                                       @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15],
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]
            ];
}

// creates a 32 character hash
- (NSString *) rvl_md5Hash32 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]
            ];
}

// creates a 32 character hash with salt
- (NSString *) rvl_md5HashWithSalt32: (NSString*) salt {
    NSString* str = [NSString stringWithFormat: @"%@%@", self, salt];
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]
            ];
}

@end

