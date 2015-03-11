//
//  MenuViewController.m
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSMenuViewController.h"
#import "DropDownListView.h"
#import "MJRefresh.h"
#import "Post.h"
#import "Menu.h"
#import "MJExtension.h"
#import "Urls.h"
#import <UIButton+AFNetworking.h>
#import "QSShopCart.h"
#import "QSCatalog.h"
#import "FileUtils.h"
#import "AppDelegate.h"
#import "PicViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface QSMenuViewController ()
{
    NSMutableArray *chooseArray;
    NSString* catalogIndex;
    NSString* couponIndex;
    NSString* priceIndex;
    AppDelegate *delegate;
}

@end

@implementation QSMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = menu_tilte;
    
    [QSUIHelper showHead:self.navigationController];

    [self initCatalog];

    [self initMenu];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [QSUIHelper showTabbar];
    
    QSShopCart *shopcart = [[QSShopCart alloc]init];
    [_bookLbl setText:[NSString stringWithFormat:@"你已订购%lu份菜品",(unsigned long)[shopcart getBuyList].count]];
    [_moneyLbl setText:[NSString stringWithFormat:@"￥%.2f",[shopcart getMoney]]];
    
}

- (void)initCatalog
{
    
    catalogIndex = @"";
    couponIndex = @"";
    priceIndex = @"";
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    chooseArray = [[NSMutableArray alloc] init];
    
    NSMutableArray* catalogMArray = [[NSMutableArray alloc]init];
//    NSMutableArray *CATALOGARR = [FileUtils getCache:CATALOGCACHE];
    for (NSDictionary* catalogObj in delegate.CATALOGARRAYT) {
        [catalogMArray addObject:[catalogObj objectForKey:@"tag_name"]];
    }
    [chooseArray addObject:catalogMArray];
    
    NSMutableArray* couponMArray = [NSMutableArray arrayWithObjects:@"优惠",@"折扣卷",@"优惠卷",@"代金卷", nil] ;
//    for (QSCatalog* catalogObj in CATALOGARRAY) {
//        [cataLogMArray addObject:catalogObj.tag_name];
//    }
    [chooseArray addObject:couponMArray];
    
    NSMutableArray* priceMArray = [NSMutableArray arrayWithObjects:@"价格",@"高到低",@"低到高", nil] ;
    //    for (QSCatalog* catalogObj in CATALOGARRAY) {
    //        [cataLogMArray addObject:catalogObj.tag_name];
    //    }
    [chooseArray addObject:priceMArray];
    
//    chooseArray = [NSMutableArray arrayWithArray:@[
//                                                   @[@"分类",@"中餐",@"西餐"],
//                                                   @[@"优惠",@"折扣卷",@"优惠卷",@"代金卷"],
//                                                   @[@"价格",@"高到低",@"低到高"]
//                                                   ]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(10,100, self.view.frame.size.width-20, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.navigationController.view;
    
    UIImageView *customBackgournd = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width-20, 40)];
    [customBackgournd setImage:[UIImage imageNamed:@"menu_bBorderBg.png"]];
    [dropDownView addSubview:customBackgournd];
    [self.view addSubview:dropDownView];
}

