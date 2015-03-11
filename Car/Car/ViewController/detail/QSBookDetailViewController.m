//
//  QSBookDetailViewController.m
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSBookDetailViewController.h"
#import "QSShopCart.h"
#import "User.h"
#import "Post.h"
#import "Order.h"
#import "DataSigner.h"
#import "MBProgressHUD.h"
#import <AlipaySDK/AlipaySDK.h>
#import "IQKeyboardManager.h"


@implementation Product
@synthesize price = _price;
@synthesize subject = _subject;
@synthesize body = _body;
@synthesize orderId = _orderId;

@end


@interface QSBookDetailViewController ()<UIAlertViewDelegate,UIAlertViewDelegate>
{
    QSShopCart *ShopCart;
    NSString *mid;
    NSString* bill_id;
    BOOL _wasKeyboardManagerEnabled;
}
@end

@implementation QSBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = shop_count;
    self.tableView.allowsSelection = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    [QSUIHelper hideTabbar];
    User *user = [User sharedInstance];
    
    if([user isLogin]==false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
        return;
    }
    
    ShopCart = [[QSShopCart alloc]init];
    [_moneyLbl setText:[NSString stringWithFormat:@"￥%.2f",[ShopCart getMoney]]];
    [_nameLbl setText:[user getAccountName]];
    [_phoneLbl setText:[user getPhone]];
    if([user getAddress] != nil){
        if([user getAddress].count>0)
            [_addressLbl setText:[[user getAddress] objectAtIndex:[user getAddressIndex]]];
    }
    NSArray* couArray = [ShopCart couponArray];
    if([ShopCart couponArray] != nil&&[ShopCart couponArray].count>0){
        [_couponLbl setText:[[couArray objectAtIndex:0] objectForKey:@"coupon_name"]];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtnAct:(id)sender {
    
    User *user = [User sharedInstance];
    if([user isLogin]==false){
        [QSUIHelper showLogin:self.navigationController];
        return;
    }
    
    
    if([_nameLbl.text isEqualToString:@""]==true){
        [QSUIHelper AlertView:@"" message:@"名字不能为空,请到设置名字" delegate:self];
        return;
    }
    
    if([_phoneLbl.text isEqualToString:@""]==true){
        [QSUIHelper AlertView:@"" message:@"电话不能为空,请到设置添加电话" delegate:self];
        return;
    }
    
    if([_addressLbl.text isEqualToString:@""]==true){
        [QSUIHelper AlertView:@"" message:@"地址不能为空,请到设置添加地址" delegate:self];
        return;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 
    if(_payTypeSegmented.selectedSegmentIndex == 0){
        
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        int nowTime = [timeSp intValue];
        nowTime+=3600;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"HH:mm"];
        NSString *confromTimespStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:nowTime]];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setValue:@"1" forKey:@"mer_id"];
        [parameters setValue:_nameLbl.text forKey:@"name"];
        [parameters setValue:_phoneLbl.text forKey:@"phone"];
        [parameters setValue:_addressLbl.text forKey:@"address"];
        [parameters setValue:@"1" forKey:@"pay_type"];
        [parameters setValue:[NSString stringWithFormat:@"%.2f",[ShopCart getMoney] ]forKey:@"total_money"];
        [parameters setValue:_descTextField.text forKey:@"desc"];
        [parameters setValue:confromTimespStr forKey:@"get_time"];
        [parameters setObject:[ShopCart getBuyList_] forKey:@"diet"];
        
        
        [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
            
            [HUD setHidden:YES];
            
            if(error == nil){
                
                NSDictionary *dataDic = (NSDictionary*)posts;
                mid = [dataDic objectForKey:@"id"];
                
                [ShopCart removeShopCart];
                [QSUIHelper AlertView:@"" message:SUBMIT_SUC_MESSAGE delegate:self];
                [QSUIHelper showMyBookController:self.navigationController];
                
            }else{
                if(error.code == -1000){
                    
                    NSArray* index =(NSArray*)posts;
                    [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                }else{
                    [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
                    
                }
            }
            
        }:@"order/add" parameters:parameters fileName:@""];
        
    }else{
        
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        int nowTime = [timeSp intValue];
        nowTime+=3600;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"HH:mm"];
        NSString *confromTimespStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:nowTime]];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setValue:@"1" forKey:@"mer_id"];
        [parameters setValue:_nameLbl.text forKey:@"name"];
        [parameters setValue:_phoneLbl.text forKey:@"phone"];
        [parameters setValue:_addressLbl.text forKey:@"address"];
        [parameters setValue:@"1" forKey:@"pay_type"];
        [parameters setValue:[NSString stringWithFormat:@"%.2f",[ShopCart getMoney] ]forKey:@"total_money"];
        [parameters setValue:_descTextField.text forKey:@"desc"];
        [parameters setValue:confromTimespStr forKey:@"get_time"];
        [parameters setObject:[ShopCart getBuyList_] forKey:@"diet"];
        
        
        
        
        [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
            
            [HUD setHidden:YES];
            
            if(error == nil){
                
                NSDictionary *dataDic = (NSDictionary*)posts;
                mid = [dataDic objectForKey:@"order_id"];
                bill_id = [dataDic objectForKey:@"bill_id"];
                
                
            }else{
                if(error.code == -1000){
                    
                    NSArray* index =(NSArray*)posts;
                    [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                }else{
                    [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
                    
                }
            }
            
        }:@"order/add" parameters:parameters fileName:@""];
        
        
        Order *order = [[Order alloc] init];
        order.partner = PartnerID;
        order.seller = SellerID;
        order.tradeNO = bill_id; //订单ID（由商家自行制定）
        order.productName = _nameLbl.text; //商品标题
        order.productDescription = _nameLbl.text; //商品描述
        order.amount = [NSString stringWithFormat:@"%.2f",[ShopCart getMoney] ];
        
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showUrl = @"m.alipay.com";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"cardemo";
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                if([[resultDic objectForKey:@"resultStatus"] intValue] == 9000){
                    
                    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                    [parameters setValue:@"type" forKey:@"type"];
                    [parameters setValue:mid forKey:@"order_id"];
                    
                    
                    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
                        if(error == nil){
                            
                            [ShopCart removeShopCart];
                            [QSUIHelper AlertView:@"" message:SUBMIT_SUC_MESSAGE delegate:self];
                            [QSUIHelper showMyBookController:self.navigationController];
                        }else{
                            if(error.code == -1000){
                                
                                NSArray* index =(NSArray*)posts;
                                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                            }else{
                                [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
                                
                            }
                        }
                        
                    }:@"order/PayCommit" parameters:parameters fileName:@""];
                    
                }else{
                    [QSUIHelper showTip:self.navigationController.view tipStr:PAY_FAL];

                }
            }];
            
        }


        
    }

}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [QSUIHelper showUser:self];
}
@end
