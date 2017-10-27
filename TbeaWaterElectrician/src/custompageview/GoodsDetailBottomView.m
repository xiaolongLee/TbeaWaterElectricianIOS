//
//  GoodsDetailBottomView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//
//商品详细底部购买导航
#import "GoodsDetailBottomView.h"

@implementation GoodsDetailBottomView


-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self)
	{
		[self initview];
	}
	return self;
}

-(void)addgouwuchenumber:(NSString *)number
{
	UIImageView *imageviewpoint = [[UIImageView alloc] initWithFrame:CGRectMake(50*2+25, 3, 16, 16)];
	imageviewpoint.layer.cornerRadius = 8.0f;
	imageviewpoint.clipsToBounds = YES;
	imageviewpoint.layer.borderColor = [UIColor whiteColor].CGColor;
	imageviewpoint.layer.borderWidth = 1.0f;
	imageviewpoint.backgroundColor = Colorredcolor;
	[self addSubview:imageviewpoint];

	UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(imageviewpoint.frame.origin.x, imageviewpoint.frame.origin.y, 16, 16)];
	labelnum.textColor = [UIColor whiteColor];
	labelnum.textAlignment = NSTextAlignmentCenter;
	labelnum.backgroundColor = [UIColor clearColor];
	labelnum.font = FONTN(10.0f);
	labelnum.text = number;
	[self addSubview:labelnum];
}

-(void)setproductcollection:(NSString *)iscollection
{
	UIButton *button = (UIButton *)[self viewWithTag:EnGetGoodsThreeBtTag2];
	if([iscollection isEqualToString:@"0"])
	{
		[button setImage:LOADIMAGE(@"收藏", @"png") forState:UIControlStateNormal];
	}
	else
	{
		[button setImage:LOADIMAGE(@"已收藏", @"png") forState:UIControlStateNormal];
	}
	
}
	
-(void)initview
{
	self.backgroundColor = [UIColor whiteColor];
	
	for(int i=0;i<3;i++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(50*i,0,50,50);
		button.titleLabel.font = FONTN(13.0f);
		[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		switch (i) {
			case 0:
				[button setTitle:@"店铺" forState:UIControlStateNormal];
				button.tag = EnGetGoodsThreeBtTag1;
				[button setImage:LOADIMAGE(@"店铺", @"png") forState:UIControlStateNormal];
				break;
			case 1:
				[button setTitle:@"收藏" forState:UIControlStateNormal];
				button.tag = EnGetGoodsThreeBtTag2;
				[button setImage:LOADIMAGE(@"收藏", @"png") forState:UIControlStateNormal];
				break;
			case 2:
				[button setTitle:@"购物车" forState:UIControlStateNormal];
				button.tag = EnGetGoodsThreeBtTag3;
				[button setImage:LOADIMAGE(@"购物车", @"png") forState:UIControlStateNormal];
				break;
		}
		[button addTarget:self action:@selector(clicknext:) forControlEvents:UIControlEventTouchUpInside];
		[button setImageEdgeInsets:UIEdgeInsetsMake(-10, 15, 0, 0)];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(25, -15, 0, 0)];
		UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(50*(i+1), 0, 1, 50)];
		line.backgroundColor = ColorBlackVeryshallow;
		[self addSubview:line];
		
		[self addSubview:button];
		
	}
	
	float nowwidth = (SCREEN_WIDTH-150)/2;
	UIButton *buttonche = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonche.frame = CGRectMake(150,0,nowwidth,50);
	buttonche.titleLabel.font = FONTN(14.0f);
	buttonche.backgroundColor = COLORNOW(254, 170, 38);
	[buttonche setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonche setTitle:@"加入购物车" forState:UIControlStateNormal];
	[buttonche addTarget:self action:@selector(clickaddgwc:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonche];
	
	UIButton *buttonnow = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonnow.frame = CGRectMake(buttonche.frame.origin.x+buttonche.frame.size.width,0,nowwidth,50);
	buttonnow.titleLabel.font = FONTN(14.0f);
	buttonnow.backgroundColor = Colorredcolor;
	[buttonnow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonnow setTitle:@"立即购买" forState:UIControlStateNormal];
	[buttonnow addTarget:self action:@selector(clickbuynow:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonnow];
}

-(void)clicknext:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag];
	if([self.delegate1 respondsToSelector:@selector(DGClickGoodsNextBt:)])
	{
		[self.delegate1 DGClickGoodsNextBt:tagnow];
	}
}

-(void)clickaddgwc:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DeClictAddGWC:)])
	{
		[self.delegate1 DeClictAddGWC:@"1"]; //1表示购物进
	}
	
	
}

-(void)clickbuynow:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DeClictAddGWC:)])
	{
		[self.delegate1 DeClictAddGWC:@"2"]; //2表示直接购买
	}
}
@end
