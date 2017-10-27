//
//  JXSPageViewCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByJXSPageViewCellView.h"

@implementation NearByJXSPageViewCellView

-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic FomeFlag:(NSString *)fromflag
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicfrom = dic;
		[self initview:fromflag];
	}
	return self;
}


-(void)initview:(NSString *)fromflag
{
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 80, 80)];
	NSURL *urlstr = [NSURL URLWithString:[dicfrom objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	NSString *str= [dicfrom objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-110 Fheight:20 Sfont:FONTN(15.0f)];
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y, size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(15.0f);
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	

	

	
	//加V认证
	if([[dicfrom objectForKey:@"withcompanyidentified"] intValue]==1)
	{
		UIImageView *imageviewgV = [[UIImageView alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+3, labelname.frame.origin.y+3, 14, 14)];
		imageviewgV.image = LOADIMAGE(@"nearby_认证", @"png");
		[self addSubview:imageviewgV];
	}
	float noworiginx = labelname.frame.origin.x;
	//工商认证
	float noworiginy = labelname.frame.origin.y+labelname.frame.size.height+8;
	if([[dicfrom objectForKey:@"withcompanylisence"] intValue]==1)
	{
		UIImageView *imageviewGS = [[UIImageView alloc] initWithFrame:CGRectMake(noworiginx, noworiginy, 15, 17)];
		imageviewGS.image = LOADIMAGE(@"nearby_工商", @"png");
		[self addSubview:imageviewGS];
		noworiginx = noworiginx+imageviewGS.frame.size.width+10;
	}
	//消保认证
	if([[dicfrom objectForKey:@"withguaranteemoney"] intValue]==1)
	{
		UIImageView *imageviewXB = [[UIImageView alloc] initWithFrame:CGRectMake(noworiginx, noworiginy, 15, 17)];
		imageviewXB.image = LOADIMAGE(@"nearby_消保", @"png");
		[self addSubview:imageviewXB];
			
		noworiginx = noworiginx+imageviewXB.frame.size.width+10;
	}
	//个人认证
	if([[dicfrom objectForKey:@"withidentified"] intValue]==1)
	{
		UIImageView *imageviewGR = [[UIImageView alloc] initWithFrame:CGRectMake(noworiginx, noworiginy, 22, 16)];
		imageviewGR.image = LOADIMAGE(@"nearby_个人认证", @"png");
		[self addSubview:imageviewGR];
	}
	
	UILabel *labeldistance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95, noworiginy-2, 90, 20)];
	labeldistance.text = [NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"distance"]];
	labeldistance.font = FONTN(13.0f);
	labeldistance.textAlignment = NSTextAlignmentRight;
	labeldistance.textColor = Colorqingsecolor;
	[self addSubview:labeldistance];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+24, SCREEN_WIDTH-100, 40)];
	labelins.text = [dicfrom objectForKey:@"address"];
	labelins.font = FONTN(13.0f);
	labelins.numberOfLines = 2;
	labelins.textColor = ColorBlackGray;
	[self addSubview:labelins];
	
	if([fromflag isEqualToString:@"1"])
	{
		UIButton *buttonaddr = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonaddr.frame = labelins.frame;
		[buttonaddr addTarget:self action:@selector(clickaddr:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:buttonaddr];
	}
}

-(void)clickaddr:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGClickJXSAddrGotoMap:)])
	{
		[self.delegate1 DGClickJXSAddrGotoMap:sender];
	}
}

@end
