//
//  ReceiveActivityViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "ReceiveActivityViewController.h"

@interface ReceiveActivityViewController ()
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end

@implementation ReceiveActivityViewController

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
	stypeid = @"-10000";
	sareaid = @"-10000";
	stimeid = @"-10000";
	scityid = @"";
	scityname = app.dili.dilicity;
	
	content1 = [[NSMutableArray alloc] init];
	arraytype =  [[NSMutableArray alloc] init];
	arrayarea =  [[NSMutableArray alloc] init];
	arraytime =  [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = EnMaskViewActionTag;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	selectmodel = 0;

	
	self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	self.tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.tableview];
	[self tableviewheader];
	
	[self gettasktype];//获取任务类型
	[self gettaskarea];//获取任务区域
	[self gettasktime];//获取任务时间
	
	[self gettasklist:@"-10000" AreaId:@"-10000" Timeid:@"-10000" Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG004001003000"];//接活列表
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
	[self searchinpuview];
	[self getmessageinfo];
	//去除导航栏下方的横线
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:ColorBlue];
//	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}

-(void)addnearbyselecttype:(UIView *)viewheader Imagebg:(UIImageView *)imagebg
{
	float widthnow = (SCREEN_WIDTH)/3;
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
				button.tag = EnReceiveSelectItemBttag1;
				[button setTitle:@"全部类型" forState:UIControlStateNormal];
				break;
			case 1:
				button.tag = EnReceiveSelectItemBttag2;
				[button setTitle:@"全部区域" forState:UIControlStateNormal];
				break;
			case 2:
				button.tag = EnReceiveSelectItemBttag3;
				[button setTitle:@"全部时间" forState:UIControlStateNormal];
				break;
				
		}
		[button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -100)];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
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
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	//类型选择
	UIImageView *imageviewtop2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, SCREEN_WIDTH, 30)];
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
	
	UIButton *button4 = [self.tableview.tableHeaderView viewWithTag:EnReceiveSelectItemBttag1];
	UIButton *button5 = [self.tableview.tableHeaderView viewWithTag:EnReceiveSelectItemBttag2];
	UIButton *button6 = [self.tableview.tableHeaderView viewWithTag:EnReceiveSelectItemBttag3];
	[button4 setTitle:@"全部类型" forState:UIControlStateNormal];
	[button5 setTitle:@"全部区域" forState:UIControlStateNormal];
	[button6 setTitle:@"全部时间" forState:UIControlStateNormal];
	stypeid = @"-10000";
	sareaid = @"-10000";
	stimeid = @"-10000";
	scityid = [selectdiccity objectForKey:@"id"];
	scityname = [selectdiccity objectForKey:@"name"];
	[self gettaskarea];

	[self gettasklist:@"-10000" AreaId:@"-10000" Timeid:@"-10000" Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG004001003000"];
	
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
	return 90;
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
	[cell.contentView addSubview:[self tableviewcell:nil IndexPath:(NSIndexPath *)indexPath Dic:dictemp]];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
	webviewcontent.strtitle = [dictemp objectForKey:@"tasktitle"];
	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/taskdetail?taskid=";
	str = [NSString stringWithFormat:@"%@%@",str,[dictemp objectForKey:@"id"]];
	webviewcontent.strnewsurl = str;
	[self.navigationController pushViewController:webviewcontent animated:YES];
}

