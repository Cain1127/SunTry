//
//  PickEditViewController.h
//  Car
//
//  Created by System Administrator on 10/30/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickEditViewDelegate;

@interface PickEditViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString* titleStr;
@property (strong, nonatomic) NSMutableArray* dataMArray;
@property (nonatomic) NSInteger tag;
@property (nonatomic) NSInteger selected;

@property (assign, nonatomic) id <PickEditViewDelegate>delegate;

@end

@protocol PickEditViewDelegate<NSObject>
@optional
- (void)PickEditSelectedAct:(NSInteger)tag selected:(NSInteger)selected;
- (void)PickEditDelAct:(NSInteger)tag selected:(NSInteger)selected;
@end