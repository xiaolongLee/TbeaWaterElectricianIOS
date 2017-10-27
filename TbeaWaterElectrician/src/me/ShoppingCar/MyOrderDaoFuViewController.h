//
//  MyOrderDaoFuViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDaoFuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
}
@property(nonatomic,strong)NSString *strorderid;
@property(nonatomic,strong)NSString *strorderins;
@property(nonatomic,strong)NSString *strorderfee;
@property(nonatomic,strong)NSString *strorderpaytype;
@property(nonatomic,strong)NSString *strorsendtype;
@end
