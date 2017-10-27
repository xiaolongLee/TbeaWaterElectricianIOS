//
//  MyPageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
	NSDictionary *dicuserinfo;
	NSDictionary *dicserviceinfo;
}
@end
