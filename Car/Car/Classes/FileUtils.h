//
//  FileUtils.h
//  AiCaiPiao
//
//  Created by likunding on 13-11-1.
//  Copyright (c) 2013年 likunding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+(void)createDirectory:(NSString *)dirName;
+(void)writeFile:(NSString *)data :(NSString*) filename:(NSString*) filepath;
+(NSString *)readFile:(NSString *)filename :(NSString*) filepath;

+(void)setCache:(id)content filename:(NSString*)filename;
+(id)getCache:(NSString *)filename;
@end