//经销商和商家cell
-(UIView *)tableviewcell:(NSDictionary *)sender IndexPath:(NSIndexPath *)indexpath Dic:(NSDictionary *)dic
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109)];
	
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
	NSURL *urlstr = [NSURL URLWithString:[dic objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic2", @"png")];
	[view addSubview:imageviewleft];
	
	NSString *str= [dic objectForKey:@"publishername"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-100 Fheight:20 Sfont:FONTN(13.0f)];
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y+2, size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(13.0f);
	labelname.textColor = ColorBlue;
	[view addSubview:labelname];
	
	float noworginx = labelname.frame.origin.x+labelname.frame.size.width+3;
	
	if([[dic objectForKey:@"publisheriscompany"] intValue]==1)
	{
		UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(noworginx, labelname.frame.origin.y+2, 12, 14)];
		imageviewicon.image = LOADIMAGE(@"accept_商家icon", @"png");
		[view addSubview:imageviewicon];
		noworginx = noworginx+18;
	}
	
	if([[dic objectForKey:@"publisherwhetheridentify"] intValue]==1)
	{
		UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(noworginx, labelname.frame.origin.y+4, 16, 12)];
		imageviewicon.image = LOADIMAGE(@"nearby_个人认证", @"png");
		[view addSubview:imageviewicon];
		noworginx = noworginx+15;
	}
	
	
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelname.frame.origin.y, 90, 20)];
	labeltime.text =[dic objectForKey:@"publishtime"];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentRight;
	labeltime.textColor = ColorBlackGray;
	[view addSubview:labeltime];

	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x, imageviewleft.frame.origin.y+imageviewleft.frame.size.height+5, SCREEN_WIDTH-20, 20)];
	labeltitle.text = [dic objectForKey:@"tasktitle"];
	labeltitle.font = FONTMEDIUM(15.0f);
	labeltitle.textColor = ColorBlackdeep;
	[view addSubview:labeltitle];
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, labeltitle.frame.origin.y+labeltitle.frame.size.height+5, SCREEN_WIDTH-120, 20)];
	labeladdr.text = [dic objectForKey:@"taskaddress"];
	labeladdr.font = FONTN(13.0f);
	labeladdr.textColor = ColorBlackGray;
	[view addSubview:labeladdr];
	
	UIImageView *imageviewlocation = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, labeladdr.frame.origin.y, 10, 13)];
	imageviewlocation.image = LOADIMAGE(@"附近blue", @"png");
	[view addSubview:imageviewlocation];
	
	UILabel *labeldistance = [[UILabel alloc] initWithFrame:CGRectMake(imageviewlocation.frame.origin.x+imageviewlocation.frame.size.width+3, labeladdr.frame.origin.y-3, 55, 20)];
	labeldistance.text = [dic objectForKey:@"taskdistance"];
	labeldistance.font = FONTN(13.0f);
	labeldistance.textColor = Colorqingsecolor;
	[view addSubview:labeldistance];
	
	
	
	
	return view;
}

#pragma mark IBaction
-(void)clicksheet:(id)sender
{
	UIButton *bt = (UIButton *)sender;
	int tagnow = (int)bt.tag;
	[self showaccession:tagnow];
}

-(void)loadNewData:(id)sender
{
	[self gettasklist:@"-10000" AreaId:@"-10000" Timeid:@"-10000" Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG004001003000"];
}

-(void)loadMoreData:(id)sender
{
	[self gettasklist:stypeid AreaId:sareaid Timeid:stimeid Page:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] RequestCode:@"TBEAENG004001003000"];
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

#pragma mark 接口
-(void)gettasklist:(NSString *)typeid AreaId:(NSString *)areaid Timeid:(NSString *)timeid Page:(NSString *)page PageSize:(NSString *)pagesize RequestCode:(NSString *)rcode
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:typeid forKey:@"tasktypeid"];
	[params setObject:areaid forKey:@"locationid"];
	[params setObject:timeid forKey:@"timescopeid"];
	[params setObject:scityname forKey:@"cityname"];
	[params setObject:scityid forKey:@"cityid"];
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
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"tasklist"];
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

-(void)gettasktype   //获取任务类型
{
	
	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG004001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraytype = [[dic objectForKey:@"data"] objectForKey:@"tasktypelist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}

//获取区域
-(void)gettaskarea
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

//获取时间
-(void)gettasktime
{
	
	[RequestInterface doGetJsonWithParametersNoAn1:nil App:app RequestCode:@"TBEAENG004001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraytime = [[dic objectForKey:@"data"] objectForKey:@"timescopelist"];
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
	
	if(sender == EnReceiveSelectItemBttag1)  //选择类型
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
	else if(sender == EnReceiveSelectItemBttag2)   //选择区域
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
	else if(sender == EnReceiveSelectItemBttag3)   //选择时间
	{
		if([arraytime count]==0)
		{
			[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
			return;
		}
		for(int i=0;i<[arraytime count];i++)
		{
			NSDictionary *dictype = [arraytime objectAtIndex:i];
			[content1 addObject:[dictype objectForKey:@"name"]];
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
	
	if(selectmodel == EnReceiveSelectItemBttag1)
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
	else if(selectmodel == EnReceiveSelectItemBttag2)
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
	else if(selectmodel == EnReceiveSelectItemBttag3)
	{
		[button setTitle:result forState:UIControlStateNormal];
		for(int i=0;i<[arraytime count];i++)
		{
			NSDictionary *dictemp = [arraytime objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:result])
			{
				stimeid = [dictemp objectForKey:@"id"];
				break;
			}
		}
	}
	

	[self gettasklist:stypeid AreaId:sareaid Timeid:stimeid Page:@"1" PageSize:@"10" RequestCode:@"TBEAENG004001003000"];

	
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
