//
//  ModifyPersonInfoViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPersonInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
}

@property(nonatomic,strong)NSString *FCtitle;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
