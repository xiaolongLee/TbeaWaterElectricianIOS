//
//  NearByPageViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByPageViewController.h"

@interface NearByPageViewController ()
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end

@implementation NearByPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	UIImage* img=LOADIMAGE(@"hp_倒三角", @"png");//[UIImage imageNamed:@"城市.png"];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
	button.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
	button.titleLabel.font = FONTMEDIUM(15.0f);
	button.tag = EnSelectCityLeftBtTag;
	[button setTitle:app.dili.dilicity forState:UIControlStateNormal];
	[button addTarget:self action: @selector(selectcity:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	img=LOADIMAGE(@"hp_message", @"png");
	UIView *contentViewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonsearch = [[UIButton alloc] initWithFrame:contentView.bounds];
	[buttonsearch setImage:img forState:UIControlStateNormal];
	buttonsearch.titleLabel.font = FONTMEDIUM(12.0f);
	buttonsearch.tag = EnNctlMessageBt;
	buttonsearch.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[buttonsearch addTarget:self action: @selector(gotomessage:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewsearch addSubview:buttonsearch];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewsearch];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	result = @"";
	stypeid = @"-10000";
	sareaid = @"-10000";
	scerfiid = @"-10000";
	sgoodstypeid = @"-10000";
	sgoodsbrandid = @"-10000";
	
	scityid = @"";
	scityname = app.dili.dilicity;
	
	content1 = [[NSMutableArray alloc] init];
	arraytype =  [[NSMutableArray alloc] init];
	arrayarea =  [[NSMutableArray alloc] init];
	arraycerfi =  [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = EnMaskViewActionTag;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	selectmodel = 0;
	selectitem = 0;
	self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	self.tableview.backgroundColor = [UIColor clearColor];

	[self.view addSubview:self.tableview];
	[self tableviewheader];
	nearbytag = EnNearByJXS;
	
	[self getcompanytype];//获取公司类型
	[self getcompanyarea];//获取公司区域
	[self getcompanycerfi];//获取认证状态
	[self getgoodstype];//获取商品类型
	[self getgoodsbrand];//获取商品品牌
	[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001004000"];//获取经销商列表
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	self.tableview.mj_header = header;
	
	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
	self.tableview.mj_footer = footer;
}

//搜索框
-(void)searchinpuview
{
	SearchPageTopView *searchview = [[SearchPageTopView alloc] initWithFrame:CGRectMake(80, 7, SCREEN_WIDTH-130, 30)];
	searchview.tag = EnNearSearchViewBt;
	searchview.delgate1 = self;
	[self.navigationController.navigationBar addSubview:searchview];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
	[self searchinpuview];
	[self getmessageinfo];
	//去除导航栏下方的横线
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:ColorBlue];
}

-(void)addnearbyshoptyp:(UIView *)viewheader
{
	float widthnow = (SCREEN_WIDTH-100)/3;
	for(int i=0;i<3;i++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(50+widthnow*i, 0, widthnow, 40);
		[button addTarget:self action:@selector(clicknearby:) forControlEvents:UIControlEventTouchUpInside];
		button.titleLabel.font = FONTN(15.0f);
		button.tag = EnNearShopTypeBt+i;
		switch (i) {
			case 0:
				[button setTitle:@"经销商" forState:UIControlStateNormal];
				[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				break;
			case 1:
				[button setTitle:@"商家" forState:UIControlStateNormal];
				[button setTitleColor:Colorgray forState:UIControlStateNormal];
				break;
			case 2:
				[button setTitle:@"采购" forState:UIControlStateNormal];
				[button setTitleColor:Colorgray forState:UIControlStateNormal];
				break;
				
		}
		[viewheader addSubview:button];
	}
	
	
	UIImageView *imagedirect = [[UIImageView alloc] initWithFrame:CGRectMake(50, 35, widthnow, 5)];
	imagedirect.image = LOADIMAGE(@"nearby_icon1", @"png");
	imagedirect.tag = EnNearImageDirect;
	[viewheader addSubview:imagedirect];
}

-(void)addnearbyselecttype:(UIView *)viewheader Imagebg:(UIImageView *)imagebg
{
	float widthnow = (SCREEN_WIDTH-60)/3;
	for(int i=0;i<3;i++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(widthnow*i, imagebg.frame.origin.y, widthnow-1, 30);
		[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		button.titleLabel.font = FONTN(13.0f);
		[button setImage:LOADIMAGE(@"nearby_箭头black", @"png") forState:UIControlStateNormal];
		[button addTarget:self action:@selector(clicksheet:) forControlEvents:UIControlEventTouchUpInside];
		switch (i) {
			case 0:
				button.tag = EnNearBySelectItemBttag1;
				[button setTitle:@"全部类型" forState:UIControlStateNormal];
				break;
			case 1:
				button.tag = EnNearBySelectItemBttag2;
				[button setTitle:@"全部区域" forState:UIControlStateNormal];
				break;
			case 2:
				button.tag = EnNearBySelectItemBttag3;
				[button setTitle:@"认证状态" forState:UIControlStateNormal];
				break;

		}
		[button setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
		[viewheader addSubview:button];
		
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(widthnow*(i+1), imagebg.frame.origin.y+5, 0.5, 20)];
		imageviewline.backgroundColor = Colorgray;
		[viewheader addSubview:imageviewline];
	}
	
	UIImageView *imageviewlineh = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewheader.frame.origin.y+viewheader.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
	imageviewlineh.backgroundColor = Colorgray;
	[viewheader addSubview:imageviewlineh];
}

-(void)tableviewheader
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	//经销商  商家  采购
	UIImageView *imageviewtop1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	imageviewtop1.backgroundColor = COLORNOW(48, 141, 214);
	[viewheader addSubview:imageviewtop1];
	
	
	[self addnearbyshoptyp:viewheader]; //商家类型
	
	
	//类型选择
	UIImageView *imageviewtop2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 30)];
	imageviewtop2.backgroundColor = [UIColor whiteColor];
	[viewheader addSubview:imageviewtop2];
	
	[self addnearbyselecttype:viewheader Imagebg:imageviewtop2]; //选择类型
	
	self.tableview.tableHeaderView = viewheader;
}

#pragma mark actionDelegate
-(void)DGClickSearchOneLevelTextField:(NSString *)sender
{
	SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGSelectCityDone:(NSDictionary *)selectdiccity
{
	UIButton *button = [self.navigationItem.leftBarButtonItem.customView viewWithTag:EnSelectCityLeftBtTag];
	[button setTitle:[selectdiccity objectForKey:@"name"] forState:UIControlStateNormal];
	
	UIButton *button4 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag1];
	UIButton *button5 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag2];
	UIButton *button6 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag3];
	[button4 setTitle:@"全部类型" forState:UIControlStateNormal];
	[button5 setTitle:@"全部区域" forState:UIControlStateNormal];
	[button6 setTitle:@"认证状态" forState:UIControlStateNormal];
	stypeid = @"-10000";
	sareaid = @"-10000";
	scerfiid = @"-10000";
	sgoodstypeid = @"-10000";
	sgoodsbrandid = @"-10000";
	scityid = [selectdiccity objectForKey:@"id"];
	scityname = [selectdiccity objectForKey:@"name"];
	[self getcompanyarea];
	if(selectitem == 0) //选择经销商
	{
		nearbytag = EnNearByJXS;
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001004000"];
		
	}
	else if(selectitem == 1) //选择商家
	{
		nearbytag = EnNearBySJ;
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001008000"];
	}
	else if(selectitem==2) // 选择采购
	{
		nearbytag = EnNearByCG;
		[self getgoodslist:sgoodstypeid BrandId:sgoodsbrandid AreaId:sareaid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
		[button4 setTitle:@"全部类型" forState:UIControlStateNormal];
		[button5 setTitle:@"全部区域" forState:UIControlStateNormal];
		[button6 setTitle:@"全部品牌" forState:UIControlStateNormal];
	}
	
	
}

