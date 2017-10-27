//
//  GoodsPingJiaCellView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsPingJiaCellView : UIView
{
	AppDelegate *app;
	NSDictionary *dicdatasrc;
}

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)arrayfrom;
@end
