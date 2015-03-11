//
//  ShopViewController.h
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSShopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)couponBtnAct:(id)sender;
- (IBAction)couponNumBtnAct:(id)sender;
- (IBAction)SubmitBtnAct:(id)sender;
- (IBAction)backBtnAct:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UITableView *BuyListTableView;
@end
