//
//  ScanRebateViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanRebateViewController : UIViewController
{
	AppDelegate *app;
	NSDictionary *dicdata;
	NSMutableArray *arrayrebatelist;
}
@property(nonatomic,assign)int fromflag;//1表示 扫码进来的  2表示返利列表进来的
@property(nonatomic,strong)NSString *scancode;
@end
