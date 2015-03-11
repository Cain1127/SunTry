//
//  CouponActivity2TableViewController.m
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "CouponActivity2TableViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "Menu.h"
#import <UIImageView+AFNetworking.h>
#import <UIButton+AFNetworking.h>
#import "Urls.h"
#import "User.h"
#import "QSShopCart.h"

@interface CouponActivity2TableViewController ()
{
    int rowNum;
    NSMutableArray *dModel;
    int rowHeight;
    Menu *menuObj;
}
@end

@implementation CouponActivity2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QSUIHelper setExtraCellLineHidden:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [QSUIHelper hideTabbar];
    [QSUIHelper showHead:self.navigationController];
    
    dModel = [[NSMutableArray alloc]init];
    rowNum = 4;

    rowHeight = 170;
    
    self.tableView.allowsSelection = NO;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:_mid forKey:@"id"];
    [paramDic setValue:_type forKey:@"type"];
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        [HUD setHidden:YES];
        
        if(error == nil){
            NSDictionary* indexDic =(NSDictionary*)posts;
            NSLog(@"");
            menuObj = [Menu objectWithKeyValues:indexDic];
            
            [_couponImageView setImageWithURL:[Urls FixImageUrlToUrl:menuObj.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC]];
            
            self.title = menuObj.goods_name;
            
            [_contentWebView loadHTMLString:menuObj.expant_4 baseURL:nil];
            
            if(menuObj.greensList != nil){
                for (NSDictionary* menu in menuObj.greensList) {
                    Menu *menuDetail = [Menu objectWithKeyValues:menu];
                    [dModel addObject:menuDetail];
                }
                [self.tableView reloadData];
            }
            
            
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                
            }else{
                
            }
        }
        
    }:@"goods/get" parameters:paramDic fileName:@""];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [QSUIHelper showTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return rowNum;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            return 199;
            break;
        case 1:
            return 36;
            break;
        case 2:
            return 99;
            break;
            
        case 3:
        {
            int pheight = 170;
            
            int countRow = 0;
            if(dModel.count%2>0){
                countRow = dModel.count/2+1;
            }else{
                countRow = dModel.count/2;
            }
            
            rowHeight = countRow*170;
            
            return rowHeight;
            break;
        }
    }
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
            return _headCell;
            break;
        case 1:
            return _bodyCell;
            break;
        case 2:
            return _contentCell;
            break;
            
        case 3:
        {
            Menu *leftmenu;
            Menu *rightmenu;
            
            int pheight = 170;
            
            int numRow = 2;
            int countRow = 0;
            if(dModel.count%2>0){
                countRow = dModel.count/2+1;
            }else{
                countRow = dModel.count/2;
            }
            
            
            for (int i = 0; i < countRow; i++) {
                for (int j = 0; j < numRow; j++) {
                    long iTemp = i*numRow + j;
                    
                    int offsetHeight = pheight*i;
                    
                    if(j == 0){
                        leftmenu = [dModel objectAtIndex:iTemp];
                        UIButton *leftMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 , 10+offsetHeight,[UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
                        [leftMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:leftmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
                        leftMenuBtn.tag = iTemp;
                        [_foodCell addSubview:leftMenuBtn];
                        
                        UIButton *leftbuyBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4 - 25, 87+offsetHeight, 50, 50)];
                        leftbuyBtn.tag = iTemp;
                        [leftbuyBtn setImage:[UIImage imageNamed:@"main_shopBtn.png"] forState:UIControlStateNormal];
                        [leftbuyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                        [_foodCell addSubview:leftbuyBtn];
                        
                        UILabel *leftNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 130+offsetHeight, 100, 30)];
                        leftNameLbl.font = [UIFont systemFontOfSize:12];
                        [leftNameLbl setTextColor:[UIColor redColor]];
                        [leftNameLbl setText:leftmenu.goods_name];
                        [_foodCell addSubview:leftNameLbl];
                        
                        UILabel *leftPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 120 , 130+offsetHeight, 100, 30)];
                        leftPriceLbl.font = [UIFont systemFontOfSize:12];
                        [leftPriceLbl setTextColor:[UIColor redColor]];
                        leftPriceLbl.textAlignment = NSTextAlignmentRight;
                        [leftPriceLbl setText:[NSString stringWithFormat:@"￥%@",leftmenu.pice]];
                        
                        [_foodCell addSubview:leftPriceLbl];
                        
                    }else{
                        if(iTemp >= dModel.count){
                            break;
                        }
                        
                        rightmenu = [dModel objectAtIndex:iTemp];
                        
                        UIButton *rightMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 , 10+offsetHeight, [UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
                        [rightMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:rightmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
                        rightMenuBtn.tag = iTemp;
                        [_foodCell addSubview:rightMenuBtn];
                        
                        UIButton *rightbuyBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3 - 25 , 87+offsetHeight, 50, 50)];
                        rightbuyBtn.tag = iTemp;
                        [rightbuyBtn setImage:[UIImage imageNamed:@"main_shopBtn.png"] forState:UIControlStateNormal];
                        [rightbuyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                        [_foodCell addSubview:rightbuyBtn];
                        
                        UILabel *rightNameLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 130+offsetHeight, 100, 30)];
                        rightNameLbl.font = [UIFont systemFontOfSize:12];
                        [rightNameLbl setTextColor:[UIColor redColor]];
                        [rightNameLbl setText:rightmenu.goods_name];
                        [_foodCell addSubview:rightNameLbl];
                        
                        UILabel *rightPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 130+offsetHeight, 100, 30)];
                        rightPriceLbl.font = [UIFont systemFontOfSize:12];
                        [rightPriceLbl setTextColor:[UIColor redColor]];
                        [rightPriceLbl setText:rightmenu.pice];
                        rightPriceLbl.textAlignment = NSTextAlignmentRight;
                        [_foodCell addSubview:rightPriceLbl];
                        
                    }
                }
            }
            return _foodCell;
            break;
        }


    }
 
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];
    }
    
    return cell;
}

-(void)buyButtonClicked:(id)sender
{
    UIButton *u = (UIButton*)sender;
    Menu* menu = [dModel objectAtIndex:u.tag];
    if([menu.type isEqualToString:@"5"]){
        NSLog(@"%@",[NSString stringWithFormat:@"%@",menu.id]);
        [QSUIHelper showSelectMenu:self mid:[NSString stringWithFormat:@"%@",menu.id] menuName:menu.goods_name price:menu.pice];
    }else{
        
        QSShopCart* shop = [[QSShopCart alloc]init];
        
        
        int sale_money_coupon = [menu.pice intValue];
        
        int type = [menuObj.type intValue];
        switch (type) {
            case 6:
            case 7:
            case 9:
            {
                NSString* cMenu = menuObj.goods_name;
                if ([cMenu rangeOfString:[NSString stringWithFormat:@"\"%@\"",menuObj.id]].location != NSNotFound) {
                    
                    int price = [menuObj.pice intValue];
                    int sale_money = [menu.pice intValue];
                    sale_money_coupon = sale_money * price/100;
                }
                break;
            }
                
            default:
                break;
                
        }
        
        [shop AddProducts:[NSString stringWithFormat:@"%@",menu.id] goods_name:menu.goods_name num:@"1" sale_money:menu.pice sale_money_coupon:[NSString stringWithFormat:@"%d",sale_money_coupon]  sale_id:@"-1" diet:nil];
        [QSUIHelper showTip:self.navigationController.view tipStr:ADD_SHOP];
        
    }
}


@end
