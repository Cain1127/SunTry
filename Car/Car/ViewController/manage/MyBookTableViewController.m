//
//  MyBookTableViewController.m
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "MyBookTableViewController.h"
#import "MyBookTableViewCell.h"
#import "Post.h"
#import "User.h"
#import "Book.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "TimeUtils.h"

@interface MyBookTableViewController (){
    NSMutableArray *dataMArray;
    int page;
}
@end

@implementation MyBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = BOOK_TITLE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QSUIHelper showTabbar];
    User *user = [User sharedInstance];
    if([user isLogin]==false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
        return;
    }
    
    [self initTableView];
    
    [QSUIHelper showHead:self.navigationController];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [dataMArray removeAllObjects];
    dataMArray = nil;
}

-(void)initTableView
{
    _bookTableView.dataSource = self;
    _bookTableView.delegate = self;
    _bookTableView.rowHeight = 60;
    
    [QSUIHelper setExtraCellLineHidden:_bookTableView];
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_bookTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //warning 自动刷新(一进入程序就下拉刷新)
    [_bookTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_bookTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
    dataMArray = [[NSMutableArray alloc]init];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataMArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBookTableViewCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyBookTableViewCell" owner:self options:nil] lastObject];

    }
    
    if(dataMArray != nil){
        if(dataMArray.count>0){
            Book* book = [dataMArray objectAtIndex:indexPath.row];
        
            [cell setStatus:book.status];
            [cell.bookNumLbl setText:[NSString stringWithFormat:@"订单编号：%@",book.order_num]];
            [cell setPayTypeText:book.expand_5];
            [cell.timeLbl setText:[NSString stringWithFormat:@"%@ %@",[TimeUtils TimeToDate:book.get_time],book.get_time]];
            [cell.numLbl setText:[NSString stringWithFormat:@"%@份/￥%@",book.diet_total_num,book.total_money]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book* book = [dataMArray objectAtIndex:indexPath.row];
    [QSUIHelper showDetail:self.navigationController mid:book.id];
}


#pragma mark - Refresh and load more methods
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"now_page"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        page = 1;
        if(error == nil){
            
            NSDictionary *bookDic = (NSDictionary*)posts;
            NSArray* records = [bookDic objectForKey:@"records"];
            NSArray* bookArray = [Book objectArrayWithKeyValuesArray:records];
            
            [dataMArray removeAllObjects];
            
            for (Book *book in bookArray) {
                [dataMArray addObject:book];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_bookTableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_bookTableView headerEndRefreshing];
            });
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }else{
                
            }
        }
    }:@"order/uList" parameters:paramDic fileName:@""];
    
    
}

- (void)footerRereshing
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"now_page"];
    
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        page++;
        
        if(error == nil){
            
            NSDictionary *bookDic = (NSDictionary*)posts;
            NSArray* records = [bookDic objectForKey:@"records"];
            NSArray* bookArray = [Book objectArrayWithKeyValuesArray:records];
            
            for (Book *book in bookArray) {
                [dataMArray addObject:book];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_bookTableView reloadData];
                
                [_bookTableView footerEndRefreshing];
            });
            
        }else{
            if(error.code == -1000){
                
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
            }else{
                
            }
        }
    }:@"order/uList" parameters:paramDic fileName:@""];
    
}

- (IBAction)backBtnAct:(id)sender {
    [QSUIHelper showMain:self.navigationController];
}
@end
