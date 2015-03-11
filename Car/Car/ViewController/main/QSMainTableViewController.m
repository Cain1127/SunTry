//
//  MainTableViewController.m
//  Car
//
//  Created by System Administrator on 9/26/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSMainTableViewController.h"
#import "QSUIHelper.h"
#import "AFAppDotNetAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "Post.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Menu.h"
#import "Urls.h"
#import "User.h"
#import <UIButton+AFNetworking.h>


@implementation TableDataSource

@synthesize delegate;


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(_dModel == nil){
        return  0;
    }
    
    if (_dModel.count%2>0) {
        return _dModel.count/2+1;
    }else{
        return _dModel.count/2;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    Menu *leftmenu;
    Menu *rightmenu;
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];

        int numRow = 2;
        for (int j = 0; j < numRow; j++) {
            long iTemp = indexPath.row * numRow + j;
           
            if(j == 0){
                leftmenu = [_dModel objectAtIndex:iTemp];
                UIButton *leftMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 , 10,[UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
                [leftMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:leftmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
                leftMenuBtn.tag = iTemp;
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
                leftPriceLbl.textAlignment = NSTextAlignmentRight;
                leftPriceLbl.tag = 102;
                
                [cell addSubview:leftPriceLbl];
                
            }else{
                if(iTemp >= _dModel.count){
                    break;
                }
                
                rightmenu = [_dModel objectAtIndex:iTemp];
                
                UIButton *rightMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -[UIScreen mainScreen].bounds.size.width/2  , 10, [UIScreen mainScreen].bounds.size.width/2 - 20, 100)];
                [rightMenuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:rightmenu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
                rightMenuBtn.tag = iTemp;
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
                rightPriceLbl.textAlignment = NSTextAlignmentRight;
                [cell addSubview:rightPriceLbl];

            }
            
        }
        

    }
    
    
    UILabel *leftNameLbl = (UILabel*)[cell viewWithTag:101];
    [leftNameLbl setText:leftmenu.goods_name];
    
    UILabel *leftPriceLbl = (UILabel*)[cell viewWithTag:102];
    [leftPriceLbl setText:[NSString stringWithFormat:@"￥%@",leftmenu.pice]];
    
    if(rightmenu != nil){
        NSLog(@"%@",rightmenu.goods_name);
        UILabel *rightNameLbl = (UILabel*)[cell viewWithTag:103];
        [rightNameLbl setText:rightmenu.goods_name];
    
        UILabel *rightPriceLbl = (UILabel*)[cell viewWithTag:104];
        [rightPriceLbl setText:[NSString stringWithFormat:@"￥%@",rightmenu.pice]];
    }
    return cell;
}

#pragma mark buttonclick
-(void)menuButtonClicked:(id) sender
{
    UIButton *u = (UIButton*)sender;
    Menu* menu = [_dModel objectAtIndex:u.tag];
    [delegate menuClickValue:menu];
}

-(void)buyButtonClicked:(id) sender
{
    UIButton *u = (UIButton*)sender;
    Menu* menu = [_dModel objectAtIndex:u.tag];
    [delegate buyClickValue:menu];
    
}

@end



@interface QSMainTableViewController ()
{
    SGFocusImageFrame *bannerView;
}

@end

@implementation QSMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initAdView];
    [self initMenu];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    bannerView.delegate = nil;
}

-(void)initAdView
{
    
    SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:@{@"image":DEFAULT_PIC} tag:-1];
    
    bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0,  [ UIScreen mainScreen ].bounds.size.width, _adView.frame.size.height) delegate:self imageItems:@[item] isAuto:YES];
    
    int length = 3;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0 ; i < length; i++)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"title%d",i],@"title" ,
                              [NSString stringWithFormat:@"test%d.png",(i + 1)],@"image",
                              nil];
        [tempArray addObject:dict];
    }
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
    //添加最后一张图 用于循环
    if (length > 1)
    {
        NSDictionary *dict = [tempArray objectAtIndex:length-1];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1] ;
        [itemArray addObject:item];
    }
    for (int i = 0; i < length; i++)
    {
        NSDictionary *dict = [tempArray objectAtIndex:i];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i] ;
        [itemArray addObject:item];
        
    }
    //添加第一张图 用于循环
    if (length >1)
    {
        NSDictionary *dict = [tempArray objectAtIndex:0];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length] ;
        [itemArray addObject:item];
    }
    [bannerView changeImageViewsContent:itemArray];
    
    [_adView addSubview:bannerView];
    
}

-(void)initMenu
{
    
    source = [[TableDataSource alloc]init];
    
    source.dModel = [[NSMutableArray alloc]init];
    source.delegate = self;
    _recommendTableView.dataSource = source;
    _recommendTableView.delegate = source;
    _recommendTableView.scrollEnabled = NO;
    _recommendTableView.allowsSelection = NO;
    _recommendTableView.rowHeight = 120;
    
    [QSUIHelper setExtraCellLineHidden:_recommendTableView];
    [_recommendTableView setSeparatorInset:UIEdgeInsetsMake(0,10,0,10)];
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    NSArray *type = @[@"1",@"5"];
    [paramDic setObject:type forKey:@"type"];
    [paramDic setValue:@"" forKey:@"key"];
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){

        if(error == nil){
            NSDictionary* indexDic =(NSDictionary*)posts;
            NSArray *recordsArr = [indexDic objectForKey:@"records"];
            
     
            NSArray *arrMenu = [Menu objectArrayWithKeyValuesArray:recordsArr];
            for (Menu *menu in arrMenu ) {
                [source.dModel addObject:menu];
            }
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                
            }else{
                
            }
        }
        
    }:@"goods/list" parameters:paramDic fileName:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shakeBtnAct:(id)sender {
    [QSUIHelper showShakeController:self.navigationController];
}

- (IBAction)menuBtnAct:(id)sender {
    [QSUIHelper showMenuController:self.navigationController];
}

- (IBAction)callBtnAct:(id)sender {
    [QSUIHelper CallPhone];
}

- (IBAction)checkBtnAct:(id)sender {
    [QSUIHelper showMyBookController:self.navigationController];
}

- (IBAction)bookBtnAct:(id)sender {
    [QSUIHelper showMenuController:self.navigationController];

}

#pragma mark SGFocusImageFrameDelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
    
}

-(void)buyClickValue:(Menu*)menu
{
    User* user = [User sharedInstance];
    if([user isLogin] == false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
    }else{
        [QSUIHelper showMenuController:self.navigationController];
    }
}


@end
