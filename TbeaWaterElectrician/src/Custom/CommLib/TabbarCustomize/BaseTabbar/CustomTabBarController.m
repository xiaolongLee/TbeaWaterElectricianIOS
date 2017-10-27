//
//  CustomTabBarController.m
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "CustomNavigationController.h"

@interface CustomTabBarController ()<CustomTabBarTypeDelegate>

@property (nonatomic,strong) CustomTabBar *itemTabBar;
@end

@implementation CustomTabBarController


- (void)selectedBarItemWithType:(CustomTabBarType)type{
    
    if (type!=CustomTabBarTypeLaunch) {
        self.selectedIndex = type - CustomTabBarTypehomepage;
        return;
    }
    
    SelectCityViewController *launchView = [[SelectCityViewController alloc] init];
    [self presentViewController:launchView animated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//
	
	self.tabBar.hidden = YES;
	//    // 把系统的tabBar上的按钮干掉
//	for (UIView *childView in self.tabBar.subviews) {
//		if (![childView isKindOfClass:[CustomTabBar class]]) {
//			[childView removeFromSuperview];
//			
//		}
//	}
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置
    [self configViewConrollers];
    [self.view addSubview:self.itemTabBar];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
}


- (void)configViewConrollers{
	
	HomePageViewController *hp = [[HomePageViewController alloc] init];
	NearByPageViewController *nearby = [[NearByPageViewController alloc] init];
	ReceiveActivityViewController *receive = [[ReceiveActivityViewController alloc] init];
	MyPageViewController *mypage = [[MyPageViewController alloc] init];
	
    NSMutableArray *viewArray = [NSMutableArray arrayWithArray:@[hp,nearby,receive,mypage]];
    
    for (NSInteger i = 0; i < viewArray.count; i ++) {
		
        UIViewController *viewClass = viewArray[i];

        CustomNavigationController *navigationController = [[CustomNavigationController alloc] initWithRootViewController:viewClass];
        
        [viewArray replaceObjectAtIndex:i withObject:navigationController];
    }
    self.viewControllers = viewArray;
}

- (CustomTabBar *)itemTabBar{
    if (!_itemTabBar) {
        CGRect rect = self.tabBar.frame;
        _itemTabBar = [[CustomTabBar alloc] initWithFrame:rect];
        _itemTabBar.delegate = self;
    }
    return _itemTabBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
