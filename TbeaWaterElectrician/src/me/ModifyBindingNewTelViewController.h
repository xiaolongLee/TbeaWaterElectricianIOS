//
//  ModifyBindingNewTelViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyBindingNewTelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	int getyanzhengcodeflag;
	NSTimer * timerone;
}


@end
