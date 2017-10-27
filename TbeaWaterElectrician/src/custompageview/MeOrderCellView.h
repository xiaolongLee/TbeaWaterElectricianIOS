//
//  MeOrderCellView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeOrderCellView : UIView
{
	AppDelegate *app;
	NSDictionary *dicdatasrc;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)arrayfrom;
@end
