//
//  ShakeViewController.h
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface QSShakeViewController : UIViewController
{
    SystemSoundID                 soundID;
}
- (IBAction)backBtnAct:(id)sender;
- (IBAction)shopBtnAct:(id)sender;

@end
