//
//  MyTixianQRCodeInfoViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//


//通过我的钱包进入的二维码生成页面
#import <UIKit/UIKit.h>

@interface MyTixianQRCodeInfoViewController : UIViewController
{
	AppDelegate *app;
	NSDictionary *dicmytixian;
	NSTimer *timertixian;
}
@property(nonatomic,strong)NSString *tixianid;
@end
