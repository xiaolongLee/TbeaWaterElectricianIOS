//
//  MyOrderViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *arraydata;
	NSArray *arrayorderstatus;
	NSString *orderstatusid;
}
@end
