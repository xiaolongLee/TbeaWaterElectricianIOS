//
//  MyReportListViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReportListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *arraydata;
	NSMutableArray *arrayheight;
}


@end
