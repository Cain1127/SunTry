//
//  CouponActivityTableViewController.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponActivityTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *couponNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *couponTimeLbl;

@property (weak, nonatomic) IBOutlet UIWebView *descWebView;

- (IBAction)bookBtnAct:(id)sender;

- (IBAction)backBtnAct:(id)sender;
@end
