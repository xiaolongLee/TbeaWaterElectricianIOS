//
//  ProductPageCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByProductPageCellView.h"

@implementation NearByProductPageCellView


-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicfrom = dic;
		[self initview];
	}
	return self;
}

-(void)initview
{
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 80, 80)];
	NSURL *urlstr = [NSURL URLWithString:[dicfrom objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	NSString *str = [dicfrom objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-100 Fheight:38 Sfont:FONTN(14.0f)];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y,size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(14.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, SCREEN_WIDTH-100, 33)];
	labelins.text = [dicfrom objectForKey:@"specification"];
	labelins.font = FONTN(13.0f);
	labelins.numberOfLines = 2;
	labelins.textColor = ColorBlackGray;
	[self addSubview:labelins];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelins.frame.origin.x, imageviewleft.frame.origin.y+imageviewleft.frame.size.height-18, 100, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[dicfrom objectForKey:@"price"]];
	labelprice.font = FONTN(13.0f);
	labelprice.textColor = Colorredcolor;
	[self addSubview:labelprice];
	
	UILabel *labeldistance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelprice.frame.origin.y, 90, 20)];
	labeldistance.text = [dicfrom objectForKey:@"distance"];
	labeldistance.font = FONTN(13.0f);
	labeldistance.textAlignment = NSTextAlignmentRight;
	labeldistance.textColor = Colorqingsecolor;
	[self addSubview:labeldistance];
}

@end
