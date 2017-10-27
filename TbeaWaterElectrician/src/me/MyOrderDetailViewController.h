//
//  MyOrderDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSDictionary *dicdata;
	
}
@property(nonatomic,strong)NSString *strorderid;

@end
