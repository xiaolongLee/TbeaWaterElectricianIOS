//
//  InComeDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InComeDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraydata;
}
@property(nonatomic,strong)NSString *fromflag;

@end
