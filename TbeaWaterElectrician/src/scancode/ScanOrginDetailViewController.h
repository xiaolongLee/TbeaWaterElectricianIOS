//
//  ScanOrginDetailViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanOrginDetailViewController : UIViewController
{
	AppDelegate *app;
	UIScrollView *scrollview;
	UIView *view1;
	UIView *view2;
	NSDictionary *dicdata;
}
@property(nonatomic,strong)NSString *scancode;
@end
