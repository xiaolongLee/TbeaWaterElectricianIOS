//
//  MyOrderDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyOrderDetailViewController.h"

@interface MyOrderDetailViewController ()

@end

@implementation MyOrderDetailViewController
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"订单详情";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	

	[self getmyorderinfo:self.strorderid];
	
}

-(void)addsubfootview:(NSDictionary *)dicsrc
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
	viewfoot.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:viewfoot];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
	imageviewline.backgroundColor = ColorBlackVeryGray;
	[viewfoot addSubview:imageviewline];
	
	if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"havepanyed"])//待收货
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"提醒发货" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, 9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickalertsendorder:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[viewfoot addSubview:btstatus];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"orderedwithnomoney"]) //待付款
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"去支付" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, 9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickgotoPay:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[viewfoot addSubview:btstatus];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"havefinished"]) //待评价
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"评价晒单" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, 9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clickpingjiashaidan:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[viewfoot addSubview:btstatus];
		
		UIButton *btonemore = [UIButton buttonWithType:UIButtonTypeCustom];
		[btonemore setTitle:@"再次购买" forState:UIControlStateNormal];
		btonemore.frame = CGRectMake(SCREEN_WIDTH-200, 9, 90, 32);
		btonemore.layer.borderColor = ColorBlackdeep.CGColor;
		btonemore.layer.cornerRadius = 2.0f;
		btonemore.layer.borderWidth = 1.0f;
		[btonemore addTarget:self action:@selector(clickonceagain:) forControlEvents:UIControlEventTouchUpInside];
		btonemore.titleLabel.font = FONTN(13.0f);
		[btonemore setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[viewfoot addSubview:btonemore];
	}
	else if([[dicsrc objectForKey:@"orderstatusid"] isEqualToString:@"haveassigned"]) //待收货
	{
		UIButton *btstatus = [UIButton buttonWithType:UIButtonTypeCustom];
		[btstatus setTitle:@"查看物流" forState:UIControlStateNormal];
		btstatus.frame = CGRectMake(SCREEN_WIDTH-100, 9, 90, 32);
		btstatus.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
		btstatus.layer.cornerRadius = 2.0f;
		btstatus.layer.borderWidth = 1.0f;
		[btstatus addTarget:self action:@selector(clicksearchwuliu:) forControlEvents:UIControlEventTouchUpInside];
		btstatus.titleLabel.font = FONTN(13.0f);
		[btstatus setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
		[viewfoot addSubview:btstatus];
		
		UIButton *btonemore = [UIButton buttonWithType:UIButtonTypeCustom];
		[btonemore setTitle:@"再次购买" forState:UIControlStateNormal];
		btonemore.frame = CGRectMake(SCREEN_WIDTH-200, 9, 90, 32);
		btonemore.layer.borderColor = ColorBlackdeep.CGColor;
		btonemore.layer.cornerRadius = 2.0f;
		btonemore.layer.borderWidth = 1.0f;
		[btonemore addTarget:self action:@selector(clickonceagain:) forControlEvents:UIControlEventTouchUpInside];
		btonemore.titleLabel.font = FONTN(13.0f);
		[btonemore setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[viewfoot addSubview:btonemore];
	}
}

-(UIView *)viewaddr:(NSDictionary *)sender Frame:(CGRect)frame
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	
	NSString *str = [sender objectForKey:@"contactperson"];
	CGSize size = [AddInterface getlablesize:str Fwidth:150 Fheight:20 Sfont:FONTN(14.0f)];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, size.width, 20)];
	labelname.textColor = ColorBlackdeep;
	labelname.font = FONTN(14.0f);
	labelname.text = str;
	[view addSubview:labelname];

	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+5, 10, 130, 20)];
	labeltel.textColor = ColorBlackdeep;
	labeltel.font = FONTN(14.0f);
	labeltel.text = [sender objectForKey:@"contactmobile"];
	[view addSubview:labeltel];
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(10, labelname.frame.origin.y+labeltel.frame.size.height, SCREEN_WIDTH-20, 20)];
	labeladdr.textColor = ColorBlackdeep;
	labeladdr.font = FONTN(14.0f);
	labeladdr.text = [sender objectForKey:@"address"];
	[view addSubview:labeladdr];
	
	return view;
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

-(UIView *)orderview:(CGRect)frame
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	
	float nowheight = 0;
	NSArray *arraycommdity = [dicdata objectForKey:@"commoditylist"];
	for(int i=0;i<[arraycommdity count];i++)
	{
		NSDictionary *dictemp = [arraycommdity objectAtIndex:i];
		UIView *viewcell = [self viewcell:CGRectMake(0, 100*i, SCREEN_WIDTH, 100) Dic:dictemp];
		[view addSubview:viewcell];
		nowheight= nowheight+viewcell.frame.size.height;
	}
	
	return view;
}


