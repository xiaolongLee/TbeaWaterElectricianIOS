//
//  SelectCityViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSArray *arraydata;
	UITableView *tableview;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
