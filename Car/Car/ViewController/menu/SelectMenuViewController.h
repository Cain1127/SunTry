//
//  SelectMenuViewController.h
//  Car
//
//  Created by likunding on 14-10-15.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SelectMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (copy,nonatomic)NSString* mid;
@property (copy,nonatomic)NSString* menuName;
@property (copy,nonatomic)NSString* price;

@property (weak, nonatomic) IBOutlet UILabel *mainLbl;
@property (weak, nonatomic) IBOutlet UILabel *otherLbl;

@property (copy,nonatomic)NSString* first;
@property (copy,nonatomic)NSString* second;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@property (weak, nonatomic) IBOutlet UILabel *bookMenuLbl;
@property (strong, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIView *soupSpView;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

- (IBAction)numBtnAct:(id)sender;

//- (IBAction)shopBtnAct:(id)sender;
- (IBAction)backBtnAct:(id)sender;

@end
