//
//  Urls.m
//  Car
//
//  Created by System Administrator on 10/10/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "Urls.h"

NSString *baseUrl = @"http://117.41.235.110:8090/";
NSString *fileUrl = @"http://117.41.235.110:9100/files/";

@implementation Urls
+(NSString*)BaseUrl
{
    return baseUrl;
}
+(NSURL*)Login
{
    return [NSURL URLWithString:[baseUrl stringByAppendingString:@"User/Login"]];
}
+(NSURL*)Main
{
    return [NSURL URLWithString:[baseUrl stringByAppendingString:@"User/main"]];
}

+(NSString*)FixImageUrl:(NSString*)url
{
    if ([url rangeOfString:@"http"].location != NSNotFound) {
        return url;
    }else{
        NSString* encodedString = [[fileUrl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return encodedString;
    }
}

+(NSURL*)FixImageUrlToUrl:(NSString*)url
{
    if ([url rangeOfString:@"http"].location != NSNotFound) {
        return [NSURL URLWithString:url];
    }else{
        NSString* encodedString = [[fileUrl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [NSURL URLWithString:encodedString];
    }
}

+(NSString*)FixImageUrlToStr:(NSString*)url{
    if ([url rangeOfString:@"http"].location != NSNotFound) {
        return url;
    }else{
        NSString* encodedString = [[fileUrl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return encodedString;
    }
}

@end
