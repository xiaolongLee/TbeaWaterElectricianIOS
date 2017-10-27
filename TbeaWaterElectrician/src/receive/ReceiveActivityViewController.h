//
//  ReceiveActivityViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveActivityViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate>
{
	AppDelegate *app;
	NSArray *arraytype;  //类型
	NSArray *arrayarea;  //区域
	NSArray *arraytime;//认证状态
	int selectmodel;   //选择类型,区域,时间
	UIView *maskView;
	NSString *result;
	NSMutableArray *content1;
	NSString *stypeid;  //选择的类型
	NSString *sareaid;  //选择的区域
	NSString *stimeid; //选择的认证状态
	NSArray *arraydata;//列表数据
	NSString *scityid;
	NSString *scityname;
}
@end
