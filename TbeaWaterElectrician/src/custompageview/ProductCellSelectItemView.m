//
//  ProductCellSelectItemView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ProductCellSelectItemView.h"

@implementation ProductCellSelectItemView

-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic TagNow:(int)tagnow
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicfrom = dic;
		[self initview:tagnow];
	}
	return self;
}

-(void)initview:(int)tagnow
{
	UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitem.titleLabel.font = FONTN(14.0f);
	buttonitem.layer.cornerRadius = 3.0f;
	buttonitem.clipsToBounds = YES;
	buttonitem.tag = EnCollectionSelectItemBtTag;
	[buttonitem setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
	[buttonitem addTarget:self action:@selector(clickitem:) forControlEvents:UIControlEventTouchUpInside];
	buttonitem.frame = CGRectMake(10, (self.frame.size.height-40)/2, 40,40 );
	[buttonitem setBackgroundColor:[UIColor clearColor]];
	[self addSubview:buttonitem];

	
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(buttonitem.frame.origin.x+buttonitem.frame.size.width+10, 15, 80, 80)];
	NSURL *urlstr = [NSURL URLWithString:[dicfrom objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	NSString *str = [dicfrom objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-160 Fheight:38 Sfont:FONTN(14.0f)];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y,size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(14.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, SCREEN_WIDTH-160, 33)];
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

-(void)clickitem:(id)sender
{
	UIButton *button = (UIButton *)sender;
//	int tagnow = (int)[button tag]-EnCollectionSelectItemBtTag;
	if([self.delegate1 respondsToSelector:@selector(DGSelectCollectionItem:SBt:)])
	{
		[self.delegate1 DGSelectCollectionItem:dicfrom SBt:button];
	}
}

@end
