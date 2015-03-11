//
//  MyBookTableViewController.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBookTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
- (IBAction)backBtnAct:(id)sender;

@end
