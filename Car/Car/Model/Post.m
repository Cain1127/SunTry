// Post.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Post.h"

#import "AFAppDotNetAPIClient.h"
#import "QSStringUtils.h"
#import "User.h"
#import <CommonCrypto/CommonDigest.h>


@implementation Post

#define CustomErrorDomain @"com.iQuentin.error"
typedef enum {
    XDefultFailed = -1000
}CustomErrorFailed;

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    

    
    return self;
}

#pragma mark - globalTimelinePostsWithBlock
+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(id posts, NSError *error))block:(NSString*)url  parameters:(NSMutableDictionary *)parameters fileName:(NSString*)cacheFile{
    
    NSMutableDictionary *params;
    if(parameters != nil){
        params = [self SetParams:parameters];
    }else{
        parameters = [[NSMutableDictionary alloc]init];
        params = [self SetParams:parameters];
    }
    
    NSLog(@"k:%@--d:%@--t:%@",[params objectForKey:@"k"],[params objectForKey:@"d"],[params objectForKey:@"t"]);
    
    return [[AFAppDotNetAPIClient sharedClient] POST:url parameters:params success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSString *postsFromResponseType = [JSON valueForKeyPath:@"type"];
        if([postsFromResponseType intValue] == 1){
            id postsFromResponse = [JSON valueForKeyPath:@"msg"];
            if (![QSStringUtils isBlankString:cacheFile]) {
                
            }
            
            if (block) {
                block(postsFromResponse, nil);
            }
        }else{
            id postsFromResponse = [JSON valueForKeyPath:@"msg"];
            if (block) {
                NSError *error = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:nil];
                block(postsFromResponse,error);
            }
        }

    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


+(NSMutableDictionary*)SetParams:(NSMutableDictionary*)params
{
    NSDate *date = [NSDate date];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *t = [NSString stringWithFormat:@"%li",(long)timestamp];
    
    User *user = [User sharedInstance];
//    [user Logout];
    if ([user getUid]>0) {
        [params setValue:[NSString stringWithFormat:@"%d",[user getUid]] forKey:@"user_id"];
    }else{
        [params setValue:@"0" forKey:@"user_id"];
    }
    
    NSString *d;
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSError *error;
        NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        d = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];
    }
    NSString *key = MKEY;
    NSString *k_key = [t stringByAppendingString:key];
    NSString *k_temp = [d stringByAppendingString:k_key];
    NSString *k = [Post md5:k_temp];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setObject:k forKey:@"k"];
    [data setObject:d forKey:@"d"];
    [data setObject:t forKey:@"t"];
    
   
    
    return data;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
