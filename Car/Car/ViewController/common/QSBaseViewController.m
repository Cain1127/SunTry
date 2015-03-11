

#import "QSBaseViewController.h"
#import "QStabbarView.h"
#import "QSMainViewController.h"
#import "QSShakeViewController.h"
#import "QSMenuViewController.h"
#import "QSMapViewController.h"
#import "QSLoginViewController.h"
#import <AFNetworking.h>

#define SELECTED_VIEW_CONTROLLER_TAG 888888
@interface QSBaseViewController()

@end


@implementation QSBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rx = [UIScreen mainScreen ].bounds;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    NSLog(@"width:%f,height:%f,viewheight:%f",rx.size.width,rx.size.height,self.view.frame.size.height);
    _tabbar = [[TabbarView alloc]initWithFrame:CGRectMake(0,  rx.size.height - 68, rx.size.width, 68)];
    _tabbar.delegate = self;
    [self.view addSubview:_tabbar];
    
    _arrayViewcontrollers = [self getViewcontrollers];
    
    
    [self touchBtnAtIndex:5];
    
    [QSUIHelper setBaseViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    NSDictionary* data = [_arrayViewcontrollers objectAtIndex:index];
    
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    UIViewController *viewController = data[@"viewController"];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = CGRectMake(0,0,rx.size.width, rx.size.height);
    
    [self.view insertSubview:viewController.view belowSubview:_tabbar];

    
}

-(NSArray *)getViewcontrollers
{
    
    NSArray* tabBarItems = nil;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    
    UINavigationController *shopNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"ShopNavigationController"];
    
    UINavigationController *myBookNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MyBookNavigationController"];
    
    UINavigationController *mapNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MapNavigationController"];
    
    UINavigationController *menuNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MenuNavigationController"];
    
    UINavigationController *CouponActivityNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"CouponActivityNavigationController"];

    
    tabBarItems = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", CouponActivityNavigationController, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", shopNavigationController, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", myBookNavigationController, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", mapNavigationController, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked",menuNavigationController , @"viewController",@"主页",@"title", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked",mainNavigationController , @"viewController",@"主页",@"title", nil],
                   nil];
    
    return tabBarItems;
    
}

-(void)showTabbar
{
    [_tabbar setHidden:NO];
    [self.tabBar setHidden:NO];
}
-(void)hideTabbar
{
    [_tabbar setHidden:YES];
    [self.tabBar setHidden:YES];
}

@end
