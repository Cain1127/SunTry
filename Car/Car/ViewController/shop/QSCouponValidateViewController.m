//
//  QSCouponValidateViewController.m
//  Car
//
//  Created by System Administrator on 10/21/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSCouponValidateViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "QSShopCart.h"

@interface QSCouponValidateViewController ()
{
    QSShopCart *shopCart;
}
@end

@implementation QSCouponValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    shopCart = [[QSShopCart alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)OkBtn:(id)sender {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:_couponTextField.text forKey:@"coup_key"];

    MBProgressHUD *HUD;
    if(HUD == nil){
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
    }else{
        [HUD setHidden:NO];
    }
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        [HUD setHidden:true];
        if(error == nil){
            
            NSDictionary* tempDic = (NSDictionary*)posts;
            [shopCart addCoupon:[tempDic objectForKey:@"id"] coupon_name:[tempDic objectForKey:@"goods_name"] coupon_type:[tempDic objectForKey:@"type"] coupon_money:[tempDic objectForKey:@"pice"] begin_time:[tempDic objectForKey:@"expant_2"] end_time:[tempDic objectForKey:@"expant_3"] menu_list:[tempDic objectForKey:@"label"]];
            [QSUIHelper showTip:self.view tipStr:@"验证成功"];
        }else{
            if(error.code == -1000){
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }
        }
    }:@"promotion/getCoupon" parameters:paramDic fileName:@""];
}
@end
