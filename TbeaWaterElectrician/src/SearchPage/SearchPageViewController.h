//
//  SearchPageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPopupMenu.h"
@interface SearchPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate,YBPopupMenuDelegate>
{
	AppDelegate *app;
	NSMutableArray *arraydata;
	NSArray *arrayhot;
	UITableView *tableview;
	EnSearchType searchtype;
    YBPopupMenu *ybpopmenu;
}

@end
