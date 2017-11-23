//
//  NearByJXSDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByJXSDetailViewController.h"

@interface NearByJXSDetailViewController ()

@end

@implementation NearByJXSDetailViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] setAlpha:0];
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
	
	// Do any additional setup after loading the view.
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}

	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"经销商信息";
	promoteselect = EnNotSelect;
	jxsitem = EnAllProduct;
	jsxorderitem = EnJSXOrderAuto;
	jsxsaleorder = EnJSXOrderAsc;
	jsxpriceorder = EnJSXOrderAsc;
	arrayheight = [[NSMutableArray alloc] init];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];

	[self.view addSubview:tableview];

    
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
	tableview.mj_footer = footer;
	
	
	
	NSString *orderitem = [self getorderitemid];
	NSString *ordersort = [self getorder:jsxorderitem];
	if([self.strdistribuid length]==0)
	{
		nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
	}
	else
	{
		nowjxsid = self.strdistribuid;
	}
	
	[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:@"10" JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
	
}

-(void)initheader:(NSDictionary *)dic Dictotleinfo:(NSDictionary *)numberinfo
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, viewheader.frame.size.height-5)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	[viewheader addSubview:imageviewbg];
	
	
	NearByJXSPageViewCellView *jxscell = [[NearByJXSPageViewCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dic:dic FomeFlag:@"1"];
	jxscell.delegate1 = self;
	[viewheader addSubview:jxscell];
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, jxscell.frame.origin.y+jxscell.frame.size.height, SCREEN_WIDTH, 50)];
	[viewheader addSubview:scrollview];
	UIImageView *imageviewad = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
	imageviewad.tag = EnJXSDetailAdImageTag;
	imageviewad.image = LOADIMAGE(@"广告", @"png");
	[scrollview addSubview:imageviewad];
	
	UIView *viewitem = [self viewselectitem:CGRectMake(0, scrollview.frame.origin.y+scrollview.frame.size.height+10, SCREEN_WIDTH, 60) DicNumber:numberinfo];
	[viewheader addSubview:viewitem];
	
	tableview.tableHeaderView = viewheader;
}

-(UIView *)viewselectitem:(CGRect)frame DicNumber:(NSDictionary *)dicnumber
{
	UIView *viewitem = [[UIView alloc] initWithFrame:frame];
	
	UIImageView *imagelineh = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
	imagelineh.backgroundColor = ColorBlackVeryGray;
	[viewitem addSubview:imagelineh];
	
	float nowwidth = SCREEN_WIDTH/4;
	for(int i=0;i<4;i++)
	{
		UIImageView *imagelinev = [[UIImageView alloc] initWithFrame:CGRectMake(nowwidth*(i+1), 15, 0.5, 30)];
		imagelinev.backgroundColor = ColorBlackVeryGray;
		[viewitem addSubview:imagelinev];
		
		UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonitem.titleLabel.font = FONTN(14.0f);
		buttonitem.tag = EnNearJXSDetailItemBt+i;
		switch (i) {
			case 0:
				[buttonitem setTitleColor:ColorBlue forState:UIControlStateNormal];
				[buttonitem setTitle:[NSString stringWithFormat:@"%@\n全部商品",[dicnumber objectForKey:@"commoditytotlenumber"]] forState:UIControlStateNormal];
				break;
			case 1:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[NSString stringWithFormat:@"%@\n工程招标",[dicnumber objectForKey:@"porjecttotlenumber"]] forState:UIControlStateNormal];
				break;
			case 2:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[NSString stringWithFormat:@"%@\n招聘信息",[dicnumber objectForKey:@"jobtotlenumber"]] forState:UIControlStateNormal];
				break;
			case 3:
				[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
				[buttonitem setTitle:[NSString stringWithFormat:@"%@\n公司动态",[dicnumber objectForKey:@"newtotlenumber"]] forState:UIControlStateNormal];
				break;
		}

		[buttonitem addTarget:self action:@selector(clickjxsitem:) forControlEvents:UIControlEventTouchUpInside];
		buttonitem.frame = CGRectMake(nowwidth*i, imagelineh.frame.origin.y+1, nowwidth, viewitem.frame.size.height-1);
		buttonitem.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		buttonitem.titleLabel.textAlignment = NSTextAlignmentCenter;
		
		[viewitem addSubview:buttonitem];
	}
	
	
	
	return viewitem;
}

