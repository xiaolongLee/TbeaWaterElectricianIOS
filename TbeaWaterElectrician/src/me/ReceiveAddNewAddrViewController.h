//
//  ReceiveAddNewAddrViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveAddNewAddrViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	EnIsSelect isselect;
	NSDictionary *dicaddrselect;
	NSDictionary *modifydicaddr;
	NSString *strproviceid;
	NSString *strcityid;
	NSString *strareaid;
	NSString *straddress;
}

@property(nonatomic,strong)NSString *straddrid;
@end
