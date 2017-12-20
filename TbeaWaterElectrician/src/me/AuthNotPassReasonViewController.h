//
//  AuthNotPassReasonViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy on 2017/12/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthNotPassReasonViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
