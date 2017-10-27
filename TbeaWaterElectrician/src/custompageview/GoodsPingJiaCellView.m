//
//  GoodsPingJiaCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "GoodsPingJiaCellView.h"

@implementation GoodsPingJiaCellView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicdatasrc = dicfrom;
		[self initview:dicdatasrc];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

-(void)initview:(NSDictionary *)dicsrc
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
	NSURL *urlstr = [NSURL URLWithString:[URLPicHeader stringByAppendingString:@"123"]];
	[imageviewheader setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	imageviewheader.layer.cornerRadius = 15.f;
	imageviewheader.clipsToBounds = YES;
	[self addSubview:imageviewheader];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+5, imageviewheader.frame.origin.y+5, 250, 20)];
	labelname.text = [dicsrc objectForKey:@"username"];
	labelname.font = FONTN(15.0f);
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
//	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+5, labelname.frame.origin.y, 100, 20)];
//	labeltel.text = [dicsrc objectForKey:@"usermobile"];
//	labeltel.font = FONTN(15.0f);
//	labeltel.textColor = ColorBlackdeep;
//	[self addSubview:labeltel];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelname.frame.origin.y, 95, 20)];
	labeltime.text = [dicsrc objectForKey:@"appraisetime"];
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = ColorBlackGray;
	labeltime.textAlignment = NSTextAlignmentRight;
	[self addSubview:labeltime];
	
	UIImageView *imageviewstar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
	
//	int star = [[dicsrc objectForKey:@"appraiselevel"] intValue];
	
	imageviewstar.image = LOADIMAGE(@"starrate", @"png") ;
	[self addSubview:imageviewstar];
	
	NSString *str = [dicsrc objectForKey:@"appraise"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-20 Fheight:300 Sfont:FONTN(14.0f)];
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(10, imageviewheader.frame.origin.y+imageviewheader.frame.size.height +10, size.width, size.height)];
	labelins.text = [dicsrc objectForKey:@"appraise"];
	labelins.font = FONTN(14.0f);
	labelins.textColor = ColorBlackdeep;
	labelins.numberOfLines = 0;
	[self addSubview:labelins];
	
}

@end
