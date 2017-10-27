//
//  MyPersonViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPersonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,ActionDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSDictionary *dicuserinfo;
	UIView *maskView;
	NSString *result1;
	NSString *result2;
	NSMutableArray *content1;
	NSMutableArray *content2;
	UIImage *imageheader;
	int selectmodel;
}

@end
