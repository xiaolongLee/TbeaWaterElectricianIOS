//
//  SelectSpecificationView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/30.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSpecificationView : UIView<UITextFieldDelegate>
{
	NSString *specifiid;
	NSString *colorid;
	NSDictionary *diccommidifyinfo;
}
@property(nonatomic,strong)NSString *fromflag;  //1表示购物车进来的  2表示直接点击购买
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicData:(NSDictionary *)dicdata;
@end
