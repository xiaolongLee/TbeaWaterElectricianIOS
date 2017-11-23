//
//  NearByGoodsDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>
@interface NearByGoodsDetailViewController : UIViewController<UIWebViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
	UIWebView *webview;
	UITableView *tableview;
	NSMutableArray *arraydata;
	NSMutableArray *arrayheight;
	EnGoodsItme selectitem;
	NSDictionary *dicgoodsinfo;
	
	GoodsDetailBottomView *goodview;
    
    NSString *FCrecvaddressid;
    NSString *FCspecifiid;
    NSString *FCmodelid;
    NSString *FCcolorid;
    
}
@property(nonatomic,strong)NSString *fromflag;
@property(nonatomic,strong)NSString *strdistributype;//经销商类型 1.notdistributor 不跳转  2.firstleveldistributor 总经销商  3.distributor  分经销商
@property(nonatomic,strong)NSString *strdistrid;
@property(nonatomic,strong)NSString *strproductid;
@end
