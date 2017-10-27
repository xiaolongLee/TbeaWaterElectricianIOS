//
//  CustomNavigationController.m
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	UIColor * radomcolor = ColorBlue;
    
    self.navigationBar.barTintColor = radomcolor;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
