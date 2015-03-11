//
//  CouponActivityTableViewController.m
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "CouponActivityTableViewController.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "MJExtension.h"
#import "Post.h"
#import "Menu.h"
#import "MBProgressHUD.h"
#import "TimeUtils.h"


@interface CouponActivityTableViewController ()<SGFocusImageFrameDelegate>
{
    NSArray *menuArray;
    NSNumber* mid;
    NSString* type;
    SGFocusImageFrame *bannerView;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *bannerCell;

@end

@implementation CouponActivityTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"优惠活动";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QSUIHelper showTabbar];
    [QSUIHelper showHead:self.navigationController];
    
    self.tableView.allowsSelection = NO;
    
    
    [self initCoupon];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bannerView.delegate = nil;
}


-(void)initCoupon
{
        
    SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:@{@"image":DEFAULT_PIC} tag:-1];
    
    bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0,  [ UIScreen mainScreen ].bounds.size.width, 200) delegate:self imageItems:@[item] isAuto:YES];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
   
    [paramDic setObject:ALL_COUPON_TYPE forKey:@"type"];
    [paramDic setValue:@"" forKey:@"key"];

    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        [HUD setHidden:YES];
        
        if(error == nil){
            NSDictionary* indexDic =(NSDictionary*)posts;
            NSArray *recordsArr = [indexDic objectForKey:@"records"];
            
            if(recordsArr.count > 0){
                int length = recordsArr.count;
                NSMutableArray *tempArray = [NSMutableArray array];
                menuArray = [Menu objectArrayWithKeyValuesArray:recordsArr];

                for (int i = 0 ; i < length; i++)
                {
                    Menu* menuObj = [menuArray objectAtIndex:i];
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          menuObj.id,@"title" ,
                                          menuObj.banner,@"image",
                                          nil];
                    

                    
                    [_couponNameLbl setText:menuObj.goods_name];
                    
                    [_couponTimeLbl setText:[NSString stringWithFormat:@"%@至%@",[TimeUtils TimeToDate:[menuObj.begin_time intValue]],[TimeUtils TimeToDate:[menuObj.over_time intValue]]]];
                    
                    [_descWebView loadHTMLString:menuObj.expant_4 baseURL:nil];
                    
                    [tempArray addObject:dict];
                    if(i == 0){
                        mid = menuObj.id;
                        type = menuObj.type;
                    }
                    
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
                
                [_bannerCell addSubview:bannerView];
                [_bannerCell sendSubviewToBack:bannerView];
                

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

#pragma mark SGFocusImageFrameDelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
    Menu *menu = [menuArray objectAtIndex:[item.title intValue]];

    [QSUIHelper showCouponDetail:self.navigationController mid:menu.id type:type];
}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
    Menu *menu = [menuArray objectAtIndex:index];
    [_couponNameLbl setText:menu.goods_name];
    
    [_couponTimeLbl setText:[NSString stringWithFormat:@"%@至%@",[TimeUtils TimeToDate:[menu.begin_time intValue]],[TimeUtils TimeToDate:[menu.over_time intValue]]]];
    [_descWebView loadHTMLString:menu.expant_4 baseURL:nil];
    mid = menu.id;
    type = menu.type;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)bookBtnAct:(id)sender {
     NSLog(@"click===>");
    [QSUIHelper showCouponDetail:self.navigationController mid:mid type:type];

}

- (IBAction)backBtnAct:(id)sender {
    [QSUIHelper showMain:self.navigationController];
}
@end
