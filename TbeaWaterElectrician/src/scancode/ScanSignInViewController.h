//
//  ScanSignInViewController.h
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 扫码签到
 **/

#import <UIKit/UIKit.h>

@interface ScanSignInViewController : UIViewController
{
    AppDelegate *app;
    NSDictionary *FCdicdata;
}
@property(nonatomic,strong)NSString *FCscancode;
@end
