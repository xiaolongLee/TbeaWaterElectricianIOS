//
//  MyMettingListViewController.h
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMettingListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    

    NSString *FCorderitem;//选择的排序项
    NSString *FCorderid;//选择的排序方式
    NSArray  *FCarraydata;//列表数据
    
    NSString *FCordercode;
    NSString *FCorderdate;
    
    UIView *tabviewheader;
    UIView *sortitem;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
