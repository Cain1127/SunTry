//
//  CouponActivity2TableViewController.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponActivity2TableViewController : UITableViewController

@property (copy,nonatomic) NSNumber* mid;
@property (copy,nonatomic) NSString* type;
@property (weak, nonatomic) IBOutlet UITableViewCell *headCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bodyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *contentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *foodCell;
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end
