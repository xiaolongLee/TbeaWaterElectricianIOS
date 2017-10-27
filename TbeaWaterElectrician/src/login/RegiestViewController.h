//
//  RegiestViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegiestViewController : UIViewController<UITextFieldDelegate>
{
	AppDelegate *app;
	NSTimer * timerone;
	int getyanzhengcodeflag;
	NSString *regiestphone;
	NSString *regiestcode;
	NSString *regiestpwd;
	UIImage *imagecard1;
	UIImage *imagecard2;
	UIImage *imagecard3;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
