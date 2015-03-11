
#import <UIKit/UIKit.h>



@class TabbarView;

@protocol tabbarDelegate <NSObject>

-(void)touchBtnAtIndex:(NSInteger)index;

@end


@interface QSBaseViewController : UITabBarController<tabbarDelegate>

@property(nonatomic,strong) TabbarView *tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;

-(void)showTabbar;
-(void)hideTabbar;

@end
