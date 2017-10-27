//
//  MyTiXianDoneViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTiXianDoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
}
@property(nonatomic,strong)NSString *fromflag;
@property(nonatomic,strong)NSDictionary *dicfrom;

@end
