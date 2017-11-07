//
//  HomePageViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@property(nonatomic,strong)UITableView *tableview;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	flaginit = 0;
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
	
//	if(![AddInterface judgeislogin])
//	{
//		[self addloginview];
//	}
//	else
//	{
		[self gethomepage:app.dili.dilicity CityId:@"" Page:@"1" Pagesize:@"10"];
//	}
	self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	self.tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.tableview];
	[self setExtraCellLineHidden:self.tableview];
	
	
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	self.tableview.mj_header = header;

    [self getupdateversion];
	
	
}

//搜索框
-(void)searchinpuview
{
	SearchPageTopView *searchview = [[SearchPageTopView alloc] initWithFrame:CGRectMake(80, 7, SCREEN_WIDTH-130, 30)];
	searchview.delgate1 = self;
	searchview.tag = EnNearSearchViewBt;
	[self.navigationController.navigationBar addSubview:searchview];
}

//头
-(void)tabviewheader:(NSDictionary *)dic
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,315)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	[viewheader addSubview:imageviewbg];
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,200)];
	scrollview.pagingEnabled = YES;
	scrollview.delegate = self;
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	[viewheader addSubview:scrollview];
	
	NSArray *arrayadpic = [dic objectForKey:@"advertiselist"];
	NSArray *arraytongzhi = [dic objectForKey:@"newmessage1"];
	NSArray *arrayfanli = [dic objectForKey:@"newmessage2"];
	for(int i=0;i<[arrayadpic count];i++)
	{
		NSDictionary *dictemp = [arrayadpic objectAtIndex:i];
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+SCREEN_WIDTH*i, 0,SCREEN_WIDTH, scrollview.frame.size.height)];
		NSURL *urlstr = [NSURL URLWithString:[dictemp objectForKey:@"picture"]];
		
		[imageview setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic", @"png")];
		imageview.contentMode = UIViewContentModeScaleAspectFill;
		imageview.userInteractionEnabled = YES;
		UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappednews:)];
		imageview.tag = EnHpAdPicImageview+i;
		imageview.clipsToBounds = YES;
		[imageview addGestureRecognizer:singleTap];
		[scrollview addSubview:imageview];
	}
	[scrollview setContentSize:CGSizeMake(SCREEN_WIDTH*[arrayadpic count], scrollview.frame.size.height)];
	
	SMPageControl* spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-55,scrollview.frame.size.height-22, 100,20)];
	spacePageControl1.center = CGPointMake(SCREEN_WIDTH/2,scrollview.frame.size.height-22+10);
	spacePageControl1.indicatorDiameter = 3.0f;
	spacePageControl1.indicatorMargin = 5.0f;
	spacePageControl1.alignment = SMPageControlAlignmentCenter;
	spacePageControl1.tag = EnHpSMPageControl;
	spacePageControl1.numberOfPages = [arrayadpic count];
	spacePageControl1.currentPage = 0;
	spacePageControl1.backgroundColor = [UIColor clearColor];
	[spacePageControl1 setPageIndicatorImage:[UIImage imageNamed:@"pageorange.png"]];
	[spacePageControl1 setCurrentPageIndicatorImage:[UIImage imageNamed:@"pagewhite.png"]];
	[viewheader addSubview:spacePageControl1];
	
	self.tableview.tableHeaderView = viewheader;
	
	//活动通知
	UIImageView *imageviewactivity = [[UIImageView alloc] init];
	imageviewactivity.image = LOADIMAGE(@"hp_通知icon", @"png");
	[viewheader addSubview:imageviewactivity];
	[imageviewactivity mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(13, 15));
		make.top.equalTo(@210);
		make.left.mas_equalTo(@10);
	}];
	
	UILabel *labelactivity = [[UILabel alloc] init];
	labelactivity.text = @"活动通知";
	labelactivity.font = FONTN(13.0f);
	labelactivity.textColor = ColorBlue;
	[viewheader addSubview:labelactivity];
	[labelactivity mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(60, 19));
		make.left.mas_equalTo(imageviewactivity.mas_right).with.offset(3);
		make.top.mas_equalTo(imageviewactivity.mas_top).offset(-2);
	}];
	
	UILabel *labelactivityvalue = [[UILabel alloc] init];
	if([arraytongzhi count]>0)
	{
		NSDictionary *dictemp = [arraytongzhi objectAtIndex:0];
		labelactivityvalue.text = [dictemp objectForKey:@"name"];
	}
	
	labelactivityvalue.font = FONTN(13.0f);
	labelactivityvalue.textColor = ColorBlackGray;
	[viewheader addSubview:labelactivityvalue];
	[labelactivityvalue mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(labelactivity.mas_top);
		make.height.mas_equalTo(19);
		make.left.mas_equalTo(labelactivity.mas_right).with.offset(5);
		make.right.mas_equalTo(5);
	}];
	
	UIImageView *imageline = [[UIImageView alloc] init];
	imageline.backgroundColor = COLORNOW(200, 200, 200);
	[viewheader addSubview:imageline];
	[imageline mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(labelactivityvalue.mas_bottom).offset(8);
		make.height.equalTo(@0.5);
		make.left.right.equalTo(@0);
	}];
	
	//扫码返利
	UIImageView *imageicon = [[UIImageView alloc] init];
	imageicon.image = LOADIMAGE(@"hp_返利pic", @"png");
	[viewheader addSubview:imageicon];
	[imageicon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(60, 66));
		make.top.mas_equalTo(imageline.mas_bottom).offset(5);
		make.left.mas_equalTo(10);
	}];
	
	UIScrollView *scrollviewfanli = [[UIScrollView alloc] init];
	scrollviewfanli.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:scrollviewfanli];
	[scrollviewfanli mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imageicon.mas_right);
		make.top.mas_equalTo(imageicon.mas_top);
		make.right.mas_equalTo(@-1);
		make.bottom.mas_equalTo(imageicon.mas_bottom);
	}];
	
	
	
	for(int i=0;i<[arrayfanli count];i++)
	{
		NSDictionary *dicfanli = [arrayfanli objectAtIndex:i];
		[self viewfanlicell:scrollviewfanli Frame:CGRectMake(0, 5+30*i, SCREEN_WIDTH-114, 30) DicFanLi:dicfanli];
	
	}
}

