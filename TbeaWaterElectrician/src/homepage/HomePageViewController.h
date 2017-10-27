//
//  HomePageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<ActionDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
	NSDictionary *dichp;
	int flaginit;    //0表示初始化页面   1表示非初始化页面

}
@end
