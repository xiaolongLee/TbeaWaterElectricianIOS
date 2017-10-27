//
//  ScanRebateViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanRebateViewController.h"

@interface ScanRebateViewController ()

@end

@implementation ScanRebateViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self.navigationController setNavigationBarHidden:YES];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSFileManager *filemanger= [NSFileManager defaultManager];
	if([filemanger fileExistsAtPath:ScanCodeList])
	{
		arrayrebatelist = [[NSMutableArray alloc] initWithContentsOfFile:ScanCodeList];
	}
	else
	{
		arrayrebatelist = [[NSMutableArray alloc] init];
	}
	
	if(self.fromflag == 1)
	{
		NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality,app.dili.diliroad,app.dili.dilinumber];
		[self getproductrebate:self.scancode Address:address];
	}
	else
	{
		
	}
	
	[self initbaseview];
	
	// Do any additional setup after loading the view.
}

-(void)initbaseview
{
	self.view.backgroundColor = [UIColor whiteColor];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	
	//扫码记录
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
	labeltitle.text = @"返利详情";
	labeltitle.font = FONTN(17.0f);
	labeltitle.textAlignment = NSTextAlignmentCenter;
	labeltitle.textColor = [UIColor whiteColor];
	[self.view addSubview:labeltitle];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
}

-(void)initview:(NSDictionary *)dic
{
	//头部产品介绍
	NSDictionary *diccommodity = [dic objectForKey:@"commodityinfo"];
	ScanProductCellView *scanproduct = [[ScanProductCellView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 90) Dic:diccommodity];
	[self.view addSubview:scanproduct];
	
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, scanproduct.frame.origin.y+scanproduct.frame.size.height, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = Colorgray;
	[self.view addSubview:imageline];
	
	UIView *viewrebate =  [self RebateInfo:dic Frame:CGRectMake(0, imageline.frame.origin.y+1, SCREEN_WIDTH, 800)];
	[self.view addSubview:viewrebate];
}


-(UIView *)RebateInfo:(NSDictionary *)dic Frame:(CGRect)frame
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
//	view.backgroundColor = ColorBlue2;
	NSDictionary *dicappealinfo = [dic objectForKey:@"appealinfo"];
