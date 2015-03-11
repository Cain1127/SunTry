//
//  MenuViewController.h
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

@interface QSMenuViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *menuTableView;
    NSMutableArray *dataMArray;
    int page;
}
- (IBAction)backBtnAct:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bookLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
- (IBAction)userBtnAct:(id)sender;

@end
