//
//  LoginView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/14.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)UIViewController *homepage;
@end
