//
//  SelectMenuViewController.m
//  Car
//
//  Created by likunding on 14-10-15.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#define tableCellHeight 50

#import "SelectMenuViewController.h"
#import <MBProgressHUD.h>
#import "Post.h"
#import "Menu.h"
#import "MJExtension.h"
#import "PickerViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "QSShopCart.h"

@interface SelectMenuViewController ()<PickerViewDelegate,UIScrollViewDelegate>
{
    NSArray* stapleFoodArr;
    NSArray* soupArr;
    
    NSMutableArray* numArr;
    int sFirst;
    int sSecond;
    
    UITableView *firstTableView;
    UITableView *secondTableView;
}

@end

@implementation SelectMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sFirst = -1;
    sSecond = -1;
    
    numArr = [[NSMutableArray alloc]initWithArray:NUMARRAY];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [QSUIHelper hideTabbar];
    
    
    QSShopCart *shopcart = [[QSShopCart alloc]init];
    [_bookMenuLbl setText:[NSString stringWithFormat:@"你已订购%d份菜品",[shopcart getBuyList].count]];
    [_moneyLbl setText:[NSString stringWithFormat:@"￥%.2f",[shopcart getMoney]]];
    
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
    
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:_mid forKey:@"id"];
    [paramDic setValue:@"5" forKey:@"type"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        
        [HUD hide:YES];
        
        if(error == nil){
            
            NSDictionary* indexDic =(NSDictionary*)posts;
            
            stapleFoodArr = [Menu objectArrayWithKeyValuesArray:[indexDic objectForKey:@"staple_food"]];
            soupArr = [Menu objectArrayWithKeyValuesArray:[indexDic objectForKey:@"soup"]];
            
//            _mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, stapleFoodArr.count*tableCellHeight + soupArr.count*tableCellHeight + 1000);
            
            UILabel *mainLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 200, 21)];
            [mainLbl setTextColor:MAINCOLOR];
            mainLbl.font = [UIFont systemFontOfSize:20];
            [mainLbl setText:[NSString stringWithFormat:@"主食（%d份）",stapleFoodArr.count ]];
            [_mainScrollView addSubview:mainLbl];
            
            

            firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(9, 44, 301, stapleFoodArr.count*tableCellHeight)];
            firstTableView.dataSource = self;
            firstTableView.delegate = self;
            firstTableView.scrollEnabled = NO;
            firstTableView.rowHeight = tableCellHeight;
            [QSUIHelper setExtraCellLineHidden:firstTableView];
            [firstTableView reloadData];
            [_mainScrollView addSubview:firstTableView];
            
            
            UILabel *otherLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 160 + stapleFoodArr.count*tableCellHeight - 100, 200, 21)];
            [otherLbl setTextColor:MAINCOLOR];
            otherLbl.font = [UIFont systemFontOfSize:20];
            [otherLbl setText:[NSString stringWithFormat:@"配汤、饮品（%d份）",soupArr.count ]];
            [_mainScrollView addSubview:otherLbl];
            
            UIView *secondSpView = [[UIView alloc]initWithFrame:CGRectMake(0, 160 + stapleFoodArr.count*tableCellHeight - 100 + 30, [UIScreen mainScreen].bounds.size.width, 1)];
            [secondSpView setBackgroundColor:MAINCOLOR];
            [_mainScrollView addSubview:secondSpView];
            

            
            
            secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 160 + stapleFoodArr.count*tableCellHeight - 100 + soupArr.count*tableCellHeight - 100, 300, soupArr.count*tableCellHeight)];
            
            secondTableView.dataSource = self;
            secondTableView.delegate = self;
            secondTableView.scrollEnabled = NO;
            [QSUIHelper setExtraCellLineHidden:secondTableView];
            [secondTableView reloadData];
            [_mainScrollView addSubview:secondTableView];
            

            
            UIButton * shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,340 + stapleFoodArr.count*tableCellHeight - 100 + soupArr.count*tableCellHeight - 100,[UIScreen mainScreen].bounds.size.width-20,36)];
            shopBtn.layer.masksToBounds = YES;
            shopBtn.layer.cornerRadius = 10;
            [shopBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
            [shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [shopBtn setBackgroundColor:MAINCOLOR];
            [shopBtn addTarget:self action:@selector(shopBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            [_mainScrollView addSubview:shopBtn];
            
            
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }else{
                
            }
        }
    }:@"goods/get" parameters:paramDic fileName:@""];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, stapleFoodArr.count*tableCellHeight + soupArr.count*tableCellHeight + 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqualToString:@"MenuTableViewSegue"])
