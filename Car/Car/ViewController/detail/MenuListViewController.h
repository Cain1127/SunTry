//
//  MenuListViewController.h
//  Car
//
//  Created by System Administrator on 10/30/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* dataMArray;
@end
