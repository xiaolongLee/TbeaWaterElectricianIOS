//
//  ScanReportCodeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanReportCodeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,ActionDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraypic;
	NSArray *arrayreporttype;
	UIView *maskView;
	NSString *result1;
	NSString *result2;
	NSMutableArray *content1;
	NSMutableArray *content2;
	int selectmodel;
	
	NSString *reportid;
	NSString *reportname;
	NSDictionary *dicreportinfo;
}
@property(nonatomic,strong)NSString *strtitle;
@property(nonatomic,strong)NSString *strcommdityname;
@property(nonatomic,strong)NSString *strcommdityid;
@property(nonatomic,strong)NSString *strscancode;
@end
