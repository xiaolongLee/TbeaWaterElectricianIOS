//
//  EvaluationHeaderView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "EvaluationHeaderView.h"

@implementation EvaluationHeaderView
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic FromFlag:(NSString *)fromflag
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicfrom = dic;
		self.backgroundColor = [UIColor whiteColor];
		[self initview:fromflag];
	}
	return self;
}

-(void)initview:(NSString *)fromflag
{
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
	NSURL *urlstr = [NSURL URLWithString:[dicfrom objectForKey:@"commoditypicture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	NSString *str = [dicfrom objectForKey:@"commodityname"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-100 Fheight:38 Sfont:FONTN(15.0f)];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y,size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(15.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, self.frame.size.height-30, SCREEN_WIDTH-100, 20)];
	labelins.text = @"评价+晒单最多可得20积分";
	labelins.font = FONTN(13.0f);
	labelins.numberOfLines = 2;
	labelins.textColor = ColorBlackGray;
	[self addSubview:labelins];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.frame.size.height-0.5, SCREEN_WIDTH-20, 0.5)];
	imageviewline.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:imageviewline];
	
	
	if([fromflag isEqualToString:@"2"])
	{
		UIButton *btevalua = [UIButton buttonWithType:UIButtonTypeCustom];
		[btevalua setTitle:@"评价晒单" forState:UIControlStateNormal];
		btevalua.frame = CGRectMake(SCREEN_WIDTH-90, labelins.frame.origin.y-10, 80, 30);
		btevalua.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btevalua.layer.cornerRadius = 2.0f;
		btevalua.layer.borderWidth = 1.0f;
		[btevalua addTarget:self action:@selector(clickpingjiashaidan:) forControlEvents:UIControlEventTouchUpInside];
		btevalua.titleLabel.font = FONTN(13.0f);
		[btevalua setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[self addSubview:btevalua];
	}
}

-(void)clickpingjiashaidan:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGgotoEvaluationView:)])
	{
		[self.delegate1 DGgotoEvaluationView:dicfrom];
	}
}


@end
