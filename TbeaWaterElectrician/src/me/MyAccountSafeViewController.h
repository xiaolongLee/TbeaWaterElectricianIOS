//
//  MyAccountSafeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountSafeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSDictionary *dicuseraccount;
}


@end
