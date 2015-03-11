//
//  ValidateUtils.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateUtils : NSObject

+(BOOL)validateEmail:(NSString*)email;
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL)validateMobile:(NSString *)mobileNum;


@end