//	NSDictionary *dicommodityinfo = [dic objectForKey:@"commodityinfo"];
	NSDictionary *dicscaninfo = [dic objectForKey:@"scaninfo"];
	NSDictionary *dicuserinfo = [dic objectForKey:@"userinfo"];
	//扫码时间
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 65, 20)];
	labeltime.text = @"扫码时间:";
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = ColorBlackshallow;
	[view addSubview:labeltime];
	
	UILabel *labeltimevalue = [[UILabel alloc] initWithFrame:CGRectMake(labeltime.frame.origin.x+labeltime.frame.size.width+3, labeltime.frame.origin.y-2, 150, 25)];
	labeltimevalue.text = [dicscaninfo objectForKey:@"manufacturedate"];
	labeltimevalue.font = FONTN(14.0f);
	labeltimevalue.textColor = ColorBlackdeep;
	[view addSubview:labeltimevalue];
	
	//扫码地点
	UILabel *labeladdress = [[UILabel alloc] initWithFrame:CGRectMake(labeltime.frame.origin.x, labeltime.frame.origin.y+labeltime.frame.size.height+3, labeltime.frame.size.width, 20)];
	labeladdress.text = @"扫码地点:";
	labeladdress.font = FONTN(14.0f);
	labeladdress.textColor = ColorBlackshallow;
	[view addSubview:labeladdress];
	
	UILabel *labeladdressvalue = [[UILabel alloc] initWithFrame:CGRectMake(labeladdress.frame.origin.x+labeladdress.frame.size.width+3, labeladdress.frame.origin.y, SCREEN_WIDTH-80, 20)];
	labeladdressvalue.text = [dicscaninfo objectForKey:@"scanaddress"];
	labeladdressvalue.font = FONTN(14.0f);
	labeladdressvalue.textColor = ColorBlackdeep;
	[view addSubview:labeladdressvalue];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, labeladdressvalue.frame.origin.y+labeladdressvalue.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = Colorgray;
	[view addSubview:imageline];
	
	//商品所属经销商
	UILabel *labeljxs = [[UILabel alloc] initWithFrame:CGRectMake(labeladdress.frame.origin.x, imageline.frame.origin.y+imageline.frame.size.height+10, 105, 20)];
	labeljxs.text = @"商品所属经销商:";
	labeljxs.font = FONTN(14.0f);
	labeljxs.textColor = ColorBlackshallow;
	[view addSubview:labeljxs];
	
	UILabel *labeljxsvalue = [[UILabel alloc] initWithFrame:CGRectMake(labeljxs.frame.origin.x+labeljxs.frame.size.width+3, labeljxs.frame.origin.y, SCREEN_WIDTH-110, 20)];
	labeljxsvalue.text = [dicscaninfo objectForKey:@"distributor"];
	labeljxsvalue.font = FONTN(14.0f);
	if([[dicappealinfo objectForKey:@"needappeal"] intValue]==1)
		labeljxsvalue.textColor = Colorredcolor;
	else
		labeljxsvalue.textColor = ColorBlackdeep;
	[view addSubview:labeljxsvalue];
	
	//产品名称
	UILabel *labelproduct = [[UILabel alloc] initWithFrame:CGRectMake(labeladdress.frame.origin.x, labeljxs.frame.origin.y+labeljxs.frame.size.height+3, labeladdress.frame.size.width, 20)];
	labelproduct.text = @"产品名称:";
	labelproduct.font = FONTN(14.0f);
	labelproduct.textColor = ColorBlackshallow;
	[view addSubview:labelproduct];
	
	UILabel *labelproductname = [[UILabel alloc] initWithFrame:CGRectMake(labelproduct.frame.origin.x+labelproduct.frame.size.width+3, labelproduct.frame.origin.y, SCREEN_WIDTH-110, 20)];
	labelproductname.text = [NSString stringWithFormat:@"%@",[dicscaninfo objectForKey:@"commodityname"]];
	labelproductname.font = FONTN(14.0f);
	labelproductname.textColor = ColorBlackdeep;
	[view addSubview:labelproductname];
	
	//产品型号
	UILabel *labeltype = [[UILabel alloc] initWithFrame:CGRectMake(labeladdress.frame.origin.x, labelproductname.frame.origin.y+labelproductname.frame.size.height+3, labeladdress.frame.size.width, 20)];
	labeltype.text = @"产品型号:";
	labeltype.font = FONTN(14.0f);
	labeltype.textColor = ColorBlackshallow;
	[view addSubview:labeltype];
	
	UILabel *labelproducttype = [[UILabel alloc] initWithFrame:CGRectMake(labeltype.frame.origin.x+labeltype.frame.size.width+3, labeltype.frame.origin.y, SCREEN_WIDTH-110, 20)];
	labelproducttype.text = [NSString stringWithFormat:@"%@",[dicscaninfo objectForKey:@"commodityspec"]];
	labelproducttype.font = FONTN(14.0f);
	labelproducttype.textColor = ColorBlackdeep;
	[view addSubview:labelproducttype];
	
	//生产日期
	UILabel *labeldate = [[UILabel alloc] initWithFrame:CGRectMake(labeladdress.frame.origin.x, labelproducttype.frame.origin.y+labelproducttype.frame.size.height+3, labeladdress.frame.size.width, 20)];
	labeldate.text = @"生产日期:";
	labeldate.font = FONTN(14.0f);
	labeldate.textColor = ColorBlackshallow;
	[view addSubview:labeldate];
	
	UILabel *labelproductdate = [[UILabel alloc] initWithFrame:CGRectMake(labeldate.frame.origin.x+labeldate.frame.size.width+3, labeldate.frame.origin.y, SCREEN_WIDTH-110, 20)];
	labelproductdate.text = [NSString stringWithFormat:@"%@",[dicscaninfo objectForKey:@"manufacturedate"]];
	labelproductdate.font = FONTN(14.0f);
	labelproductdate.textColor = ColorBlackdeep;
	[view addSubview:labelproductdate];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelproductdate.frame.origin.y+labelproductdate.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline1.backgroundColor = Colorgray;
	[view addSubview:imageline1];
	
	
	//本次返利
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labeldate.frame.origin.x, imageline1.frame.origin.y+10, 65, 20)];
	labelprice.text = @"本次返利:";
	labelprice.font = FONTN(14.0f);
	labelprice.textColor = ColorBlue;
	[view addSubview:labelprice];
	
	UILabel *labelpricevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x+labelprice.frame.size.width+3, labelprice.frame.origin.y-2, 150, 25)];
	labelpricevalue.text = [NSString stringWithFormat:@"￥%@",[dicscaninfo objectForKey:@"rebatemoney"]];
	labelpricevalue.font = FONTN(20.0f);
	labelpricevalue.textColor = Colorredcolor;
	[view addSubview:labelpricevalue];
	
	UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelpricevalue.frame.origin.y+labelpricevalue.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline2.backgroundColor = Colorgray;
	[view addSubview:imageline2];
	
	UIButton *btdone = [UIButton buttonWithType:UIButtonTypeCustom];
	if(([[dicappealinfo objectForKey:@"needappeal"] intValue]==1)||([[dicappealinfo objectForKey:@"needappeal"] intValue]==2))
	{
		btdone.enabled = NO;
		btdone.backgroundColor = COLORNOW(220, 220, 220);
	}
	else
		btdone.backgroundColor = COLORNOW(27, 130, 210);
	btdone.frame = CGRectMake(10, imageline2.frame.origin.y+imageline2.frame.size.height+10,SCREEN_WIDTH-20, 35);
	[btdone setTitle:@"确认" forState:UIControlStateNormal];
	[btdone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btdone.titleLabel.font = FONTN(15.0f);
	[btdone addTarget:self action:@selector(clickbtdone:) forControlEvents:UIControlEventTouchUpInside];
	btdone.layer.cornerRadius= 2.0f;
	btdone.clipsToBounds = YES;
	[view addSubview:btdone];
	
	UIButton *btreport = [UIButton buttonWithType:UIButtonTypeCustom];
	if(([[dicappealinfo objectForKey:@"needappeal"] intValue]==1)||([[dicappealinfo objectForKey:@"needappeal"] intValue]==2))
	{
		btreport.backgroundColor = Colorredcolor;
	}
	else
	{
		btreport.enabled = NO;
		btreport.backgroundColor = COLORNOW(200, 200, 200);
	}
	btreport.frame = CGRectMake(10, btdone.frame.origin.y+btdone.frame.size.height+10,SCREEN_WIDTH-20, 35);
	[btreport setTitle:@"我要举报" forState:UIControlStateNormal];
	[btreport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btreport.titleLabel.font = FONTN(15.0f);
	[btreport addTarget:self action:@selector(clickreport:) forControlEvents:UIControlEventTouchUpInside];
	btreport.layer.cornerRadius= 2.0f;
	btreport.clipsToBounds = YES;
	[view addSubview:btreport];
	
	//你的上线经销商
	float spacespan = 6;
	if(iphone6)
		spacespan = 15;
	else if(iphone6p)
		spacespan = 25;
	if(([[dicappealinfo objectForKey:@"needappeal"] intValue]==1)||([[dicappealinfo objectForKey:@"needappeal"] intValue]==2))
	{
		UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(20, btreport.frame.origin.y+btreport.frame.size.height+spacespan, SCREEN_WIDTH-40, 20)];
		labelins.text = @"你的上级经销商";
		labelins.font = FONTN(14.0f);
		labelins.textColor = ColorBlackdeep;
		labelins.textAlignment = NSTextAlignmentCenter;
		[view addSubview:labelins];
		
		UILabel *labelpricevalue = [[UILabel alloc] initWithFrame:CGRectMake(10, labelins.frame.origin.y+labelins.frame.size.height, SCREEN_WIDTH-20, 20)];
		labelpricevalue.text = [dicuserinfo objectForKey:@"userdistributor"];
		labelpricevalue.font = FONTN(14.0f);
		labelpricevalue.textColor = Colorredcolor;
		labelpricevalue.textAlignment = NSTextAlignmentCenter;
		[view addSubview:labelpricevalue];
	}
	
	spacespan = 3;
	if(iphone6)
		spacespan = 6;
	else if(iphone6p)
		spacespan = 9;
	
	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-64-40-90-3, SCREEN_WIDTH-40, 20)];
	labeltel.text = [NSString stringWithFormat:@"窜货有奖举报电话:%@",[dicappealinfo objectForKey:@"mobilenumber"]];
	labeltel.font = FONTN(14.0f);
	labeltel.textColor = ColorBlackshallow;
	labeltel.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labeltel];
	
	UIButton *bttel = [UIButton buttonWithType:UIButtonTypeCustom];
	bttel.frame = CGRectMake(labeltel.frame.origin.x, labeltel.frame.origin.y-5, labeltel.frame.size.width, labeltel.frame.size.height+10);
	[bttel addTarget:self action:@selector(clickbttel:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:bttel];
	
	UILabel *labeltelins = [[UILabel alloc] initWithFrame:CGRectMake(5, labeltel.frame.origin.y+labeltel.frame.size.height-3, SCREEN_WIDTH-10, 20)];
	labeltelins.text = [dicappealinfo objectForKey:@"appealreward"];
	labeltelins.font = FONTN(14.0f);
	labeltelins.textColor = ColorBlackshallow;
	labeltelins.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labeltelins];
	
	return view;
}