//返利cell
-(UIView *)viewfanlicell:(UIScrollView *)scrollview Frame:(CGRect)frame DicFanLi:(NSDictionary *)dicfanli
{
	UIFont *font1 = FONTN(13.f);
	if(iphone6)
		font1 = FONTN(15.0f);
	else if(iphone6p)
		font1 = FONTN(17.0f);
	
	float width1 = 90;
	float width3 = 60;
	float width2 = SCREEN_WIDTH-width1-width3-70-30;
	
	if(iphone6)
	{
		width1 = 105;
		width3 = 70;
		width2 = SCREEN_WIDTH-width1-width3-70-30;
		
	}
	else if(iphone6p)
	{
		width1 = 115;
		width3 = 70;
		width2 = SCREEN_WIDTH-width1-width3-70-30;
		
	}
	
	UIView *viewfanli = [[UIView alloc] initWithFrame:frame];
	viewfanli.backgroundColor = [UIColor clearColor];
	[scrollview addSubview:viewfanli];
	
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
	NSURL *urlstr = [NSURL URLWithString:[dicfanli objectForKey:@"picture"]];
	[imageviewheader setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic2", @"png")];
	[viewfanli addSubview:imageviewheader];

	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+5, 5, width1, 20)];
	labelname.text = [dicfanli objectForKey:@"username"];
	labelname.font = font1;
	labelname.textColor = [UIColor redColor];
	[viewfanli addSubview:labelname];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width, labelname.frame.origin.y, width2, 20)];
	labelins.text = [dicfanli objectForKey:@"message"];
	labelins.font = font1;
	labelins.textColor = ColorBlackshallow;
	[viewfanli addSubview:labelins];
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(labelins.frame.origin.x+labelins.frame.size.width, labelname.frame.origin.y, width3, 20)];
	labelmoney.text = [NSString stringWithFormat:@"￥%@",[dicfanli objectForKey:@"money"]];
	labelmoney.font = font1;
	labelmoney.textAlignment = NSTextAlignmentRight;
	labelmoney.textColor = [UIColor redColor];
	[viewfanli addSubview:labelmoney];
	
	return viewfanli;
}

