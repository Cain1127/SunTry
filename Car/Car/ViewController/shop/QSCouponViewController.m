//
//  QSCouponViewController.m
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSCouponViewController.h"
#import "QSUseCouponCell.h"
#import "Post.h"
#import "QSShopCart.h"
#import <MBProgressHUD.h>
#import "MJExtension.h"
#import "Menu.h"


@interface QSCouponViewController ()
{
    QSShopCart* shopCart;
    NSInteger selected;
}

@end

@implementation QSCouponViewController


@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _couponTableView.dataSource = self;
    _couponTableView.delegate = self;
    [QSUIHelper setExtraCellLineHidden:_couponTableView];
 

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:@"1" forKey:@"mer_id"];
    [paramDic setValue:@"" forKey:@"key"];
    [paramDic setObject:@[@"6",@"7"] forKey:@"type"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        [HUD setHidden:true];
        if(error == nil){
            
            NSDictionary* tempDic = (NSDictionary*)posts;
            NSArray* tempArrar = [tempDic objectForKey:@"records"];
            _dataArray = [[Menu objectArrayWithKeyValuesArray:tempArrar] copy];
            
            if ([_dataArray count]>0) {
                [_couponTableView reloadData];
            }else{
                UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-20, 200, 40)];
                titleLbl.textAlignment = UITextAlignmentCenter;
                [titleLbl setText:SHOP_NO_COUPON];
                [self.view addSubview:titleLbl];
            }
        }else{
            if(error.code == -1000){
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }
        }
    }:@"goods/list" parameters:paramDic fileName:@""];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataArray.count == 0||_dataArray == nil){
        return 0;
    }else{
        return _dataArray.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Menu* menu = [_dataArray objectAtIndex:indexPath.row];
  
    QSUseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QSUseCouponCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QSUseCouponCell" owner:self options:nil] lastObject];
    }
    
    [cell.nameLbl setText:menu.goods_name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Menu* menu = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"...%@",menu.id);
    shopCart = [[QSShopCart alloc]init];
    [shopCart addCoupon:[NSString stringWithFormat:@"%@",menu.id] coupon_name:menu.goods_name coupon_type:menu.type coupon_money:menu.pice begin_time:menu.expant_2 end_time:menu.expant_3 menu_list:[menu label]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(JoinBtnClicked:)]) {
        [self.delegate JoinBtnClicked:@"1"];
    }
}


- (IBAction)joinBtnAct:(id)sender {

}


@end
