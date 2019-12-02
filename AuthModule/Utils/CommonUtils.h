//
//  CommonUtils.h
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtils : NSObject

+(NSString *) md5Hash:(NSString*) stringToHash;

@end

NS_ASSUME_NONNULL_END
