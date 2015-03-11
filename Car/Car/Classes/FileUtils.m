//
//  FileUtils.m
//  AiCaiPiao
//
//  Created by likunding on 13-11-1.
//  Copyright (c) 2013年 likunding. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

+(void)createDirectory:(NSString *)dirName
{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Caches/%@", NSHomeDirectory(), dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


+(void)writeFile:(NSString *)data :(NSString*) filename  :(NSString*) filepath
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* DocumentDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:filepath];
   

    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:DocumentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    
    //3、更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[DocumentDirectory stringByExpandingTildeInPath]];
    //4、创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
//    [fileManager removeItemAtPath:filename error:nil];
    
    NSString *path = [DocumentDirectory stringByAppendingPathComponent:filename];
    if (![fileManager fileExistsAtPath:filename]) {
        [fileManager createFileAtPath:filename contents:nil attributes:nil];
    }
    
    //5、创建数据缓冲区
    NSMutableData  *writer = [[NSMutableData alloc] init];
    //6、将字符串添加到缓冲中
    [writer appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    //7、将其他数据添加到缓冲中
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];
}

+(NSString *)readFile:(NSString *)filename :(NSString*) filepath
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:filepath];
    
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //获取文件路劲
    NSString* path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData* reader = [NSData dataWithContentsOfFile:path];
    return [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
}

+(void)setCache:(id)content filename:(NSString*)filename
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:filename];
    NSLog(@"%@",path);
    NSMutableData *data = [[NSMutableData alloc] init] ;
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data] ;
    
    [archiver encodeObject:content forKey:@"keys"];
    [archiver finishEncoding];
    if([data writeToFile:path atomically:YES]){
        NSLog(@"对象存入文件成功");
    }else{
        NSLog(@"对象存入文件失败");
    }
}
+(id)getCache:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:filename];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id content = [unArchiver decodeObjectForKey:@"keys"];
    return content;
}


@end
