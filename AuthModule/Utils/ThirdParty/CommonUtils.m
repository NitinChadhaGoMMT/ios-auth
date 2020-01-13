//
//  CommonUtils.m
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

#import "CommonUtils.h"

#import <CommonCrypto/CommonHMAC.h>

@implementation CommonUtils

+ (NSString *) md5Hash:(NSString*) stringToHash {
    if (!stringToHash || !stringToHash.length) {
        stringToHash = @"";
        NSLog(@"Invalid string to hash");
    }
    const char *str = [stringToHash UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    
    NSMutableString *hashStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hashStr appendFormat:@"%02x", r[i]];
    
    return hashStr;
}


@end