//    {
//        _MenuTableViewSegue = (MenuTableViewController*)segue.destinationViewController;
//        [_MenuTableViewSegue setStapleFoodArr:[stapleFoodArr copy]];
//    }
}


- (void)cancelButtonClicked:(PickerViewController *)ViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSInteger selected = ViewController.selected;
    [_numBtn setTitle:[numArr objectAtIndex:selected] forState:UIControlStateNormal];
    
}

- (IBAction)numBtnAct:(id)sender {
    
    PickerViewController *pickerViewController =  [[PickerViewController alloc]initWithNibName:@"PickerViewController" bundle:nil];
    
    pickerViewController.selectArr = numArr;
    pickerViewController.selected = 0;
    pickerViewController.delegate = self;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];

}

- (void)shopBtnAct:(id)sender {
    if (sFirst == -1) {
        [QSUIHelper AlertView:@"" message:@"请选择主食"];
        return;
    }
    if (sSecond == -1) {
        [QSUIHelper AlertView:@"" message:@"请选择饮品或汤"];
        return;
    }
    
    Menu *stapleFoodMenu = [stapleFoodArr objectAtIndex:sFirst];
    
    float price = [_price floatValue];
    int num = [_numBtn.titleLabel.text intValue];
    
    NSMutableArray *dietArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dietMdic = [[NSMutableDictionary alloc]init];
    [dietMdic setValue:stapleFoodMenu.id forKey:@"goods_id"];
    [dietMdic setValue:stapleFoodMenu.goods_name forKey:@"goods_name"];
    [dietMdic setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
    [dietMdic setValue:stapleFoodMenu.pice forKey:@"sale_money"];
    [dietMdic setValue:@"-1" forKey:@"sale_id"];
    [dietArray addObject:dietMdic];
    
    
    Menu *soupMenu = [soupArr objectAtIndex:sSecond];

    NSMutableDictionary *soupMdic = [[NSMutableDictionary alloc]init];
    [soupMdic setValue:soupMenu.id forKey:@"goods_id"];
    [soupMdic setValue:soupMenu.goods_name forKey:@"goods_name"];
    [soupMdic setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
    [soupMdic setValue:soupMenu.pice forKey:@"sale_money"];
    [soupMdic setValue:@"-1" forKey:@"sale_id"];
    [dietArray addObject:soupMdic];
    
    QSShopCart* shop = [[QSShopCart alloc]init];
    [shop AddProducts:_mid goods_name:_menuName num:_numBtn.titleLabel.text
 sale_money:[NSString stringWithFormat:@"%.2f",price*num] sale_id:@"-1" diet:dietArray];
    
    [QSUIHelper showTip:self.view tipStr:ADD_SHOP];
    [QSUIHelper showTabbar];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backBtnAct:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [QSUIHelper showTabbar];
}


#pragma mark - tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == firstTableView){
        return stapleFoodArr.count;
    }else{
        return soupArr.count;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *SimpleTableIdentifier = [NSString stringWithFormat:@"%@%d",@"SimpleTableIdentifier",indexPath.row] ;
    
    
    Menu *menu;
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    
    if(tableView == firstTableView){
        menu = [stapleFoodArr objectAtIndex:indexPath.row];
    }else{
        menu = [soupArr objectAtIndex:indexPath.row];
    }
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = menu.goods_name;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Menu *menu;
    if(tableView == firstTableView){
        menu = [stapleFoodArr objectAtIndex:indexPath.row];
        _first = [NSString stringWithFormat:@"%@",menu.id];
        sFirst = indexPath.row;
    }else{
        menu = [soupArr objectAtIndex:indexPath.row];
        _second = [NSString stringWithFormat:@"%@",menu.id];
        sSecond = indexPath.row;
    }
}

@end