-(void )viewWillAppear:(BOOL)animated
{
	[self getmessageinfo];
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
	[self searchinpuview];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	
	if(flaginit == 0)
	{
		UIButton *button = [self.navigationItem.leftBarButtonItem.customView viewWithTag:EnSelectCityLeftBtTag];
		[button setTitle:app.dili.dilicity forState:UIControlStateNormal];
	}
	
}

#pragma mark actionDelegate
-(void)loginsuccess:(id)sender
{

//	[self gethomepage:app.dili.dilicity CityId:@"" Page:@"1" Pagesize:@"10"];
}

-(void)DGClickSearchOneLevelTextField:(NSString *)sender
{
	SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGSelectCityDone:(NSDictionary *)diccity
{
	flaginit = 1;
	[self gethomepage:[diccity objectForKey:@"name"] CityId:[diccity objectForKey:@"id"] Page:@"1" Pagesize:@"10"];
	
	UIButton *button = [self.navigationItem.leftBarButtonItem.customView viewWithTag:EnSelectCityLeftBtTag];
	[button setTitle:[diccity objectForKey:@"name"] forState:UIControlStateNormal];
}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView

{
	
	UIView *view = [UIView new];
	
	view.backgroundColor = [UIColor clearColor];
	
	[tableView setTableFooterView:view];
	
	
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
	viewbg.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
	labelmoney.text = @"热销产品";
	labelmoney.font = FONTN(14.0f);
	labelmoney.textColor = ColorBlackdeep;
	[viewbg addSubview:labelmoney];
	
//	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(labelmoney.frame.origin.x+labelmoney.frame.size.width, 7, 12, 16)];
//	imageicon.image = LOADIMAGE(@"hp_附近商家icon", @"png");
//	[viewbg addSubview:imageicon];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewbg.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = ColorBlackVeryshallow;
	[viewbg addSubview:imageline];
	
	
	return viewbg;
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
	NSArray *arrayhp = [dichp objectForKey:@"companylist"];
	return [arrayhp count];
	
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
	NSDictionary *dictemp = [[dichp objectForKey:@"companylist"] objectAtIndex:indexPath.row];
	[cell.contentView addSubview:[self tableviewcell:dictemp]];
//	
//	//	NSArray *arrayproduct = [self.dicresponse objectForKey:@"ProductList"];
//	NSDictionary *dictemp = [self.arrayjigou objectAtIndex:indexPath.row];
//	
//	UIImageView *imageviewbgwhite = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 165)];
//	imageviewbgwhite.backgroundColor = [UIColor whiteColor];
//	[cell.contentView addSubview:imageviewbgwhite];
//	

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [[dichp objectForKey:@"companylist"] objectAtIndex:indexPath.row];
	NearByGoodsDetailViewController *goodsdetail = [[NearByGoodsDetailViewController alloc] init];
	goodsdetail.strproductid = [dictemp objectForKey:@"id"];
	goodsdetail.strdistrid = [dictemp objectForKey:@"companyid"];
	goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
	[self.navigationController pushViewController:goodsdetail animated:YES];
}


-(UIView *)tableviewcell:(NSDictionary *)sender
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109)];
	
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 80, 80)];
	NSURL *urlstr = [NSURL URLWithString:[sender objectForKey:@"picture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[view addSubview:imageviewleft];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y, SCREEN_WIDTH-100, 20)];
	labelname.text = [sender objectForKey:@"name"];
	labelname.font = FONTN(15.0f);
	labelname.textColor = ColorBlackdeep;
	[view addSubview:labelname];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, SCREEN_WIDTH-100, 40)];
	labelins.text = [sender objectForKey:@"specification"];
	labelins.font = FONTN(13.0f);
	labelins.numberOfLines = 2;
	labelins.textColor = ColorBlackGray;
	[view addSubview:labelins];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelins.frame.origin.x, labelins.frame.origin.y+labelins.frame.size.height, 100, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"price"]];
	labelprice.font = FONTN(13.0f);
	labelprice.textColor = Colorredcolor;
	[view addSubview:labelprice];

	UILabel *labeldistance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, labelprice.frame.origin.y, 90, 20)];
	labeldistance.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"distance"]];
	labeldistance.font = FONTN(13.0f);
	labeldistance.textAlignment = NSTextAlignmentRight;
	labeldistance.textColor = Colorqingsecolor;
	[view addSubview:labeldistance];
	
	
	return view;
}

