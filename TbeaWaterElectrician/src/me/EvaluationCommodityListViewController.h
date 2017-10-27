//
//  EvaluationCommodityListViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationCommodityListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *arraydata;
}

@property(nonatomic,strong)NSDictionary *diccommdity;
@end
