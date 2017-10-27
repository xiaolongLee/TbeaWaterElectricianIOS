//
//  ScanInputQRCodeViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanInputQRCodeViewController : UIViewController<UITextFieldDelegate>
{
	AppDelegate *app;
	
}
@property(nonatomic,assign)EnScanCodeType codetype;
@end