#pragma mark IBAction
-(void)clickbttel:(id)sender
{
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[[dicdata objectForKey:@"appealinfo"] objectForKey:@"mobilenumber"]];
	UIWebView * callWebview = [[UIWebView alloc] init];
	[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
	[self.view addSubview:callWebview];
}

-(void)clickbtdone:(id)sender
{
	[self clickdoneRebate:self.scancode];
}

-(void)clickreport:(id)sender
{
	NSDictionary *dicappealinfo = [dicdata objectForKey:@"appealinfo"];
	if([[dicappealinfo objectForKey:@"needappeal"] intValue]==2)
	{
		[MBProgressHUD showError:@"您已经举报过了" toView:app.window];
	}
	else
	{
		ScanReportCodeViewController *report = [[ScanReportCodeViewController alloc] init];
		report.strcommdityname = [[dicdata objectForKey:@"commodityinfo"] objectForKey:@"name"];
		report.strcommdityid = [[dicdata objectForKey:@"commodityinfo"] objectForKey:@"id"];
		report.strscancode = self.scancode;
		[self.navigationController pushViewController:report animated:YES];
	}
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 接口
-(void)getproductrebate:(NSString *)scancode Address:(NSString *)address
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scancode forKey:@"scancode"];
	[params setObject:address forKey:@"address"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG006001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicdata = [dic objectForKey:@"data"];
			 int flag = 0;
			 for(int i=0;i<[arrayrebatelist count];i++)
			 {
				 NSDictionary *dictemp = [arrayrebatelist objectAtIndex:i];
				 NSString *sid = [[dictemp objectForKey:@"commodityinfo"] objectForKey:@"id"];
				 if([[[dictemp objectForKey:@"commodityinfo"] objectForKey:@"id"] isEqualToString:sid])
				 {
					 flag = 1;
				 }
			 }
			 if(flag == 0)
			 {
				 [arrayrebatelist addObject:dicdata];
			 }
			 
			 [arrayrebatelist writeToFile:ScanCodeList atomically:NO];
			 [self initview:dicdata];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}


-(void)clickdoneRebate:(NSString *)scancode
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scancode forKey:@"scancode"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG006001002001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 InComeDetailViewController *income = [[InComeDetailViewController alloc] init];
			 income.fromflag = @"2";
			 [self.navigationController pushViewController:income animated:YES];
			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
