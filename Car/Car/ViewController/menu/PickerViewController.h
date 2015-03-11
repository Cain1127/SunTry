//
//  SexViewController.h
//  DateApp
//
//  Created by likunding on 14-6-14.
//  Copyright (c) 2014年 likunding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate;

@interface PickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>


@property (assign, nonatomic) id <PickerViewDelegate>delegate;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (retain,nonatomic) NSMutableArray* selectArr;
@property (nonatomic) NSInteger selected;
@property (nonatomic) NSInteger toughed;
@property (nonatomic) NSInteger tag;
- (IBAction)closeAct:(id)sender;

@end

@protocol PickerViewDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(PickerViewController*)ViewController;
@end
