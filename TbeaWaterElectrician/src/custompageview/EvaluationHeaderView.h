//
//  EvaluationHeaderView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationHeaderView : UIView
{
	NSDictionary *dicfrom;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic FromFlag:(NSString *)fromflag;
@end
