//
//  TimeUtils.h
//  DateApp
//
//  Created by likunding on 14-6-19.
//  Copyright (c) 2014年 likunding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtils : NSObject

+(NSString *)TimeToString:(int)time;
+(NSString *)TimeToDate:(int)time;
+(int)StringToInt:(NSString*)time;
+(NSString *)TimeToDateCustom:(int)time Format:(NSString*)format;

@end
