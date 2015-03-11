//
//  ShopViewController.m
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSShopViewController.h"
#import "QSShopCart.h"
#import "PickerViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "QSCouponViewController.h"
#import "QSCouponValidateViewController.h"
#import "User.h"

@interface QSShopViewController ()<PickerViewDelegate,QSCouponViewDelegate>
{
    NSArray* buyListArray;
    int iSelected;
    QSShopCart* shopCart;
    NSMutableArray* numArray;
}
@end

@implementation QSShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = shop_title;
    
    [QSUIHelper showHead:self.navigationController];
    
    numArray = [[NSMutableArray alloc]initWithArray:NUMARRAY];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    User* user = [User sharedInstance];
    
    if([user isLogin]==false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
        return;
    }
    [QSUIHelper showTabbar];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    shopCart = [[QSShopCart alloc]init];
    
    _BuyListTableView.dataSource = self;
    _BuyListTableView.delegate = self;
    _BuyListTableView.rowHeight = 50;
    [QSUIHelper setExtraCellLineHidden:_BuyListTableView];
    buyListArray = [shopCart getBuyList];
    [_BuyListTableView reloadData];
    
    
    [_countLbl setText:[NSString stringWithFormat:SHOP_COUNT,[shopCart getCount],[shopCart getMoney]]];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return buyListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    QSProducts *products = [buyListArray objectAtIndex:indexPath.row];
    NSLog(@"%@",[products goods_id]);
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];
        
        UILabel *goodsNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
        goodsNameLbl.tag = 101;
        goodsNameLbl.font = [UIFont systemFontOfSize:14];
        goodsNameLbl.textColor = [UIColor grayColor];
        [cell addSubview:goodsNameLbl];
        
        UILabel *priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(150, 15, 40, 20)];
        priceLbl.tag = 102;
        priceLbl.font = [UIFont systemFontOfSize:14];
        priceLbl.textColor = [UIColor grayColor];
        [cell addSubview:priceLbl];
        
        UILabel *countLbl = [[UILabel alloc]initWithFrame:CGRectMake(180, 15, 60, 20)];
        countLbl.tag = 103;
        countLbl.font = [UIFont systemFontOfSize:14];
        countLbl.textColor = [UIColor grayColor];
        [cell addSubview:countLbl];
        
        UIButton* numBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width - 60, 15, 20, 20)];
        numBtn.tag = 104 + indexPath.row;
        [numBtn setBackgroundColor:[UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1]];
        numBtn.layer.masksToBounds = YES;
        numBtn.layer.cornerRadius = 10;
        [numBtn addTarget:self action:@selector(numBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:numBtn];
    }
 
    
    UILabel *goodsNameLbl = (UILabel*)[cell viewWithTag:101];
    [goodsNameLbl setText:products.goods_name];
    
    float money;
    if(nil != products.sale_money_coupon  ){
        money = [products.sale_money_coupon floatValue];
    }else{
        money = [products.sale_money floatValue];
    }
    
    UILabel *priceLbl = (UILabel*)[cell viewWithTag:102];
    [priceLbl setText:[NSString stringWithFormat:@"%.0f",money]];
    
    UILabel *countLbl = (UILabel*)[cell viewWithTag:103];
//    float money = [products.sale_money floatValue];
    int num = [products.num intValue];
    float count = money*num;
    [countLbl setText:[NSString stringWithFormat:@"%.2f",count]];
    
    UIButton *numBtn = (UIButton*)[cell viewWithTag:104 + indexPath.row];
    [numBtn setTitle:products.num forState:UIControlStateNormal];
    
  
     return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 30.0)];
    
    UILabel *goodsNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    goodsNameLbl.font = [UIFont systemFontOfSize:16];
    goodsNameLbl.textColor = [UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1];
    [goodsNameLbl setText:@"菜单"];
    [customView addSubview:goodsNameLbl];
    
    UILabel *priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(130, 0, 40, 20)];
    priceLbl.font = [UIFont systemFontOfSize:16];
    priceLbl.textColor = [UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1];
    [priceLbl setText:@"单价"];
    [customView addSubview:priceLbl];
    
    UILabel *countLbl = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, 60, 20)];
    countLbl.font = [UIFont systemFontOfSize:16];
    countLbl.textColor = [UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1];
    [countLbl setText:@"小计"];
    [customView addSubview:countLbl];
    
    UIView* fView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 29, tableView.frame.size.width, 1.0)];
    [fView setBackgroundColor:[UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1]];
    [customView addSubview:fView];
    
    [customView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
    return customView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}


#pragma mark - clickAct
- (void)numBtnAct:(id)sender {
    
    UIButton* numBtn = (UIButton*)sender;
    NSString* num = numBtn.titleLabel.text;
    iSelected = numBtn.tag - 104;
    
    PickerViewController *pickerViewController =  [[PickerViewController alloc]initWithNibName:@"PickerViewController" bundle:nil];

    pickerViewController.selectArr = numArray;
    pickerViewController.selected = [num intValue];
    pickerViewController.delegate = self;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];
}

#pragma mark - callback
- (void)cancelButtonClicked:(PickerViewController *)ViewController
{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSInteger selected = ViewController.selected;
    [shopCart changeNum:iSelected num:[[numArray objectAtIndex:selected] intValue]];
    shopCart = [[QSShopCart alloc]init];
    buyListArray = [shopCart getBuyList];
    [_BuyListTableView reloadData];
    
    [_countLbl setText:[NSString stringWithFormat:SHOP_COUNT,[shopCart getCount],[shopCart getMoney]]];
}

- (void)JoinBtnClicked:(NSString*)cid
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    _BuyListTableView.dataSource = self;
    _BuyListTableView.delegate = self;
    _BuyListTableView.rowHeight = 50;
    [QSUIHelper setExtraCellLineHidden:_BuyListTableView];
    shopCart = [[QSShopCart alloc]init];
    buyListArray = [shopCart getBuyList];
    [_BuyListTableView reloadData];
    
    
    [_countLbl setText:[NSString stringWithFormat:SHOP_COUNT,[shopCart getCount],[shopCart getMoney]]];
}



- (IBAction)couponBtnAct:(id)sender {
    if([shopCart couponArray].count > 0){
        [QSUIHelper AlertView:@"" message:@"你已使用了优惠"];
    }else{
        QSCouponViewController *couponViewController =  [[QSCouponViewController alloc]initWithNibName:@"QSCouponViewController" bundle:nil];
        couponViewController.delegate = self;
        [self presentPopupViewController:couponViewController animationType:MJPopupViewAnimationSlideTopTop];
    }
    

}

- (IBAction)couponNumBtnAct:(id)sender {
    shopCart = [[QSShopCart alloc]init];
    if([shopCart couponArray].count > 0){
        [QSUIHelper AlertView:@"" message:@"你已使用了优惠"];
    }else{
        QSCouponValidateViewController *couponValidateViewController =  [[QSCouponValidateViewController alloc]initWithNibName:@"QSCouponValidateViewController" bundle:nil];
        [self presentPopupViewController:couponValidateViewController animationType:MJPopupViewAnimationSlideTopTop];
    }
}

- (IBAction)SubmitBtnAct:(id)sender {
    
    if(buyListArray.count==0){
        [QSUIHelper AlertView:@"" message:@"未订餐，请订餐"];
        return;
    }
    
    [QSUIHelper showBookDetail:self.navigationController];
}

- (IBAction)backBtnAct:(id)sender {
    [QSUIHelper showMain:self.navigationController];
}


@end
