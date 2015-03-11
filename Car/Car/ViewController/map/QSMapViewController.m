//
//  MapViewController.m
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSMapViewController.h"
#import "Post.h"
#import "CustomAnnotationView.h"
#import "AppDelegate.h"

#define kCalloutViewMargin          -8




@interface QSMapViewController ()
{
    UITableView *carTableView;
    AppDelegate *delegate;
    CLLocationCoordinate2D mycoordinate;
    NSMutableArray *carDetailMArray;
    NSMutableDictionary *carAddressMDic;
}

@end

@implementation QSMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QSUIHelper showHead:self.navigationController];
    
    [self initTitle:MAP_TITLE];
    
     delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    carDetailMArray = [[NSMutableArray alloc]init];
    
    carAddressMDic = [[NSMutableDictionary alloc]init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initMapView];
    [self initSearch];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [self.mapView setZoomLevel:16.1 animated:YES];

    
    /* Add a annotation on map center. */
    [self addAnnotationWithCooordinate];
    
    
    carTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    
    carTableView.dataSource = self;
    carTableView.delegate = self;
    [QSUIHelper setExtraCellLineHidden:carTableView];
    [carTableView setHidden:YES];
    
    [self.mapView addSubview:carTableView];
    
    
    UIButton* mylocateBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, self.mapView.frame.size.height - 70 , 50, 50)];
    [mylocateBtn setImage:[UIImage imageNamed:@"map_locateBtn.png"] forState:UIControlStateNormal];
    
    [mylocateBtn addTarget:self action:@selector(goCenterAct) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:mylocateBtn];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self returnAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize mapView = _mapView;
@synthesize search  = _search;

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
    
    self.mapView.userTrackingMode  = MAUserTrackingModeNone;
    self.mapView.showsUserLocation = NO;
}

- (IBAction)carBtnAct:(id)sender {
    
    if([carTableView isHidden]){
        
        [UIView animateWithDuration:0.5 animations:^{
            [carTableView setHidden:NO];
            [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
            [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
            [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        }completion:^(BOOL finished) {
            [carTableView setHidden:YES];
        }];
        
    }
    
}

#pragma mark - AMapSearchDelegate

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

#pragma mark - Initialization

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-125)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.search.delegate = self;
}



- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}


#pragma mark - Utility

-(void)addAnnotationWithCooordinate
{
    
   
    NSArray *carArray = delegate.ALLCARARRAY;
    
    for (int i = 0; i<carArray.count; i++) {
        NSDictionary* carDic = [carArray objectAtIndex:i];
        NSMutableDictionary *param1Dic = [[NSMutableDictionary alloc]init];
        [param1Dic setValue:@"1" forKey:@"mer_id"];
        [param1Dic setValue:[carDic objectForKey:@"id"] forKey:@"car_id"];
        
        [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
            if(error == nil){
                
                NSArray* dataArray = (NSArray*)posts;
                if ([dataArray count]>0) {
                    NSDictionary* positionDic = [dataArray objectAtIndex:0];
                    
                    [carDetailMArray addObject:positionDic];
                    
                    
                    NSDictionary* carPositionDic = [positionDic objectForKey:@"carPosition"];
                    
                    CLLocationCoordinate2D coordinate;
                    coordinate.latitude = [[carPositionDic objectForKey:@"latitude"] floatValue];
                    coordinate.longitude = [[carPositionDic objectForKey:@"longitude"] floatValue];
                    
                    
                    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
                    annotation.coordinate = coordinate;
                    annotation.title    = @"AutoNavi";
                    annotation.subtitle = @"CustomAnnotationView";
                    
                    [self.mapView addAnnotation:annotation];
                    
                    
                    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
                    regeoRequest.searchType = AMapSearchType_ReGeocode;
                    regeoRequest.location = [AMapGeoPoint locationWithLatitude:[[carPositionDic objectForKey:@"latitude"] floatValue] longitude:[[carPositionDic objectForKey:@"longitude"] floatValue]];
                    regeoRequest.radius = 10000;
                    regeoRequest.requireExtension = YES;
//                    regeoRequest.poiIdFilter = [carPositionDic objectForKey:@"id"];
                    
                    [self.search AMapReGoecodeSearch: regeoRequest];
                }else{
                    [carDetailMArray addObject:@{@"error":@""}];
                }
            }else{
                if(error.code == -1000){
                    
                    NSArray* index =(NSArray*)posts;
                    [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                }
                [carDetailMArray addObject:@{@"error":@""}];
            }
        }:@"car/getCarPostion" parameters:param1Dic fileName:@""];
    }

}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    NSLog(@"%@",request.poiIdFilter);
    
    
    
    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.formattedAddress ];
    NSLog(@"ReGeo: %@", result );
    
    [carAddressMDic setValue:result forKey:request.poiIdFilter];
    
}

- (CGPoint)randomPoint
{
    CGPoint randomPoint = CGPointZero;
    
    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));
    
    return randomPoint;
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        

        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"map_carIcon.png"];
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(self.mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"map_myIcon.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }  
}

#pragma tableview 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return delegate.ALLCARARRAY.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];

    NSDictionary* dDic = [delegate.ALLCARARRAY objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
        
    }
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell.textLabel setText:[dDic objectForKey:@"car_name"]];
    
    NSArray* addressKeyArray = [carAddressMDic allKeys];
    if([addressKeyArray containsObject:[dDic objectForKey:@"id"]]){
        [cell.detailTextLabel setText:[carAddressMDic objectForKey:[dDic objectForKey:@"id"]]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row <= carDetailMArray.count){
        NSDictionary*positionDic = [carDetailMArray objectAtIndex:indexPath.row];
        
        NSArray * allKeysArray = [positionDic allKeys];
        if([allKeysArray containsObject:@"carPosition"]){
        
            NSDictionary* carPositionDic = [positionDic objectForKey:@"carPosition"];
            
            NSArray* allKeyArray = [carPositionDic allKeys];
            
            if([allKeyArray containsObject:@"latitude"]){
            
                if([carPositionDic objectForKey:@"latitude"]!= nil){
                    CLLocationCoordinate2D coordinate;
                    coordinate.latitude = [[carPositionDic objectForKey:@"latitude"] floatValue];
                    coordinate.longitude = [[carPositionDic objectForKey:@"longitude"] floatValue];
                
                    [self.mapView setCenterCoordinate:coordinate animated:YES];
                }
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        [carTableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    }completion:^(BOOL finished) {
        [carTableView setHidden:YES];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
    mycoordinate.latitude = userLocation.location.coordinate.latitude;
    mycoordinate.longitude = userLocation.location.coordinate.longitude;
}


- (IBAction)backBtnAct:(id)sender {
    [QSUIHelper showMain:self.navigationController];
}


-(void)goCenterAct
{
    [self.mapView setCenterCoordinate:mycoordinate animated:YES];
}
@end
