//
//  QSStringUtils.h
//  Car
//
//  Created by System Administrator on 10/11/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSStringUtils : NSObject

+ (BOOL)isBlankString:(NSString *)string;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureFloat:(NSString*)string;

@end
