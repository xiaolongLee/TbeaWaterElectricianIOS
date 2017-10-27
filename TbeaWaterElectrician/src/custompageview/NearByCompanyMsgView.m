//
//  NearByCompanyMsgView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByCompanyMsgView.h"

@implementation NearByCompanyMsgView

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
	
	UIImageView *imaegviewclock = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
	imaegviewclock.image = LOADIMAGE(@"nearby_colockblue", @"png");
	[self addSubview:imaegviewclock];
	
	
	UIImageView *imaegviewcline = [[UIImageView alloc] initWithFrame:CGRectMake(imaegviewclock.frame.origin.x, imaegviewclock.frame.origin.y+imaegviewclock.frame.size.height+5, SCREEN_WIDTH-20, 0.5)];
	imaegviewcline.backgroundColor = ColorBlackVeryGray;
	[self addSubview:imaegviewcline];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imaegviewclock.frame.origin.x+imaegviewclock.frame.size.width+3, imaegviewclock.frame.origin.y-3, 90, 20)];
	labeltime.text = @"昨天";
	labeltime.font = FONTN(13.0f);
	labeltime.textColor = ColorBlackGray;
	[self addSubview:labeltime];

	float nowheight = 35;
	NSString *str = [dic objectForKey:@"content"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-labeltime.frame.origin.x-10 Fheight:100 Sfont:FONTN(13.0f)];
	UILabel *labelmsg = [[UILabel alloc] initWithFrame:CGRectMake(imaegviewclock.frame.origin.x+imaegviewclock.frame.size.width+3, imaegviewcline.frame.origin.y+5,size.width, size.height)];
	labelmsg.text = str;
	labelmsg.font = FONTN(13.0f);
	labelmsg.numberOfLines = 0;
	labelmsg.textColor = ColorBlackdeep;
	[self addSubview:labelmsg];
	
	
	
	nowheight = nowheight+size.height+20;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,nowheight);
}

@end
