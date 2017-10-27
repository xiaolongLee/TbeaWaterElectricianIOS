//
//  JXSPageViewCellView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByJXSPageViewCellView : UIView
{
	NSDictionary *dicfrom;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic FomeFlag:(NSString *)fromflag;
@end
