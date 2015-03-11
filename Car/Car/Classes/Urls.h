//
//  Urls.h
//  Car
//
//  Created by System Administrator on 10/10/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Urls : NSObject

+(NSString*)BaseUrl;
+(NSURL*)Login;
+(NSURL*)Main;

+(NSString*)FixImageUrlToStr:(NSString*)url;
+(NSURL*)FixImageUrlToUrl:(NSString*)url;

@end
