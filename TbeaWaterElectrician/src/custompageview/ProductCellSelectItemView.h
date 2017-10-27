//
//  ProductCellSelectItemView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCellSelectItemView : UIView
{
	NSDictionary *dicfrom;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic TagNow:(int)tagnow;
@end