#pragma mark ActionDelegate
-(void)DGClickJXSAddrGotoMap:(id)sender
{
	WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
	webviewcontent.strtitle = [diccompanybaseinfo objectForKey:@"name"];
	NSString *urlstr = [NSString stringWithFormat:@"%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader];
    urlstr = [NSString stringWithFormat:@"%@/address?longitude=%@&latitude=%@",urlstr,[diccompanybaseinfo objectForKey:@"longitude"],[diccompanybaseinfo objectForKey:@"latitude"]];
	webviewcontent.strnewsurl = urlstr;
	[self.navigationController pushViewController:webviewcontent animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(jxsitem==EnAllProduct)
	{
		return 50;
	}
	return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(jxsitem==EnAllProduct)
	{
		UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
		viewbg.backgroundColor = [UIColor whiteColor];
		
		
		float nowwidth = 60;
		for(int i=0;i<3;i++)
		{
			if(i<2)
			{
				UIImageView *imagelinev = [[UIImageView alloc] initWithFrame:CGRectMake(nowwidth*(i+1), 10, 0.5, 20)];
				imagelinev.backgroundColor = ColorBlackVeryGray;
				[viewbg addSubview:imagelinev];
			}
			
			UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
			buttonitem.titleLabel.font = FONTN(14.0f);
			buttonitem.tag = EnNearJXSDetailSortItemBt+i;
			switch (i) {
				case 0:
					if(jsxorderitem==EnJSXOrderAuto)
						[buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
					else
						[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
					[buttonitem setTitle:@"推荐" forState:UIControlStateNormal];
					break;
				case 1:
					if(jsxorderitem==EnJSXOrderSaleCount)
						[buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
					else
						[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
					[buttonitem setTitle:@"销量" forState:UIControlStateNormal];
					[buttonitem setImage:LOADIMAGE(@"nearby_arrow1", @"png") forState:UIControlStateNormal];
					[buttonitem setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
					[buttonitem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
					break;
				case 2:
					if(jsxorderitem==EnJSXOrderPrice)
						[buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
					else
						[buttonitem setTitleColor:ColorBlackGray forState:UIControlStateNormal];
					[buttonitem setTitle:@"价格" forState:UIControlStateNormal];
					[buttonitem setImage:LOADIMAGE(@"nearby_arrow1", @"png") forState:UIControlStateNormal];
					[buttonitem setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
					[buttonitem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
					break;
			}
			
			[buttonitem addTarget:self action:@selector(clickjxssort:) forControlEvents:UIControlEventTouchUpInside];
			buttonitem.frame = CGRectMake(nowwidth*i, 0, 70, viewbg.frame.size.height);
			buttonitem.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
			buttonitem.titleLabel.textAlignment = NSTextAlignmentCenter;
			
			[viewbg addSubview:buttonitem];
		}

		UIButton *buttonpromote = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonpromote.titleLabel.font = FONTN(12.0f);
		buttonpromote.tag = EnNearJXSDetailSortItemBt+3;
		if(promoteselect==EnNotSelect)
		{
			[buttonpromote setTitleColor:ColorBlackGray forState:UIControlStateNormal];
			[buttonpromote setImage:LOADIMAGE(@"nearby_select", @"png") forState:UIControlStateNormal];
		}
		else
		{
			[buttonpromote setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
			[buttonpromote setImage:LOADIMAGE(@"nearby_selectdblack", @"png") forState:UIControlStateNormal];
		}
		[buttonpromote setTitle:@" 只显示促销商品" forState:UIControlStateNormal];
		[buttonpromote addTarget:self action:@selector(clickjxspromote:) forControlEvents:UIControlEventTouchUpInside];
		buttonpromote.frame = CGRectMake(SCREEN_WIDTH-110, 0, 105, 39);
		buttonpromote.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		buttonpromote.titleLabel.textAlignment = NSTextAlignmentCenter;
		[viewbg addSubview:buttonpromote];
		
		UIImageView *imagelineh = [[UIImageView alloc] initWithFrame:CGRectMake(0,viewbg.frame.size.height-1, SCREEN_WIDTH,  0.5)];
		imagelineh.backgroundColor = ColorBlackVeryGray;
		[viewbg addSubview:imagelineh];
		
		return viewbg;
	}
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(jxsitem==EnAllProduct)
	{
		return 110;
	}
	else if(jxsitem==EnProjectTender)
	{
		return 110;
	}
	else if(jxsitem==EnTakeJob)
	{
		return 110;
	}
	else if(jxsitem==EnCompanyMSg)
	{
		return [[arrayheight objectAtIndex:indexPath.row] floatValue];
	}
	
	return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if(jxsitem==EnAllProduct)
	{
		return [arraydata count];
	}
	else if(jxsitem==EnProjectTender)
	{
		return [arraydata count];
	}
	else if(jxsitem==EnTakeJob)
	{
		return [arraydata count];
	}
	else if(jxsitem==EnCompanyMSg)
	{
		return [arrayheight count];
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
	NearByCompanyMsgView *msgview;
	NearByProductPageCellView *productcell;
	NSDictionary *dictemp;
	switch (jxsitem)
	{
		case EnAllProduct:
			dictemp = [arraydata objectAtIndex:indexPath.row];
			productcell = [[NearByProductPageCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp];
			[cell.contentView addSubview:productcell];
			break;
		case EnProjectTender:
			
			break;
		case EnTakeJob:
			
			break;
		case EnCompanyMSg:
			dictemp = [arraydata objectAtIndex:indexPath.row];
			msgview = [[NearByCompanyMsgView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) Dic:dictemp];
			[cell.contentView addSubview:msgview];
			break;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NearByGoodsDetailViewController *goodsdetail;
	NSDictionary *dictemp;
	switch (jxsitem)
	{
		case EnAllProduct:
			dictemp = [arraydata objectAtIndex:indexPath.row];
			goodsdetail = [[NearByGoodsDetailViewController alloc] init];
			goodsdetail.strproductid = [dictemp objectForKey:@"id"];
			goodsdetail.strdistrid = nowjxsid;
			goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
			[self.navigationController pushViewController:goodsdetail animated:YES];
			break;
		case EnProjectTender:
			
			break;
		case EnTakeJob:
			
			break;
		case EnCompanyMSg:

			break;
	}
}


#pragma mark IBaction
-(void)loadNewData:(id)sender
{
	
	if(jxsitem==EnAllProduct)
	{
		NSString *orderitem = [self getorderitemid];
		NSString *ordersort = [self getorder:jsxorderitem];
		if([self.strdistribuid length]==0)
		{
			nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
		}
		else
		{
			nowjxsid = self.strdistribuid;
		}
		
		[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:@"10" JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
	}
	else if(jxsitem==EnProjectTender)
	{
		
	}
	else if(jxsitem==EnTakeJob)
	{
		
	}
	else if(jxsitem==EnCompanyMSg)
	{
		if([self.strdistribuid length]==0)
		{
			nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
		}
		else
		{
			nowjxsid = self.strdistribuid;
		}
		
		[self getcompanynewslist:nowjxsid Page:@"1" PageSize:@"10"];
	}
}

-(void)loadMoreData:(id)sender
{
	if(jxsitem==EnAllProduct)
	{
		NSString *orderitem = [self getorderitemid];
		NSString *ordersort = [self getorder:jsxorderitem];
		if([self.strdistribuid length]==0)
		{
			nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
		}
		else
		{
			nowjxsid = self.strdistribuid;
		}
		
		[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
	}
	else if(jxsitem==EnProjectTender)
	{
		
	}
	else if(jxsitem==EnTakeJob)
	{
		
	}
	else if(jxsitem==EnCompanyMSg)
	{
		if([self.strdistribuid length]==0)
		{
			nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
		}
		else
		{
			nowjxsid = self.strdistribuid;
		}
		
		[self getcompanynewslist:nowjxsid Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
	}
}

-(NSString *)getorderitemid
{
	NSString *strorderitem;
	switch (jsxorderitem)
	{
		case EnJSXOrderAuto:
			strorderitem = @"auto";
			break;
		case EnJSXOrderSaleCount:
			strorderitem = @"salecount";
			break;
		case EnJSXOrderPrice:
			strorderitem = @"price";
			break;
	}
	
	return strorderitem;
}

-(NSString *)getorder:(EnJSXOrderItem)selectorder
{
	NSString *strorder;
	switch (selectorder)
	{
		case EnJSXOrderAuto:
			strorder = @"desc";
			break;
		case EnJSXOrderSaleCount:
			 if(jsxsaleorder==EnJSXOrderDesc)
			 {
				 jsxsaleorder = EnJSXOrderAsc;
				 strorder = @"asc";
			 }
			 else
			 {
				 jsxsaleorder = EnJSXOrderDesc;
				 strorder = @"desc";
			 }
			break;
		case EnJSXOrderPrice:
			if(jsxpriceorder==EnJSXOrderDesc)
			{
				jsxpriceorder = EnJSXOrderAsc;
				strorder = @"asc";
			}
			else
			{
				jsxpriceorder = EnJSXOrderDesc;
				strorder = @"desc";
			}
			break;
	}
	
	return strorder;
}

-(void)clickjxsitem:(id)sender
{
	for(int i=0;i<4;i++)
	{
		UIButton *button1 =[tableview.tableHeaderView viewWithTag:EnNearJXSDetailItemBt+i];
		[button1 setTitleColor:ColorBlackGray forState:UIControlStateNormal];
	}
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnNearJXSDetailItemBt;
	[button setTitleColor:ColorBlue forState:UIControlStateNormal];
	
	NSString *orderitem = [self getorderitemid];
	NSString *ordersort = [self getorder:jsxorderitem];
	

	switch (tagnow)
	{
		case 0:
			jxsitem = EnAllProduct;
			tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
			if([self.strdistribuid length]==0)
			{
				nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
			}
			else
			{
				nowjxsid = self.strdistribuid;
			}
			
			[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:@"10" JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
			break;
		case 1:
			jxsitem = EnProjectTender;
			arraydata = [[NSArray alloc] init];
			[tableview reloadData];
			break;
		case 2:
			jxsitem = EnTakeJob;
			arraydata = [[NSArray alloc] init];
			[tableview reloadData];
			break;
		case 3:
			jxsitem = EnCompanyMSg;
			if([self.strdistribuid length]==0)
			{
				nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
			}
			else
			{
				nowjxsid = self.strdistribuid;
			}
			
			[self getcompanynewslist:nowjxsid Page:@"1" PageSize:@"10"];
			tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
			break;

	}
}

-(void)clickjxssort:(id)sender
{
	for(int i=0;i<3;i++)
	{
		UIButton *button1 =[tableview viewWithTag:EnNearJXSDetailSortItemBt+i];
		[button1 setTitleColor:ColorBlackGray forState:UIControlStateNormal];
	}
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnNearJXSDetailSortItemBt;
	[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	switch (tagnow)
	{
		case 0:
			jsxorderitem = EnJSXOrderAuto;
			break;
		case 1:
			jsxorderitem = EnJSXOrderSaleCount;
			break;
		case 2:
			jsxorderitem = EnJSXOrderPrice;
			break;
	}
	
	
	
	NSString *orderitem = [self getorderitemid];
	NSString *ordersort = [self getorder:jsxorderitem];
	if([self.strdistribuid length]==0)
	{
		nowjxsid = [self.dicjsxfrom objectForKey:@"id"];
	}
	else
	{
		nowjxsid = self.strdistribuid;
	}
	
	[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
}

-(void)clickjxspromote:(id)sender
{
	UIButton *button = (UIButton *)sender;
	if(promoteselect==EnNotSelect) //未选择
	{
		promoteselect = EnSelectd;
		[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[button setImage:LOADIMAGE(@"nearby_selectdblack", @"png") forState:UIControlStateNormal];
	}
	else if(promoteselect==EnSelectd)  //已选择
	{
		promoteselect = EnNotSelect;
		[button setTitleColor:ColorBlackGray forState:UIControlStateNormal];
		[button setImage:LOADIMAGE(@"nearby_select", @"png") forState:UIControlStateNormal];
	}
	NSString *orderitem = [self getorderitemid];
	NSString *ordersort = [self getorder:jsxorderitem];
	[self getjxsproduct:nowjxsid OrderItemId:orderitem Order:ordersort Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] JustForPromotion:[NSString stringWithFormat:@"%d",promoteselect]];
}

#pragma mark 接口
//获取商品
-(void)getjxsproduct:(NSString *)companyid OrderItemId:(NSString *)orderitemid Order:(NSString *)order Page:(NSString *)page PageSize:(NSString *)pagesize JustForPromotion:(NSString *)justforpromotion
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:companyid forKey:@"companyid"];
	[params setObject:orderitemid forKey:@"orderitemid"];
	[params setObject:order forKey:@"order"];
	[params setObject:justforpromotion forKey:@"justforpromotion"];
	[params setObject:@"1" forKey:@"page"];
	[params setObject:@"10" forKey:@"pagesize"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001006000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
			 diccompanybaseinfo =[[dic objectForKey:@"data"] objectForKey:@"companybaseinfo"];
			 [self initheader:diccompanybaseinfo Dictotleinfo:[[dic objectForKey:@"data"] objectForKey:@"businesstotleinfo"]];
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
	 }];
	
}

//获取动态 TBEAENG003001007000
-(void)getcompanynewslist:(NSString *)companyid Page:(NSString *)page PageSize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:companyid forKey:@"companyid"];
	[params setObject:@"1" forKey:@"page"];
	[params setObject:@"10" forKey:@"pagesize"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001007000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
     Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [arrayheight removeAllObjects];
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"newslist"];
			 UIImageView *imageview = [[tableview tableHeaderView] viewWithTag:EnJXSDetailAdImageTag];
			 NSURL *urlstr = [NSURL URLWithString:[[[dic objectForKey:@"data"] objectForKey:@"advertise"] objectForKey:@"picture"]];
			 [imageview setImageWithURL:urlstr];
			 
			 
			 for(int i=0;i<[arraydata count];i++)
			 {
				 NearByCompanyMsgView *msgview = [[NearByCompanyMsgView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) Dic:[arraydata objectAtIndex:i]];
				 [arrayheight addObject:[NSString stringWithFormat:@"%f",msgview.frame.size.height]];
			 }
			 
			 [tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)getcommdityinfo:(NSString *)companyid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:companyid forKey:@"companyid"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001005001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
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
