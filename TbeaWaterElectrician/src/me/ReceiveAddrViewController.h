//
//  ReceiveAddrViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveAddrViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraydata;
}

@property(nonatomic,strong)NSString *fromaddr;//1表示从地址管理进来  2表示从购买商品进来  3表示商品详情选取的地址
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
