//
//  MeOrderCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//
//我的订单tableviewcell
#import "MeOrderCellView.h"

@implementation MeOrderCellView

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
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-5)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	
	NSString *str= [dicsrc objectForKey:@"displaytitle"];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
	CGSize size = [AddInterface getlablesize:str Fwidth:300 Fheight:25 Sfont:FONTN(14.0f)];
	DLog(@"size====%f,%@",size.width,str);
	UILabel *labelcompany = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, size.width, size.height)];
	labelcompany.text = str;
	labelcompany.font = FONTN(14.0f);
	labelcompany.textColor = ColorBlackdeep;
	[self addSubview:labelcompany];
	
	UIImageView *imageviewarrow = [[UIImageView alloc] initWithFrame:CGRectMake(labelcompany.origin.x+labelcompany.frame.size.width+5, labelcompany.frame.origin.y+4, 7, 12)];
	imageviewarrow.image = LOADIMAGE(@"me_箭头右", @"png");
	[self addSubview:imageviewarrow];
	
	UILabel *labelstatus = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelcompany.frame.origin.y, 90, 20)];
	labelstatus.text = [dicsrc objectForKey:@"orderstatus"];
	labelstatus.font = FONTN(13.0f);
	labelstatus.textAlignment = NSTextAlignmentRight;
	labelstatus.textColor = ColorBlue;
	[self addSubview:labelstatus];
	
	float nowheight = 40;
	NSArray *arraycommdity = [dicsrc objectForKey:@"commoditylist"];
	for(int i=0;i<[arraycommdity count];i++)
	{
		NSDictionary *dictemp = [arraycommdity objectAtIndex:i];
		UIView *viewcell = [self viewcell:CGRectMake(0, 40+100*i, SCREEN_WIDTH, 100) Dic:dictemp];
		[self addSubview:viewcell];
		nowheight= nowheight+viewcell.frame.size.height;
	}
	
	
	UILabel *labelmsg = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-260, nowheight+10, 250, 20)];
	labelmsg.text = [NSString stringWithFormat:@"共%d件商品  合计:%@(含运费:%@)",(int)[arraycommdity count],[dicsrc objectForKey:@"ordertotlefee"],[dicsrc objectForKey:@"deliveryfee"]];
	labelmsg.font = FONTN(13.0f);
	labelmsg.textAlignment = NSTextAlignmentRight;
	labelmsg.textColor = ColorBlackshallow;
	[self addSubview:labelmsg];
	
	nowheight = nowheight+40;
	
	UIImageView *imagelineh = [[UIImageView alloc] initWithFrame:CGRectMake(0, nowheight, SCREEN_WIDTH, 1)];
	imagelineh.backgroundColor = COLORNOW(200, 200, 200);
	[self addSubview:imagelineh];
	
	
	if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"havepanyed"])//待收货
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"提醒发货" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, imagelineh.frame.origin.y+9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickalertsendorder:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[self addSubview:btstatus];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"orderedwithnomoney"]) //待付款
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"去支付" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, imagelineh.frame.origin.y+9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickgotoPay:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[self addSubview:btstatus];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"havefinished"]) //待评价
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"评价晒单" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, imagelineh.frame.origin.y+9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickpingjiashaidan:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[self addSubview:btstatus];
		
		UIButton *btonemore = [UIButton buttonWithType:UIButtonTypeCustom];
		[btonemore setTitle:@"再次购买" forState:UIControlStateNormal];
		btonemore.frame = CGRectMake(SCREEN_WIDTH-200, imagelineh.frame.origin.y+9, 90, 32);
		btonemore.layer.borderColor = ColorBlackdeep.CGColor;
		btonemore.layer.cornerRadius = 2.0f;
		btonemore.layer.borderWidth = 1.0f;
		[btonemore addTarget:self action:@selector(clickonceagain:) forControlEvents:UIControlEventTouchUpInside];
		btonemore.titleLabel.font = FONTN(13.0f);
		[btonemore setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[self addSubview:btonemore];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"haveassigned"]) //待收货
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"查看物流" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, imagelineh.frame.origin.y+9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clicksearchwuliu:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[self addSubview:btstatus];
		
		UIButton *btonemore = [UIButton buttonWithType:UIButtonTypeCustom];
		[btonemore setTitle:@"再次购买" forState:UIControlStateNormal];
		btonemore.frame = CGRectMake(SCREEN_WIDTH-200, imagelineh.frame.origin.y+9, 90, 32);
		btonemore.layer.borderColor = ColorBlackdeep.CGColor;
		btonemore.layer.cornerRadius = 2.0f;
		btonemore.layer.borderWidth = 1.0f;
		[btonemore addTarget:self action:@selector(clickonceagain:) forControlEvents:UIControlEventTouchUpInside];
		btonemore.titleLabel.font = FONTN(13.0f);
		[btonemore setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[self addSubview:btonemore];
	}
}

-(UIView *)viewcell:(CGRect)frame Dic:(NSDictionary *)diccommodity
{
	UIView *viewcell = [[UIView alloc] initWithFrame:CGRectMake(0,frame.origin.y, SCREEN_WIDTH, frame.size.height-2)];
	viewcell.backgroundColor =  [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
	
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
	imageview.image = LOADIMAGE(@"testpic3", @"png");
	[viewcell addSubview:imageview];
	
	NSString *str= [diccommodity objectForKey:@"commodityname"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-120 Fheight:20 Sfont:FONTN(15.0f)];
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+10, imageview.frame.origin.y, size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(15.0f);
	labelname.numberOfLines = 0;
	labelname.textColor = ColorBlackdeep;
	[viewcell addSubview:labelname];

	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+5, 190, 20)];
	labelvalue.text = [NSString stringWithFormat:@"颜色:%@  规格:%@",[diccommodity objectForKey:@"ordercolor"],[diccommodity objectForKey:@"orderspecification"]];
	labelvalue.font = FONTN(13.0f);
	labelvalue.textColor = ColorBlackGray;
	[viewcell addSubview:labelvalue];
	
	UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelvalue.frame.origin.y, 90, 20)];
	labelnumber.text = [NSString stringWithFormat:@"X%@",[diccommodity objectForKey:@"ordernumber"]];
	labelnumber.font = FONTN(13.0f);
	labelnumber.textAlignment = NSTextAlignmentRight;
	labelnumber.textColor = ColorBlackGray;
	[viewcell addSubview:labelnumber];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelvalue.frame.origin.x, labelvalue.frame.origin.y+labelvalue.frame.size.height+5, 100, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[diccommodity objectForKey:@"orderprice"]];
	labelprice.font = FONTN(15.0f);
	labelprice.textColor = ColorBlackdeep;
	[viewcell addSubview:labelprice];
	
	return viewcell;
}


-(void)clickonceagain:(id)sender
{
	
}

-(void)clickgotoPay:(id)sender
{
	
}

-(void)clicksearchwuliu:(id)sender
{
	
}

-(void)clickalertsendorder:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGAlertSendGoods:)])
	{
		[self.delegate1 DGAlertSendGoods:dicdatasrc];
	}
	

}

-(void)clickpingjiashaidan:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGGotoEvaluationListView:)])
	{
		[self.delegate1 DGGotoEvaluationListView:dicdatasrc];
	}
}

@end