#pragma mark IBaction

-(void)addloginview
{
	LoginViewController *loginview = [[LoginViewController alloc] init];
	loginview.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:loginview];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
	
}

-(void)loadNewData:(id)sender
{
	[self gethomepage:app.dili.dilicity CityId:@"" Page:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	NSArray *arraynow = [dichp objectForKey:@"companylist"];
	[self gethomepage:app.dili.dilicity CityId:@"" Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraynow count]]];
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
	if(![AddInterface judgeislogin])
	{
		[self addloginview];
	}
	else
	{
		MyMessageViewController *message = [[MyMessageViewController alloc] init];
		[self.navigationController pushViewController:message animated:YES];
	}
}

-(void)photoTappednews:(UIGestureRecognizer*)sender
{
	UIView *viewtemp = sender.view;
//	int tagnow = (int)viewtemp.tag-6890;
    
    if(![AddInterface judgeislogin])
    {
        [self addloginview];
    }
    else
    {
        MyMessageViewController *message = [[MyMessageViewController alloc] init];
        [self.navigationController pushViewController:message animated:YES];
    }
    
	
}

#pragma mark 接口
-(void)gethomepage:(NSString *)cityname CityId:(NSString *)cityid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:cityname forKey:@"cityname"];
	[params setObject:cityid forKey:@"cityid"];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dichp = [dic objectForKey:@"data"];
			 
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self tabviewheader:dichp];
			 [self.tableview reloadData];
			 NSArray *arrayhp = [dichp objectForKey:@"companylist"];
			 if ([arrayhp count]>10)
			 {
				 MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
				 self.tableview.mj_footer = footer;
			 }
			 
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [self.tableview.mj_header endRefreshing];
		 [self.tableview.mj_footer endRefreshing];
	 }];

}

-(void)getupdateversion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"terminaltype"] = @"ios";
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG015001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
     Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             NSDictionary *versioninfo = [[dic objectForKey:@"data"] objectForKey:@"versioninfo"];
             NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
             NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
             NSString *serversion = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"versionname"]];
             NSString *verswitch = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"switch"]];
             NSString *jumpurl = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"jumpurl"]];
             NSString *mustupgrade = [versioninfo objectForKey:@"mustupgrade"];
             if([verswitch isEqualToString:@"off"])
             {
                 return ;
             }
             else if([serversion isEqualToString:@"0.0"])
             {
                 return ;
             }
             else if([jumpurl length]==0)
             {
                 return ;
             }
             else if([mustupgrade isEqualToString:@"YES"])
             {
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     
                     NSString *postUrl = jumpurl;
                     
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
                     //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl]];
                     DLog(@"posturl===%@",postUrl);
                     
                 }];
                 
                 // Add the actions.
                 [alertController addAction:otherAction];
                 
                 [self presentViewController:alertController animated:YES completion:nil];
             }
             else if(![serversion isEqualToString:currentVersion])
             {
                 
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后再更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                     
                 }];
                 
                 UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     
                     NSString *postUrl = jumpurl;
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
                     DLog(@"posturl===%@",postUrl);
                     
                 }];
                 
                 // Add the actions.
                 [alertController addAction:cancelAction];
                 [alertController addAction:otherAction];
                 
                 [self presentViewController:alertController animated:YES completion:nil];
                 
             }
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
