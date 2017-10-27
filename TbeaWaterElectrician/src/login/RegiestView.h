//
//  RegiestView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/14.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegiestView : UIView<UITextFieldDelegate>
{
	AppDelegate *app;
	NSTimer * timerone;
	int getyanzhengcodeflag;
	NSString *regiestphone;
	NSString *regiestcode;
	NSString *regiestpwd;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)UIViewController *homepage;
@end
