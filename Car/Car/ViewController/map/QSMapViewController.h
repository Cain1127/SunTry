//
//  MapViewController.h
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCalloutView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface QSMapViewController : UIViewController<MAMapViewDelegate, AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

- (void)returnAction;
- (IBAction)carBtnAct:(id)sender;
- (IBAction)backBtnAct:(id)sender;
@end
