//
//  QSCouponViewController.h
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QSCouponViewDelegate;

@interface QSCouponViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray* dataArray;
@property (assign, nonatomic) id <QSCouponViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *couponTableView;
- (IBAction)joinBtnAct:(id)sender;

@end

@protocol QSCouponViewDelegate<NSObject>
@optional
- (void)JoinBtnClicked:(NSString*)cid;
@end
