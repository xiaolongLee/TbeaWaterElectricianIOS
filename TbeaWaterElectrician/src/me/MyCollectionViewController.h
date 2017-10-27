//
//  MyCollectionViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSMutableArray *arraydata;
	UITableView *tableview;
	NSMutableArray *arrarselectitem;
	EnCollectionEdit collectionedit;
}
@property(nonatomic)EnSearchType searchtype;
@property(nonatomic,strong)NSString *searchtext;

@end
