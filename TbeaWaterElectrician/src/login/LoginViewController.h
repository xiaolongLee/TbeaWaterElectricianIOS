//
//  LoginViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
