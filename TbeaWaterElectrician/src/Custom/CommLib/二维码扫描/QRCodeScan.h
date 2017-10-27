//
//  QRCodeScan.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-7-12.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
@interface QRCodeScan : UIViewController<ZBarReaderDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
	AppDelegate *app;
	UIScrollView *scrollview;
	NSDictionary *dicdata;
	NSDictionary *dicscan;
	NSDictionary *diccardjson;
	int backflag;
	ZBarReaderViewController *readerzbar;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *resultText;
@end
