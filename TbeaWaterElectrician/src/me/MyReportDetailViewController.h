//
//  MyReportDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReportDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,ActionDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraypic;
//	NSArray *arrayreporttype;

	
//	NSString *reportid;
//	NSString *reportname;
	NSDictionary *dicreportinfo;
}
@property(nonatomic,strong)NSString *strreportid;
@end
