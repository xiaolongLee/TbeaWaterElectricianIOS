//
//  ScanHistoryViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraydata;
}
@end
