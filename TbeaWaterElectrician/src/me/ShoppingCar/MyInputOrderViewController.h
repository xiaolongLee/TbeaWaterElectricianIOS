//
//  MyInputOrderViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInputOrderViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ActionDelegate>
{
	AppDelegate *app;
	UITableView *tableview;
	NSDictionary *dicdata;
	NSString *straddrid;
	NSString *strpaytypeid;
	NSString *strdeliverytypeid;
	NSString *stractualneedpaymoney;
}
@property(nonatomic,assign)float inttotalmoney;
@property(nonatomic,strong)NSMutableArray *arraycommonditynumber;  //选择的商品配置数目
@property(nonatomic,strong)NSMutableArray *arraycommonditypic;  //选择的商品配置图片
@end
