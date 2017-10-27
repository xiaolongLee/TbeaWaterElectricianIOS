//
//  NearByJXSDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByJXSDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arrayheight;   //tableview cell高度数组
	EnIsSelect promoteselect;   //是否只显示促销商品
	EnJSXOrderItem jsxorderitem;  //排序模式
	EnJSXOrder jsxsaleorder;    //排序方式
	EnJSXOrder jsxpriceorder;    //排序方式
	EnNearByJXSItem jxsitem;   // 选择的是全部商品，工程招标，招聘信息还是公司动态
	NSDictionary *diccompanybaseinfo;   //公司基本信息
	NSArray *arraydata;
	NSString *nowjxsid;
}
@property(nonatomic,strong)NSString *strdistribuid;
@property(nonatomic,strong)NSDictionary *dicjsxfrom;
@end
