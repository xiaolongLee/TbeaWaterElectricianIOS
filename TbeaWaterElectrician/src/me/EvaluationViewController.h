//
//  EvaluationViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationViewController : UIViewController<UITextViewDelegate>
{
	AppDelegate *app;
	int nowxing;
}

@property(nonatomic,strong)NSDictionary *diccommdity;
@end
