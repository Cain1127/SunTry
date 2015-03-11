//
//  AddPhoneViewController.h
//  Car
//
//  Created by likunding on 14-10-19.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPhoneViewDelegate;


@interface AddPhoneViewController : UIViewController

@property (assign, nonatomic) id <AddPhoneViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
- (IBAction)okBtnAct:(id)sender;


@end

@protocol AddPhoneViewDelegate<NSObject>
@optional
- (void)OkButtonClicked:(NSString*)phone;
@end
