//
//  ScanProductCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanProductCellView.h"

@implementation ScanProductCellView

-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic
{
	self = [super initWithFrame:frame];
	if(self)
	{
		[self initview:dic];
	}
	return self;
}

-(void)initview:(NSDictionary *)dic
{
	self.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 60, 60)];
	NSURL *urlstr = [NSURL URLWithString:[dic objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y, SCREEN_WIDTH-100, 40)];
	labelname.text = [dic objectForKey:@"name"];
	labelname.font = FONTN(15.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, 100, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
	labelprice.font = FONTN(14.0f);
	labelprice.textColor = Colorredcolor;
	[self addSubview:labelprice];
}

@end