#pragma mark IBaction
-(void)clickcontacttel:(id)sender
{
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[[dicdata objectForKey:@"orderbaseinfo"] objectForKey:@"contacttbea"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
//	[self getAlertsendgoods:[sender objectForKey:@"orderid"]];
}

-(void)clickpingjiashaidan:(id)sender
{
//	EvaluationCommodityListViewController *evaluationlist = [[EvaluationCommodityListViewController alloc] init];
//	evaluationlist.diccommdity = sender;
//	[self.navigationController pushViewController:evaluationlist animated:YES];
}

#pragma mark tableview delegate
-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 0.01f;
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 10.0f;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==0)
	{
		return 40;
	}
	else if(indexPath.section == 1)
	{
		if(indexPath.row == 0)
		{
			return 60;
		}
		else if(indexPath.row == 1)
		{
			NSArray *arraycommdity = [dicdata objectForKey:@"commoditylist"];
			return [arraycommdity count]*100;
		}
		else
			return 60;
	}
	else if(indexPath.section == 2)
	{
		return 40;
	}
	
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section==0)
	{
		return 2;
	}
	else if(section == 1)
	{
		return 3;
	}
	else if(section == 2)
	{
		return 5;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];

	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 10, 165, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.tag = EnUserInfoCellLabelTag;
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	NSDictionary *orderbaseinfo = [dicdata objectForKey:@"orderbaseinfo"];
	NSArray *arraydata = [dicdata objectForKey:@"commoditylist"];
	int arraycount;
	UIButton *buttontel;
	switch (indexPath.section)
	{
		case 0:
			switch (indexPath.row)
			{
				case 0:
					labeltitle.text = @"订单编号";
					labelvalue.text = [orderbaseinfo objectForKey:@"ordercode"];
					[cell.contentView addSubview:labelvalue];
					break;
				case 1:
					labeltitle.text = @"下单时间";
					labelvalue.text = [orderbaseinfo objectForKey:@"ordertime"];
					[cell.contentView addSubview:labelvalue];
					break;
			}
			break;
		case 1:
			switch (indexPath.row)
			{
				case 0:
					[cell.contentView addSubview:[self viewaddr:[dicdata objectForKey:@"receiveaddrinfo"] Frame:CGRectMake(0, 0, SCREEN_WIDTH, 59)]];
					break;
				case 1:
					arraycount = (int)[arraydata count];
					[cell.contentView addSubview:[self orderview:CGRectMake(0, 0, SCREEN_WIDTH, arraycount*100)]];

					break;
				case 2:
					buttontel = [UIButton buttonWithType:UIButtonTypeCustom];
					buttontel.frame = CGRectMake(15, 12, SCREEN_WIDTH-30, 36);
					[buttontel setTitle:@"联系特变" forState:UIControlStateNormal];
					buttontel.titleLabel.font = FONTB(15.0f);
					[buttontel setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
					buttontel.layer.cornerRadius = 2.0f;
					buttontel.clipsToBounds = YES;
					[buttontel addTarget:self action:@selector(clickcontacttel:) forControlEvents:UIControlEventTouchUpInside];
					buttontel.layer.borderColor = ColorBlackdeep.CGColor;
					buttontel.layer.borderWidth = 0.6f;
					[cell.contentView addSubview:buttontel];
					break;
			}
			break;
		case 2:
			switch (indexPath.row)
			{
				case 0:
					labeltitle.text = @"支付方式";
					labelvalue.text = [orderbaseinfo objectForKey:@"paytypename"];
					[cell.contentView addSubview:labelvalue];
					break;
				case 1:
					labeltitle.text = @"配送方式";
					labelvalue.text = [orderbaseinfo objectForKey:@"deliverytypename"];
					[cell.contentView addSubview:labelvalue];
					break;
				case 2:
					labeltitle.text = @"商品总额度";
					labelvalue.text = [NSString stringWithFormat:@"￥%@",[orderbaseinfo objectForKey:@"totlemoney"]];
					[cell.contentView addSubview:labelvalue];
					break;
				case 3:
					labeltitle.text = @"运费";
					labelvalue.text = [NSString stringWithFormat:@"￥%@",[orderbaseinfo objectForKey:@"deliveryfee"]];
					[cell.contentView addSubview:labelvalue];
					break;
				case 4:
					labelvalue.text = [NSString stringWithFormat:@"实付款:￥%@",[orderbaseinfo objectForKey:@"actualneedpaymoney"]];
					[cell.contentView addSubview:labelvalue];
					break;
			}
			break;

	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



#pragma mark 接口
-(void)getmyorderinfo:(NSString *)orderid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:orderid forKey:@"userorderid"];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001019000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicdata = [dic objectForKey:@"data"];
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
			 [self addsubfootview:[dicdata objectForKey:@"orderbaseinfo"]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}

-(void)getAlertsendgoods:(NSString *)orderid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:orderid forKey:@"userorderid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001098000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
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
