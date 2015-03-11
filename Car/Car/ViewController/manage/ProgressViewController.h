//
//  ProgressViewController.h
//  DateApp
//
//  Created by likunding on 14-8-6.
//  Copyright (c) 2014年 likunding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *take1View;
@property (weak, nonatomic) IBOutlet UIView *take2View;
@property (weak, nonatomic) IBOutlet UIView *take3View;
@property (weak, nonatomic) IBOutlet UIView *take4View;
@property (weak, nonatomic) IBOutlet UIView *take5View;
@property (weak, nonatomic) IBOutlet UIView *take6View;

@property (weak, nonatomic) IBOutlet UILabel *time1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *time2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *time3Lbl;
@property (weak, nonatomic) IBOutlet UILabel *time4Lbl;
@property (weak, nonatomic) IBOutlet UILabel *time5Lbl;
@property (weak, nonatomic) IBOutlet UILabel *time6Lbl;

@property (nonatomic) NSNumber* bid;
@end
