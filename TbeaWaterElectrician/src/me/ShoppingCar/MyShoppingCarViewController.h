//
//  MyShoppingCarViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShoppingCarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate,UITextFieldDelegate>
{
	AppDelegate *app;
	NSMutableArray *arraydata;
	UITableView *tableview;
	NSMutableArray *arrarselectremoveitem;
	NSMutableArray *arrarselectsettlementitem;
	EnCollectionEdit collectionedit;
	NSMutableArray *arrayshopcarnumber;//记录每个商品购买多少个
	EnIsSelect selectremoveall;    //删除全选按钮状态
	EnIsSelect selectsettlementall; //结算全选按钮状态
	
}
@property(nonatomic)EnSearchType searchtype;
@property(nonatomic,strong)NSString *searchtext;

@end
