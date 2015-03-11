//
//  AddAddressViewController.h
//  Car
//
//  Created by likunding on 14-10-19.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddAddressViewDelegate;


@interface AddAddressViewController : UIViewController

@property (assign, nonatomic) id <AddAddressViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *proTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
- (IBAction)AddressBtnAct:(id)sender;

@end


@protocol AddAddressViewDelegate<NSObject>
@optional
- (void)AddressOkButtonClicked:(NSString*)address;
@end