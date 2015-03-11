//
//  PickEditViewController.m
//  Car
//
//  Created by System Administrator on 10/30/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "PickEditViewController.h"

@interface PickEditViewController ()

@end

@implementation PickEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [_titleLbl setText:_titleStr];
    
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
    NSString* phone = [_dataMArray objectAtIndex:indexPath.row];
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier];
        
        UIButton* delBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width - 60, 10, 20, 20)];
        [delBtn setImage:[UIImage imageNamed:@"manage_minusIcon.png"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(delBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        delBtn.tag = indexPath.row;
        [cell addSubview:delBtn];
    }
    
    cell.textLabel.text = phone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ddd--%d",indexPath.row);
    if (self.delegate) {
        [self.delegate PickEditSelectedAct:_tag selected:indexPath.row];
    }
}

#pragma mark - delBtnAct
-(void)delBtnAct:(id)sender{
    UIButton* uBtn = (UIButton*)sender;
    
    [_tableView beginUpdates];
    [_dataMArray removeObjectAtIndex:uBtn.tag];
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:uBtn.tag inSection:0];
    [indexPaths addObject:indexPath];
    [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    [_tableView endUpdates];
    
    
    if (self.delegate) {
        [self.delegate PickEditDelAct:_tag selected:uBtn.tag];
    }
    
}



@end
