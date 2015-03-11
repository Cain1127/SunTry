//
//  MenuListViewController.m
//  Car
//
//  Created by System Administrator on 10/30/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "MenuListViewController.h"
#import "Menu.h"
#import "MJExtension.h"

@interface MenuListViewController ()

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [QSUIHelper setExtraCellLineHidden:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataMArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* mainDic = [_dataMArray objectAtIndex:indexPath.row];
    Menu *menu = [Menu objectWithKeyValues:mainDic];
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier];
        
        UILabel* numLbl = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 60, 10, 20, 20)];
        numLbl.tag = 100;
        numLbl.textAlignment = NSTextAlignmentRight;
        [cell addSubview:numLbl];
    }
    
    cell.textLabel.text = menu.good_name;
    
    UILabel *numLbl = (UILabel*)[cell viewWithTag:100];
    [numLbl setText:[NSString stringWithFormat:@"x%@",menu.num]];
    
    return cell;
}





@end
