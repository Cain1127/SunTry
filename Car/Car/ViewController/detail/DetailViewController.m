//
//  DetailViewController.m
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "Book.h"
#import "MJExtension.h" 
#import "ProgressViewController.h"
#import "QRCodeGenerator.h"
#import "UIViewController+MJPopupViewController.h"
#import "ErweimaViewController.h"
#import "MenuListViewController.h"


@interface DetailViewController ()
{
    Book *book;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = book_detail_title;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QSUIHelper hideTabbar];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[NSString stringWithFormat:@"%@",_mid] forKey:@"id"];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;

    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        [HUD setHidden:YES];
        
        if(error == nil){
            NSDictionary* detailDic =(NSDictionary*)posts;
            book = [Book objectWithKeyValues:detailDic];
            [_numLbl setText:[NSString stringWithFormat:@"%@%@",@"订单编号：",book.order_num]];
            [_statusLbl setText:[STATUSARRAY objectAtIndex:[book.status intValue]]];
            [_sendTimeLbl setText:[NSString stringWithFormat:@"%@%@",@"预计送达时间：",book.get_time]];
            [_nameLbl setText:book.name];
            [_phoneLbl setText:book.phone];
            [_addressLbl setText:book.address];
            
            [_sendCarLbl setText:book.expand_3];
            if([book.expand_4 isEqualToString:@"1"]){
                [_payTypeLbl setText:PAY_TYPE_1];
            }else{
                [_payTypeLbl setText:PAY_TYPE_2];
            }
            [_couponLbl setText:book.expand_5];
            [_descLbl setText:book.desc];
            
            [_bookNumLbl setText:[NSString stringWithFormat:@"%@份",book.diet_total_num]];
            [_totalLbl setText:book.total_money];
            
            NSString* orderNum = [book.verification stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            
            UIImage* image = [QRCodeGenerator qrImageForString:orderNum imageSize:_erweimaBtn.frame.size.width];
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            [imageView setImage:image];
            [_erweimaBtn addSubview:imageView];
            
            
            _bookNumLbl.userInteractionEnabled = YES;
            UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuList:)];
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [_bookNumLbl addGestureRecognizer:singleRecognizer];
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }else{
                [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
                
            }
        }
        
    }:@"order/detail" parameters:parameters fileName:@""];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 700);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)selectSegAct:(id)sender {
    UISegmentedControl* useg = (UISegmentedControl*)sender;
    if(useg.selectedSegmentIndex==0){
        
        [QSUIHelper CallPhone];
    }else{
        ProgressViewController *progressViewController =  [[ProgressViewController alloc]initWithNibName:@"ProgressViewController" bundle:nil];
        progressViewController.bid = book.id;
        [self presentPopupViewController:progressViewController animationType:MJPopupViewAnimationSlideRightLeft];
    }
    [useg setSelectedSegmentIndex:-1];
    
    
}
- (IBAction)erwemaBtnAct:(id)sender {
    ErweimaViewController *erweimaViewController =  [[ErweimaViewController alloc]initWithNibName:@"ErweimaViewController" bundle:nil];
    erweimaViewController.code = book.verification;
    [self presentPopupViewController:erweimaViewController animationType:MJPopupViewAnimationSlideTopTop];
}


-(void)showMenuList:(UITapGestureRecognizer*)recognizer
{
    MenuListViewController *menuListViewController =  [[MenuListViewController alloc]initWithNibName:@"MenuListViewController" bundle:nil];
    menuListViewController.dataMArray = [NSMutableArray arrayWithArray:book.goods_list];
    [self presentPopupViewController:menuListViewController animationType:MJPopupViewAnimationSlideTopTop];
}
@end