#pragma mark tableview delegate
-(void)viewDidLayoutSubviews
{
	if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[self.tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
	return 110;
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
	
	cell.backgroundColor = [UIColor whiteColor];
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	if(nearbytag == EnNearByJXS)
	{
		NearByJXSPageViewCellView *jxscell = [[NearByJXSPageViewCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp FomeFlag:@"0"];
		[cell.contentView addSubview:jxscell];
	}
	else if(nearbytag == EnNearBySJ)
	{
		NearByJXSPageViewCellView *jxscell = [[NearByJXSPageViewCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp FomeFlag:@"0"];
		[cell.contentView addSubview:jxscell];
	}
	else
	{
		NearByProductPageCellView *productcell = [[NearByProductPageCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp];
		[cell.contentView addSubview:productcell];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	if(nearbytag == EnNearByJXS)
	{
		if([[dictemp objectForKey:@"companytypeid"] isEqualToString:@"firstleveldistributor"])
		{
			NearByJXSDetailViewController *jxsdetail = [[NearByJXSDetailViewController alloc] init];
			jxsdetail.dicjsxfrom = dictemp;
			jxsdetail.strdistribuid = [dictemp objectForKey:@"id"];
			[self.navigationController pushViewController:jxsdetail animated:YES];
		}
		else if([[dictemp objectForKey:@"companytypeid"] isEqualToString:@"distributor"])
		{
			//longitude  latitude
			WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
			webviewcontent.strtitle = [dictemp objectForKey:@"tasktitle"];
			NSString *str = [NSString stringWithFormat:@"%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpDistribute];
//            @"http://www.u-shang.net/enginterface/index.php/Apph5/business?companyid=";
			str = [NSString stringWithFormat:@"%@%@&userid=%@&longitude=%@&latitude=%@",str,[dictemp objectForKey:@"id"],app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
			webviewcontent.strnewsurl = str;
			[self.navigationController pushViewController:webviewcontent animated:YES];
		}
	}
	else if(nearbytag == EnNearBySJ)
	{
		NearByJXSDetailViewController *jxsdetail = [[NearByJXSDetailViewController alloc] init];
		jxsdetail.dicjsxfrom = dictemp;
		jxsdetail.strdistribuid = [dictemp objectForKey:@"id"];
		[self.navigationController pushViewController:jxsdetail animated:YES];
	}
	else
	{
		NearByGoodsDetailViewController *goodsdetail = [[NearByGoodsDetailViewController alloc] init];
		goodsdetail.strproductid = [dictemp objectForKey:@"id"];
		goodsdetail.strdistrid = [dictemp objectForKey:@"companyid"];
		goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
		[self.navigationController pushViewController:goodsdetail animated:YES];
	}
}



#pragma mark IBaction

//选择类型，区域和认证状态
-(void)clicksheet:(id)sender
{
	UIButton *bt = (UIButton *)sender;
	int tagnow = (int)bt.tag;
	[self showaccession:tagnow];
}

-(void)loadNewData:(id)sender
{
	if(nearbytag == EnNearByJXS) //选择经销商
	{
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001004000"];
		
	}
	else if(nearbytag == EnNearBySJ) //选择商家
	{
		nearbytag = EnNearBySJ;
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001008000"];
	}
	else if(nearbytag == EnNearByCG) // 选择采购
	{
		nearbytag = EnNearByCG;
		[self getgoodslist:sgoodstypeid BrandId:sgoodsbrandid AreaId:sareaid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
//		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
	}
	
	
}

-(void)loadMoreData:(id)sender
{
	if(nearbytag == EnNearByJXS) //选择经销商
	{
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] RequestCode:@"TBEAENG003001004000"];
		
	}
	else if(nearbytag == EnNearBySJ) //选择商家
	{
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] RequestCode:@"TBEAENG003001008000"];
	}
	else if(nearbytag == EnNearByCG) // 选择采购
	{
		[self getgoodslist:sgoodstypeid BrandId:sgoodsbrandid AreaId:sareaid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
	//	[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
	}
	
	
}

-(void)selectcity:(id)sender
{
	SelectCityViewController *selectcity = [[SelectCityViewController alloc] init];
	selectcity.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:selectcity];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)gotomessage:(id)sender
{
	MyMessageViewController *message = [[MyMessageViewController alloc] init];
	[self.navigationController pushViewController:message animated:YES];
}


-(void)photoTappednews:(UIGestureRecognizer*)sender
{
	UIView *viewtemp = sender.view;
//	int tagnow = (int)viewtemp.tag-6890;
	
}

-(void)clicknearby:(id)sender
{
	UIButton *button1 = [self.tableview.tableHeaderView viewWithTag:EnNearShopTypeBt];
	UIButton *button2 = [self.tableview.tableHeaderView viewWithTag:EnNearShopTypeBt+1];
	UIButton *button3 = [self.tableview.tableHeaderView viewWithTag:EnNearShopTypeBt+2];
	[button1 setTitleColor:Colorgray forState:UIControlStateNormal];
	[button2 setTitleColor:Colorgray forState:UIControlStateNormal];
	[button3 setTitleColor:Colorgray forState:UIControlStateNormal];
	
	UIImageView *imageview = [self.tableview.tableHeaderView viewWithTag:EnNearImageDirect];
	UIButton *button = (UIButton *)sender;
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	int tagnow = (int)[button tag]-EnNearShopTypeBt;
	selectitem = tagnow;
	imageview.frame = CGRectMake(50+button.frame.size.width*tagnow, imageview.frame.origin.y, imageview.frame.size.width, imageview.frame.size.height);
	
	UIButton *button4 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag1];
	UIButton *button5 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag2];
	UIButton *button6 = [self.tableview.tableHeaderView viewWithTag:EnNearBySelectItemBttag3];
	[button4 setTitle:@"全部类型" forState:UIControlStateNormal];
	[button5 setTitle:@"全部区域" forState:UIControlStateNormal];
	[button6 setTitle:@"认证状态" forState:UIControlStateNormal];
	stypeid = @"-10000";
	sareaid = @"-10000";
	scerfiid = @"-10000";
	sgoodstypeid = @"-10000";
	sgoodsbrandid = @"-10000";
	if(selectitem == 0) //选择经销商
	{
		nearbytag = EnNearByJXS;
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001004000"];
		
	}
	else if(selectitem == 1) //选择商家
	{
		nearbytag = EnNearBySJ;
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001008000"];
	}
	else if(selectitem==2) // 选择采购
	{
		nearbytag = EnNearByCG;
		[self getgoodslist:sgoodstypeid BrandId:sgoodsbrandid AreaId:sareaid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
		[button4 setTitle:@"全部类型" forState:UIControlStateNormal];
		[button5 setTitle:@"全部区域" forState:UIControlStateNormal];
		[button6 setTitle:@"全部品牌" forState:UIControlStateNormal];
	}
	

}

#pragma mark 接口
-(void)getgoodslist:(NSString *)typeid BrandId:(NSString *)brandid AreaId:(NSString *)areaid Page:(NSString *)page PageSize:(NSString *)pagesize RequestCode:(NSString *)rcode
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:typeid forKey:@"categoryid"];
	[params setObject:brandid forKey:@"brandid"];
	[params setObject:areaid forKey:@"locationid"];
	[params setObject:@"1" forKey:@"page"];
	[params setObject:@"10" forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:rcode ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self.tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [self.tableview.mj_header endRefreshing];
		 [self.tableview.mj_footer endRefreshing];
	 }];
	
}


