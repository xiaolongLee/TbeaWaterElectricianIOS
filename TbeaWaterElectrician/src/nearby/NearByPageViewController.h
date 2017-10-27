//
//  NearByPageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NearByTag nearbytag;
	int selectmodel;   //选择类型,区域,状态
	int selectitem;   //选择经销商，商家 ，采购
	UIView *maskView;
	NSString *result;
	NSMutableArray *content1;
	NSArray *arraytype;  //类型
	NSArray *arrayarea;  //区域
	NSArray *arraycerfi;//认证状态
	NSArray *arraygoodtype;//商品类型
	NSArray *arraygoodBrand;//商品品牌
	
	NSString *stypeid;  //选择的类型
	NSString *sareaid;  //选择的区域
	NSString *scerfiid; //选择的认证状态
	NSString *sgoodstypeid;//商品类型
	NSString *sgoodsbrandid;//商品品牌
	NSString *scityid;
	NSString *scityname;
	
	
	NSArray *arraydata;//列表数据
	
	
}

@end
