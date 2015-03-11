//
//  DetailViewController.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (copy,nonatomic) NSNumber* mid;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendCarLbl;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *couponLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *bookNumLbl;

@property (weak, nonatomic) IBOutlet UILabel *totalLbl;
- (IBAction)selectSegAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *erweimaBtn;
- (IBAction)erwemaBtnAct:(id)sender;

@end
