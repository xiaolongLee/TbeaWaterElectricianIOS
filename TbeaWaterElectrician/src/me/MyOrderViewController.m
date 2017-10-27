//
//  MyOrderViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
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
	self.title = @"我的订单";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:tableview];
	
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
	
	
	[self getmyorderstatus];
	orderstatusid = @"-10000";
	[self getmyorderlist:@"-10000" Page:@"1" Pagesize:@"10"];

}

-(void)initheader:(NSArray *)status
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	
	UIView *viewitem = [self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 40) Status:status];
	[viewheader addSubview:viewitem];
	
	tableview.tableHeaderView = viewheader;
}

-(UIView *)viewselectitem:(CGRect)frame Status:(NSArray *)status
{
	UIView *viewitem = [[UIView alloc] initWithFrame:frame];
	
	float nowwidth = SCREEN_WIDTH/5;
	for(int i=0;i<[status count];i++)
	{
		NSDictionary *dictemp = [status objectAtIndex:i];
		UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonitem.titleLabel.font = FONTN(14.0f);
		buttonitem.tag = EnMyOrderStatusBt+i;
		switch (i) {
			case 0:
				[buttonitem setTitleColor:ColorBlue forState:UIControlStateNormal];
				[buttonitem setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
				orderstatusid = [dictemp objectForKey:@"id"];
				break;
			case 1:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
				break;
			case 2:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
				break;
			case 3:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
				break;
			case 4:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
				break;
		}
		
		[buttonitem addTarget:self action:@selector(clickmyorderitem:) forControlEvents:UIControlEventTouchUpInside];
		buttonitem.frame = CGRectMake(nowwidth*i, 0, nowwidth, viewitem.frame.size.height);
		[viewitem addSubview:buttonitem];
		
		if(i==0)
		{
			UIImageView *imagelineH = [[UIImageView alloc] initWithFrame:CGRectMake(buttonitem.frame.origin.x, buttonitem.frame.size.height-3, buttonitem.frame.size.width, 2)];
			imagelineH.tag = EnMyOrderStatusLineBt;
			imagelineH.backgroundColor = ColorBlue;
			[viewitem addSubview:imagelineH];
		}
	}
	UIImageView *imagelineHgray = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewitem.frame.size.height-1, SCREEN_WIDTH, 1)];
	imagelineHgray.tag = EnMyOrderStatusLineBt;
	imagelineHgray.backgroundColor = COLORNOW(240, 240, 240);
	[viewitem addSubview:imagelineHgray];
	
	
	return viewitem;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	int arraycount = (int)[(NSArray *)[dictemp objectForKey:@"commoditylist"] count];
	return 130+arraycount*100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arraydata count];
	
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
	
	cell.backgroundColor = [UIColor clearColor];
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	int arraycount = (int)[(NSArray *)[dictemp objectForKey:@"commoditylist"] count];
	MeOrderCellView *viewcell = [[MeOrderCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130+arraycount*100) DicFrom:dictemp];
	viewcell.delegate1 = self;
	[cell.contentView addSubview:viewcell];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
	MyOrderDetailViewController *orderinfo = [[MyOrderDetailViewController alloc] init];
	orderinfo.strorderid = [dictemp objectForKey:@"orderid"];
	[self.navigationController pushViewController:orderinfo animated:YES];
}

#pragma mark ActionDelegate
-(void)DGGotoEvaluationListView:(NSDictionary *)sender
{
	EvaluationCommodityListViewController *evaluationlist = [[EvaluationCommodityListViewController alloc] init];
	evaluationlist.diccommdity = sender;
	[self.navigationController pushViewController:evaluationlist animated:YES];
}

-(void)DGAlertSendGoods:(NSDictionary *)sender
{
	[self getAlertsendgoods:[sender objectForKey:@"orderid"]];
}

#pragma mark IBAction
-(void)loadNewData:(id)sender
{
	[self getmyorderlist:orderstatusid Page:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self getmyorderlist:orderstatusid Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)clickmyorderitem:(id)sender
{
	for(int i=0;i<[arrayorderstatus count];i++)
	{
		UIButton *button = (UIButton *)[tableview.tableHeaderView viewWithTag:EnMyOrderStatusBt+i];
		[button setTitleColor:ColorBlackGray forState:UIControlStateNormal];
	}
	
	UIButton *button = (UIButton *)sender;
	[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	int tagnow = (int)[button tag]-EnMyOrderStatusBt;
	NSDictionary *dictemp = [arrayorderstatus objectAtIndex:tagnow];
	orderstatusid = [dictemp objectForKey:@"id"];
	[self getmyorderlist:orderstatusid Page:@"1" Pagesize:@"10"];

	
	UIImageView *imageline = [tableview.tableHeaderView viewWithTag:EnMyOrderStatusLineBt];
	imageline.frame = CGRectMake(button.frame.origin.x, imageline.frame.origin.y,imageline.frame.size.width, imageline.frame.size.height);
}

#pragma mark 接口
-(void)getmyorderlist:(NSString *)statusid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:statusid forKey:@"orderstatusid"];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001017000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"userorderlist"];
			 
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
			 if([arraydata count]>9)
			 {
				 MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
				 tableview.mj_footer = footer;
			 }
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)getmyorderstatus
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];

	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001018000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayorderstatus = [[dic objectForKey:@"data"] objectForKey:@"orderstatuslist"];
			 [self initheader:arrayorderstatus];

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
