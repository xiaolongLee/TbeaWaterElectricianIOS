//
//  MyTiXianQRCodeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
//通过生成提现进入的二维码生成页面
#import <UIKit/UIKit.h>

@interface MyTiXianQRCodeViewController : UIViewController
{
	AppDelegate *app;
	NSDictionary *dicmytixian;
	NSTimer *timertixian;
}
@property(nonatomic,strong)NSString *strdistribuid;
@property(nonatomic,strong)NSString *tixianmoney;
@end
