//
//  GoodsDetailBottomView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailBottomView : UIView
{
	
}

-(void)addgouwuchenumber:(NSString *)number;
-(void)setproductcollection:(NSString *)iscollection;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(void)clickaddgwc:(id)sender;
@end