-(void)getjxslist:(NSString *)typeid AreaId:(NSString *)areaid certifiedid:(NSString *)cerid Page:(NSString *)page PageSize:(NSString *)pagesize RequestCode:(NSString *)rcode
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:typeid forKey:@"companytypeid"];
	[params setObject:areaid forKey:@"locationid"];
	[params setObject:cerid forKey:@"certifiedstatusid"];
	[params setObject:scityname forKey:@"cityname"];
	[params setObject:scityid forKey:@"cityid"];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:rcode ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
		//	 if()
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"companylist"];
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self.tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [self.tableview.mj_header endRefreshing];
		 [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)getgoodstype   //获取商品类型
{
	
	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG003001009001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraygoodtype = [[dic objectForKey:@"data"] objectForKey:@"commoditycategorylist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}

-(void)getgoodsbrand   //获取商品品牌
{
	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG003001009002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraygoodBrand = [[dic objectForKey:@"data"] objectForKey:@"commoditybrandlist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}


-(void)getcompanytype   //获取公司类型
{

	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG003001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
//		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraytype = [[dic objectForKey:@"data"] objectForKey:@"companytypelist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}

//获取区域
-(void)getcompanyarea
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scityname forKey:@"cityname"];
	[RequestInterface doGetJsonWithParametersNoAn1:params App:app RequestCode:@"TBEAENG003001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
//		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayarea = [[dic objectForKey:@"data"] objectForKey:@"locationlist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}

//获取认证状态
-(void)getcompanycerfi
{
	
	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG003001003000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
//		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraycerfi = [[dic objectForKey:@"data"] objectForKey:@"certifiedstatuslist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

-(void)getmessageinfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001001001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 UIButton *button = [self.navigationController.navigationBar viewWithTag:EnNctlMessageBt];
			 if([[[[dic objectForKey:@"data"] objectForKey:@"shortcutinfo"] objectForKey:@"newmessagenumber"] intValue]>0)
				 [button setImage:LOADIMAGE(@"hp_messageredpoint", @"png") forState:UIControlStateNormal];
			 else
				 [button setImage:LOADIMAGE(@"hp_message", @"png") forState:UIControlStateNormal];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [self.tableview.mj_header endRefreshing];
		 [self.tableview.mj_footer endRefreshing];
	 }];
	
}

#pragma mark - 滚轮选择
-(void)showaccession:(int)sender
{
	selectmodel = sender;
	[self showpickview:sender];
}

-(UIView *)initviewsheet:(CGRect)frameview
{
	UIView *viewsheet = [[UIView alloc] initWithFrame:frameview];
	viewsheet.backgroundColor = [UIColor whiteColor];
	
	UIPickerView *picview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 216)];
	picview.delegate = self;
	picview.tag = 9990;
	[viewsheet addSubview:picview];
	
	UIButton *buttoncancel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncancel.frame = CGRectMake(0, 0, 80, 40);
	buttoncancel.titleLabel.font = FONTMEDIUM(15.0f);
	[buttoncancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttoncancel addTarget:self action:@selector(cancelbt:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncancel setTitle:@"取消" forState:UIControlStateNormal];
	[viewsheet addSubview:buttoncancel];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
	buttondone.titleLabel.font = FONTMEDIUM(15.0f);
	[buttondone addTarget:self action:@selector(ensurebt:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	[viewsheet addSubview:buttondone];
	
	return viewsheet;
}

- (void)showpickview:(int)sender
{
	[content1 removeAllObjects];
	if(nearbytag == EnNearByCG)
	{
		if(sender == EnNearBySelectItemBttag1)  //商品类型
		{
			if([arraygoodtype count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arraygoodtype count];i++)
			{
				NSDictionary *dictype = [arraygoodtype objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
		else if(sender == EnNearBySelectItemBttag3)   //商品品牌
		{
			if([arraygoodBrand count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arraygoodBrand count];i++)
			{
				NSDictionary *dictype = [arraygoodBrand objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
		else if(sender == EnNearBySelectItemBttag2)   //选择区域
		{
			if([arrayarea count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arrayarea count];i++)
			{
				NSDictionary *dictype = [arrayarea objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
	}
	else
	{
		if(sender == EnNearBySelectItemBttag1)  //选择类型
		{
			if([arraytype count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arraytype count];i++)
			{
				NSDictionary *dictype = [arraytype objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
		else if(sender == EnNearBySelectItemBttag2)   //选择区域
		{
			if([arrayarea count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arrayarea count];i++)
			{
				NSDictionary *dictype = [arrayarea objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
		else if(sender == EnNearBySelectItemBttag3)   //选择认证状态
		{
			if([arraycerfi count]==0)
			{
				[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
				return;
			}
			for(int i=0;i<[arraycerfi count];i++)
			{
				NSDictionary *dictype = [arraycerfi objectAtIndex:i];
				[content1 addObject:[dictype objectForKey:@"name"]];
			}
		}
	}
	
	[[self.view viewWithTag:EnViewSheetTag] removeFromSuperview];
	[maskView removeFromSuperview];
	
	[self.view addSubview:maskView];
	maskView.alpha = 0;
	UIView *viewsheet = [self initviewsheet:CGRectMake(0, SCREEN_HEIGHT-255, SCREEN_WIDTH, 255)];
	viewsheet.tag = EnViewSheetTag;
	[app.window addSubview:viewsheet];
	
	UIPickerView *picview = (UIPickerView *)[app.window viewWithTag:9990];
	
	[picview selectRow:[content1 count]/2 inComponent:0 animated:NO];
	result  = [content1 objectAtIndex:[content1 count]/2];
	
	[UIView animateWithDuration:0.3 animations:^{
		maskView.alpha = 0.3;
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x, SCREEN_HEIGHT-viewsheet.frame.size.height, viewsheet.frame.size.width, viewsheet.frame.size.height);
	}];
	
}

- (void)hideMyPicker {
	UIView *viewsheet = (UIView *)[app.window viewWithTag:EnViewSheetTag];
	[UIView animateWithDuration:0.3 animations:^{
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x,SCREEN_HEIGHT, viewsheet.frame.size.width, viewsheet.frame.size.height);
		maskView.alpha = 0;
	} completion:^(BOOL finished) {
		[viewsheet removeFromSuperview];
		[maskView removeFromSuperview];
	}];
}



- (void)cancelbt:(id)sender {
	[self hideMyPicker];
}

- (void)ensurebt:(id)sender {
	
	[self hideMyPicker];
	
	UIButton *button = [[self.tableview tableHeaderView] viewWithTag:selectmodel];
	if(nearbytag == EnNearByCG)
	{
		if(selectmodel == EnNearBySelectItemBttag1)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arraygoodtype count];i++)
			{
				NSDictionary *dictemp = [arraygoodtype objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					sgoodstypeid = [dictemp objectForKey:@"id"];
					break;
				}
			}
			
		}
		else if(selectmodel == EnNearBySelectItemBttag3)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arraygoodBrand count];i++)
			{
				NSDictionary *dictemp = [arraygoodBrand objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					sgoodsbrandid = [dictemp objectForKey:@"id"];
					break;
				}
			}
		}
		else if(selectmodel == EnNearBySelectItemBttag2)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arrayarea count];i++)
			{
				NSDictionary *dictemp = [arrayarea objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					sareaid = [dictemp objectForKey:@"id"];
					break;
				}
			}
		}
	}
	else
	{
		if(selectmodel == EnNearBySelectItemBttag1)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arraytype count];i++)
			{
				NSDictionary *dictemp = [arraytype objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					stypeid = [dictemp objectForKey:@"id"];
					break;
				}
			}
			
		}
		else if(selectmodel == EnNearBySelectItemBttag2)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arrayarea count];i++)
			{
				NSDictionary *dictemp = [arrayarea objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					sareaid  = [dictemp objectForKey:@"id"];
					break;
				}
			}
		}
		else if(selectmodel == EnNearBySelectItemBttag3)
		{
			[button setTitle:result forState:UIControlStateNormal];
			for(int i=0;i<[arraycerfi count];i++)
			{
				NSDictionary *dictemp = [arraycerfi objectAtIndex:i];
				if([[dictemp objectForKey:@"name"] isEqualToString:result])
				{
					scerfiid = [dictemp objectForKey:@"id"];
					break;
				}
			}
		}
	}
	if(nearbytag == EnNearByJXS) //选择经销商
	{
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001004000"];
		
	}
	else if(nearbytag == EnNearBySJ) //选择商家
	{
		[self getjxslist:stypeid AreaId:sareaid certifiedid:scerfiid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001008000"];
	}
	else if(nearbytag == EnNearByCG) // 选择采购
	{
		[self getgoodslist:sgoodstypeid BrandId:sgoodsbrandid AreaId:sareaid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG003001009000"];
	}

}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	return 1;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if(component == 0)
		return [content1 count];
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component == 0)
		return [content1 objectAtIndex:row];
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component == 0)
		result = [content1 objectAtIndex:row];
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
