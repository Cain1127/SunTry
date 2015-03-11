//
//  ProgressViewController.m
//  DateApp
//
//  Created by likunding on 14-8-6.
//  Copyright (c) 2014年 likunding. All rights reserved.
//

#import "ProgressViewController.h"
#import "TimeUtils.h"
#import <UIImageView+AFNetworking.h>
#import "Urls.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "TimeUtils.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MBProgressHUD *HUD;
    if(HUD==nil){
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
    }else{
        [HUD setHidden:NO];
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[NSString stringWithFormat:@"%@",_bid] forKey:@"order_id"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        
        [HUD setHidden:YES];
        
        if(error == nil){
            
            
            NSDictionary* orderLogDic = (NSDictionary*)posts;
            NSArray* orderLogArray = [orderLogDic objectForKey:@"records"];
            
            for (NSDictionary* dataDic in orderLogArray) {
                int status = [[dataDic objectForKey:@"status"] intValue];
                switch (status) {
                    case 1:
                        [_take1View setHidden:NO];
                        [_time1Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                        
                    case 2:
                        [_take2View setHidden:NO];
                        [_time2Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                        
                    case 3:
                        [_take3View setHidden:NO];
                        [_time3Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                        
                    case 4:
                        [_take4View setHidden:NO];
                        [_time4Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                        
                    case 5:
                        [_take5View setHidden:NO];
                        [_time5Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                    case 6:
                        [_take5View setHidden:NO];
                        [_time5Lbl setText:[TimeUtils TimeToString:[[dataDic objectForKey:@"time"] intValue]]];
                        break;
                        
                    default:
                        break;
                }
            }
            

            
        }else{
            if(error.code == -1000){
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                
            }else{
                [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
            }
        }
        
    }:@"orderLog/detail" parameters:parameters fileName:@""];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
}
@end
