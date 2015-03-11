//
//  MainTableViewController.h
//  Car
//
//  Created by System Administrator on 9/26/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "Menu.h"


@protocol MenuClickDelegate

-(void)menuClickValue:(Menu*)menu;
-(void)buyClickValue:(Menu*)menu;

@end

@interface TableDataSource : NSObject <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dModel;
@property (nonatomic,assign) id<MenuClickDelegate> delegate;

@end


@interface QSMainTableViewController : UITableViewController<SGFocusImageFrameDelegate,UITableViewDataSource,MenuClickDelegate>{
    TableDataSource * source;
}
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImgView;

@property (strong, nonatomic) IBOutlet UITableView *recommendTableView;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;

- (IBAction)shakeBtnAct:(id)sender;
- (IBAction)menuBtnAct:(id)sender;
- (IBAction)callBtnAct:(id)sender;
- (IBAction)checkBtnAct:(id)sender;
- (IBAction)bookBtnAct:(id)sender;

@end
