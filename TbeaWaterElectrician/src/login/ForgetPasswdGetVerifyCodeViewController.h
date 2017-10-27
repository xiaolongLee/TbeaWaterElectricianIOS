//
//  ForgetPasswdGetVerifyCodeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswdGetVerifyCodeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	int getyanzhengcodeflag;
	NSTimer * timerone;
}

@property(nonatomic,strong)NSString *strtel;

@end