- (void)initMenu
{
    page = 1;
    dataMArray = [[NSMutableArray alloc]init];
    menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 140,  [ UIScreen mainScreen ].bounds.size.width,  [ UIScreen mainScreen ].bounds.size.height - 200)];
    [QSUIHelper setExtraCellLineHidden:menuTableView];
    menuTableView.delegate = self;
    menuTableView.dataSource = self;
    menuTableView.rowHeight = 180;
    menuTableView.allowsSelection = NO;
    [menuTableView setSeparatorInset:UIEdgeInsetsMake(0,10,0,10)];
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [menuTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //warning 自动刷新(一进入程序就下拉刷新)
    [menuTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [menuTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self.view addSubview:menuTableView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    switch (section) {
        case 0:
        {
            NSDictionary* tempDic = [delegate.CATALOGARRAYT objectAtIndex:index];
            catalogIndex = [tempDic objectForKey:@"tag_id"];
            break;
        }
        case 1:
            couponIndex = [NSString stringWithFormat:@"%ld",(long)index];
            break;
        case 2:
            priceIndex = [NSString stringWithFormat:@"%ld",(long)index];
            break;
            
        default:
            break;
    }

    [menuTableView headerBeginRefreshing];
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry = chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

#pragma mark -- tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataMArray == nil){
        return  0;
    }
    
    if (dataMArray.count%2>0) {
        return dataMArray.count/2+1;
    }else{
        return dataMArray.count/2;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *SimpleTableIdentifier = [NSString stringWithFormat:@"1_%ld",(long)indexPath.row];
    
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    Menu *leftmenu;
    Menu *rightmenu;
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];
    
    int numRow = 2;
    for (int j = 0; j < numRow; j++) {
        long iTemp = indexPath.row * numRow + j;
        
        if(j == 0){
            leftmenu = [dataMArray objectAtIndex:iTemp];
            
            
            UIButton *leftMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 , 10,[UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
            [leftMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:leftmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
            leftMenuBtn.tag = iTemp;
            [leftMenuBtn addTarget:self action:@selector(showDetailAct:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:leftMenuBtn];
            
            UIButton *leftbuyBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4 - 25, 87, 50, 50)];
            leftbuyBtn.tag = iTemp;
            [leftbuyBtn setImage:[UIImage imageNamed:@"main_shopBtn.png"] forState:UIControlStateNormal];
            [leftbuyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:leftbuyBtn];
            
            UILabel *leftNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 100, 30)];
            leftNameLbl.font = [UIFont systemFontOfSize:12];
            [leftNameLbl setTextColor:MAINCOLOR];
            leftNameLbl.tag = 101;
            [cell addSubview:leftNameLbl];
            
            UILabel *leftPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 120 , 130, 100, 30)];
            leftPriceLbl.font = [UIFont systemFontOfSize:12];
            [leftPriceLbl setTextColor:MAINCOLOR];
            leftPriceLbl.textAlignment = UITextAlignmentRight;
            leftPriceLbl.tag = 102;
            
            [cell addSubview:leftPriceLbl];
            
        }else{
            if(iTemp >= dataMArray.count){
                break;
            }
            
            rightmenu = [dataMArray objectAtIndex:iTemp];
            
            UIButton *rightMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -[UIScreen mainScreen].bounds.size.width/2  , 10, [UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
            [rightMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:rightmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC]];
            rightMenuBtn.tag = iTemp;
            [rightMenuBtn addTarget:self action:@selector(showDetailAct:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:rightMenuBtn];
            
            UIButton *rightbuyBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3 - 35 , 87, 50, 50)];
            rightbuyBtn.tag = iTemp;
            [rightbuyBtn setImage:[UIImage imageNamed:@"main_shopBtn.png"] forState:UIControlStateNormal];
            [rightbuyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:rightbuyBtn];
            
            UILabel *rightNameLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 130, 100, 30)];
            rightNameLbl.font = [UIFont systemFontOfSize:12];
            [rightNameLbl setTextColor:MAINCOLOR];
            rightNameLbl.tag = 103;
            [cell addSubview:rightNameLbl];
            
            UILabel *rightPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 130, 100, 30)];
            rightPriceLbl.font = [UIFont systemFontOfSize:12];
            [rightPriceLbl setTextColor:MAINCOLOR];
            rightPriceLbl.tag = 104;
            rightPriceLbl.textAlignment = UITextAlignmentRight;
            [cell addSubview:rightPriceLbl];
            
        }
        
    }
    
    
    if(leftmenu != nil){
    
        UILabel *leftNameLbl = (UILabel*)[cell viewWithTag:101];
        [leftNameLbl setText:leftmenu.goods_name];
    
        UILabel *leftPriceLbl = (UILabel*)[cell viewWithTag:102];
        [leftPriceLbl setText:[NSString stringWithFormat:@"￥%@",leftmenu.pice]];
    }
    if(rightmenu != nil){
        UILabel *rightNameLbl = (UILabel*)[cell viewWithTag:103];
        [rightNameLbl setText:rightmenu.goods_name];
        
        UILabel *rightPriceLbl = (UILabel*)[cell viewWithTag:104];
        [rightPriceLbl setText:[NSString stringWithFormat:@"￥%@",rightmenu.pice]];
    }
    
    return cell;

}

