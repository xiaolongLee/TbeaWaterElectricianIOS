//
//  ScanCodeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/30.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
@interface ScanCodeViewController : UIViewController<ZBarReaderDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
	AppDelegate *app;
	ZBarReaderViewController *readerzbar;
	NSString *resultText;
}
@end
