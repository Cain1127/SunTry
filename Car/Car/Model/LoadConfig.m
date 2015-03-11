//
//  LoadConfig.m
//  Car
//
//  Created by System Administrator on 10/25/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "LoadConfig.h"
#import "Post.h"
#import "FileUtils.h"
#import "QSCatalog.h"
#import "MJExtension.h"
#import "AppDelegate.h"

@implementation LoadConfig
- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)initData:(UIView*)view
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES] ;
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:@"100000" forKey:@"page_num"];
    [paramDic setValue:@"" forKey:@"now_page"];
    [paramDic setValue:@"GREENSTAG" forKey:@"key"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        if(error == nil){
            NSDictionary *configBaseArray = (NSDictionary*)posts;
            NSArray* configArray = [configBaseArray objectForKey:@"records"];
            for (NSDictionary* tagDic in configArray) {
                [delegate.CATALOGARRAYT addObject:tagDic];
            }
            [FileUtils setCache:configArray filename:CATALOGCACHE];
        }else{
            NSArray *configArray = [FileUtils getCache:CATALOGCACHE];
            for (NSDictionary* tagDic in configArray) {
                [delegate.CATALOGARRAYT addObject:tagDic];
            }
        
        }
    }:@"tag/list" parameters:paramDic fileName:CATALOGCACHE];
    
    NSMutableDictionary *paramDic1 = [[NSMutableDictionary alloc]init];
    [paramDic1 setValue:@"1" forKey:@"merchant_id"];
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [HUD setHidden:YES];
        if(error == nil){
            
            NSArray *carArray = (NSArray*)posts;
            for (NSDictionary* tagDic in carArray) {
                [delegate.ALLCARARRAY addObject:tagDic];
            }
            [FileUtils setCache:carArray filename:CARCACHE];

        }else{
            NSArray *configArray = [FileUtils getCache:CARCACHE];
            if(configArray != nil){
                for (NSDictionary* tagDic in configArray) {
                    [delegate.ALLCARARRAY addObject:tagDic];
                }
            }
            
        }
    }:@"car/allcar" parameters:paramDic1 fileName:@""];
                
}

@end
