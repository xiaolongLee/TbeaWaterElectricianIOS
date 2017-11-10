//
//  MyMettingDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMettingDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSDictionary *FCdicdata;
    NSArray *FCarrayjibandanwei;
    NSDictionary *FCmeetingbaseinfo;
    NSDictionary *FCcheckininfo;
    
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