#pragma mark - Refresh and load more methods
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    NSArray *type = @[@"1",@"5"];
    [paramDic setObject:type forKey:@"type"];
    [paramDic setValue:@"" forKey:@"key"];
    [paramDic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"startPage"];
    
    [paramDic setValue:catalogIndex forKey:@"catalogIndex"];
    [paramDic setValue:couponIndex forKey:@"couponIndex"];
    [paramDic setValue:priceIndex forKey:@"priceIndex"];
    

    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
         page = 1;
         if(error == nil){
         
             NSDictionary* indexDic =(NSDictionary*)posts;
             NSArray *recordsArr = [indexDic objectForKey:@"records"];
             
             [dataMArray removeAllObjects];
             
             NSArray *arrMenu = [Menu objectArrayWithKeyValuesArray:recordsArr];
             for (Menu *menu in arrMenu) {
                 [dataMArray addObject:menu];
             }

             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [menuTableView reloadData];
                 
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [menuTableView headerEndRefreshing];
            });
         
         }else{
             if(error.code == -1000){
         
                 NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
             }else{
         
             }
         }
    }:@"goods/list" parameters:paramDic fileName:@""];
    

}

- (void)footerRereshing
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    NSArray *type = @[@"1",@"5"];
    [paramDic setObject:type forKey:@"type"];
    [paramDic setValue:@"" forKey:@"key"];
    [paramDic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"startPage"];
    
    [paramDic setValue:catalogIndex forKey:@"catalogIndex"];
    [paramDic setValue:couponIndex forKey:@"couponIndex"];
    [paramDic setValue:priceIndex forKey:@"priceIndex"];

    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        page++;
        
        if(error == nil){
            
            NSDictionary* indexDic =(NSDictionary*)posts;
            NSArray *recordsArr = [indexDic objectForKey:@"records"];
            
            [dataMArray removeAllObjects];
            
            NSArray *arrMenu = [Menu objectArrayWithKeyValuesArray:recordsArr];
            for (Menu *menu in arrMenu) {
                [dataMArray addObject:menu];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [menuTableView reloadData];
                
                [menuTableView footerEndRefreshing];
            });
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }else{
                
            }
        }
    }:@"goods/list" parameters:paramDic fileName:@""];

}
#pragma mark - click

-(void)buyButtonClicked:(id) sender
{
    UIButton *u = (UIButton*)sender;
    Menu* menu = [dataMArray objectAtIndex:u.tag];
    
    if([menu.type isEqualToString:@"5"]){
        NSLog(@"%@",[NSString stringWithFormat:@"%@",menu.id]);
        [QSUIHelper showSelectMenu:self.navigationController mid:[NSString stringWithFormat:@"%@",menu.id] menuName:menu.goods_name price:menu.pice];
    }else{
        
        QSShopCart* shop = [[QSShopCart alloc]init];
        [shop AddProducts:[NSString stringWithFormat:@"%@",menu.id] goods_name:menu.goods_name num:@"1" sale_money:menu.pice sale_id:@"-1" diet:nil];
        
        [QSUIHelper showTip:self.navigationController.view tipStr:ADD_SHOP];
        
    }
    
}


- (IBAction)backBtnAct:(id)sender {
    [QSUIHelper showMain:self.navigationController];
}
- (IBAction)userBtnAct:(id)sender {
    [QSUIHelper showUser:self];
}

-(void)showDetailAct:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    Menu* menu = [dataMArray objectAtIndex:btn.tag];
    
    PicViewController *picViewController =  [[PicViewController alloc]initWithNibName:@"PicViewController" bundle:nil];
    
    picViewController.purl = [Urls FixImageUrlToStr:menu.banner];
    [self presentPopupViewController:picViewController animationType:MJPopupViewAnimationSlideTopTop];
}
@end
