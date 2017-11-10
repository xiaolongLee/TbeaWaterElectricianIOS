//
//  MyPageViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController ()
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end

@implementation MyPageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	UIImage* img=LOADIMAGE(@"me_seticon", @"png");
	UIView *contentViewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonsearch = [[UIButton alloc] initWithFrame:contentViewsearch.bounds];
	[buttonsearch setImage:img forState:UIControlStateNormal];
	buttonsearch.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[buttonsearch addTarget:self action: @selector(gotosetting:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewsearch addSubview:buttonsearch];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewsearch];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	// Do any additional setup after loading the view.
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	self.tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.tableview];
	
	[self setExtraCellLineHidden:self.tableview];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//去除导航栏下方的横线
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:ColorBlue];
//	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
	
	if([AddInterface judgeislogin])
	{
		[self getuserhomepage:@"TBEAENG005001001000"];
	}
//	else
//	{
//		[self addloginview];
//	}
	

	
	
}

-(void)tableviewheader:(NSDictionary *)dic
{
	
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	//类型选择
	UIImageView *imageviewtop2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	imageviewtop2.backgroundColor = ColorBlue;
	[viewheader addSubview:imageviewtop2];
	
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
	imageviewheader.layer.borderColor = [UIColor whiteColor].CGColor;
	imageviewheader.layer.borderWidth = 2.0f;
	imageviewheader.layer.cornerRadius = 30;
	imageviewheader.clipsToBounds = YES;
	imageviewheader.contentMode = UIViewContentModeScaleAspectFill;
	NSURL *urlstr = [NSURL URLWithString:[dic objectForKey:@"picture"]];
	[imageviewheader setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic2", @"png")];
	imageviewheader.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotopersoninfo:)];
	[imageviewheader addGestureRecognizer:singleTap];
	[viewheader addSubview:imageviewheader];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+10, imageviewheader.frame.origin.y, 120, 20)];
	labelname.text = [dic objectForKey:@"name"];
	labelname.textColor = [UIColor whiteColor];
	labelname.font = FONTMEDIUM(15.0f);
	[viewheader addSubview:labelname];
	
	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, 120, 20)];
	labeltel.text = [dic objectForKey:@"mobile"];
	labeltel.textColor = [UIColor whiteColor];
	labeltel.font = FONTN(14.0f);
	[viewheader addSubview:labeltel];
	
	UIButton *buttonedit = [[UIButton alloc] initWithFrame:CGRectMake(labeltel.frame.origin.x, labeltel.frame.origin.y+labeltel.frame.size.height+2, 100, 20)];
	buttonedit.layer.borderColor = [UIColor whiteColor].CGColor;
	buttonedit.layer.borderWidth = 1.0f;
	buttonedit.layer.cornerRadius = 2.0f;
	buttonedit.clipsToBounds = YES;
	buttonedit.backgroundColor = [UIColor clearColor];
	buttonedit.titleLabel.font = FONTN(14.0f);
	[buttonedit setTitle:@"编辑个人信息" forState:UIControlStateNormal];
	[buttonedit addTarget:self action:@selector(clickgotopersonview:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:buttonedit];
	
	
	self.tableview.tableHeaderView = viewheader;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
	viewbg.backgroundColor = [UIColor clearColor];
	
	
	return viewbg;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section==0)
		return 1;//[[self.dicresponse objectForKey:@"List"] count];
	else if(section==1)
		return 4;
	else if(section == 2)
		return 2;
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+10, 10, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 10, 90, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	switch (indexPath.section)
	{
		case 0:
			labeltitle.text = @"我的钱包";
			imageview.image = LOADIMAGE(@"me_我的钱包", @"png");
			imageview.frame = CGRectMake(10, 10, 19, 20);
			labelvalue.text = [NSString stringWithFormat:@"%@",[dicserviceinfo objectForKey:@"userscore"]];
			[cell.contentView addSubview:labelvalue];
			break;
		case 1:
			switch (indexPath.row)
			{
                case 0:
                    labeltitle.text = @"我的会议";
                    imageview.image = LOADIMAGE(@"我的会议", @"png");
                    imageview.frame = CGRectMake(10, 10, 17, 20);
                    break;
				case 1:
					labeltitle.text = @"我的订单";
					imageview.image = LOADIMAGE(@"me_我的订单", @"png");
					imageview.frame = CGRectMake(10, 10, 17, 20);
					labelvalue.text = @"查看全部订单";
					[cell.contentView addSubview:labelvalue];
					break;
				case 2:
					labeltitle.text = @"我的消息";
					imageview.image = LOADIMAGE(@"me_我的消息", @"png");
					imageview.frame = CGRectMake(10, 10, 20, 20);
					labelvalue.text = [NSString stringWithFormat:@"%@条未读",[dicserviceinfo objectForKey:@"newmessagenumber"]];
					[cell.contentView addSubview:labelvalue];
					break;
				case 3:
					labeltitle.text = @"我的收藏";
					imageview.image = LOADIMAGE(@"me_我的收藏", @"png");
					imageview.frame = CGRectMake(10, 12, 20, 16);
					labelvalue.text = [NSString stringWithFormat:@"%@",[dicserviceinfo objectForKey:@"savedatanumber"]];
					[cell.contentView addSubview:labelvalue];
					break;
				case 4:
					labeltitle.text = @"我的举报";
					imageview.image = LOADIMAGE(@"me_我的举报", @"png");
					imageview.frame = CGRectMake(10, 12, 20, 16);
					labelvalue.text = [NSString stringWithFormat:@"%@",[dicserviceinfo objectForKey:@"appealnumber"]];
					[cell.contentView addSubview:labelvalue];
					break;
					
			}
			break;
		case 2:
			switch (indexPath.row)
			{
				case 0:
					labeltitle.text = @"客服中心";
					imageview.image = LOADIMAGE(@"me_客服中心", @"png");
					break;
				case 1:
					labeltitle.text = @"关于我们";
					imageview.image = LOADIMAGE(@"me_关于优商", @"png");
					break;
			}
			break;
		case 3:
			labeltitle.text = @"退出";
			imageview.image = LOADIMAGE(@"me_关于优商", @"png");
			break;
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MyOrderViewController *myorder;
	MyWalletViewController *mywallet;
	MyMessageViewController *message;
	CustomQustionViewController *customservice;
	MyCollectionViewController *mycollection;
	WebViewContentViewController *webviewcontent;
	MyReportListViewController *reportlist;
    MyMettingListViewController *mettinglist;
	switch (indexPath.section)
	{
		case 0:
			mywallet = [[MyWalletViewController alloc] init];
			[self.navigationController pushViewController:mywallet animated:YES];
			break;
		case 1:
			switch (indexPath.row)
			{
                case 0:
                    mettinglist = [[MyMettingListViewController alloc] init];
                    [self.navigationController pushViewController:mettinglist animated:YES];
                    break;
				case 1:
					myorder = [[MyOrderViewController alloc] init];
					[self.navigationController pushViewController:myorder animated:YES];
					break;
				case 2:
					message = [[MyMessageViewController alloc] init];
					[self.navigationController pushViewController:message animated:YES];
					break;
				case 3:
					mycollection = [[MyCollectionViewController alloc] init];
					[self.navigationController pushViewController:mycollection animated:YES];
					break;
				case 4:
					reportlist = [[MyReportListViewController alloc] init];
					[self.navigationController pushViewController:reportlist animated:YES];
					break;
			}
			break;
		case 2:
			switch (indexPath.row)
			{
				case 0:
					customservice = [[CustomQustionViewController alloc] init];
					[self.navigationController pushViewController:customservice animated:YES];
					break;
				case 1:
					webviewcontent = [[WebViewContentViewController alloc] init];
					webviewcontent.strtitle = @"关于优商";
					webviewcontent.strnewsurl = @"http://www.u-shang.net/enginterface/index.php/Apph5/about";
					[self.navigationController pushViewController:webviewcontent animated:YES];
					
					break;
				default:
					break;
			}
			break;
	}
}



#pragma mark IBaction
-(void)clickgotopersonview:(id)sender
{
	MyPersonViewController *myperson = [[MyPersonViewController alloc] init];
	[self.navigationController pushViewController:myperson animated:YES];
}

-(void)gotopersoninfo:(UIGestureRecognizer*)sender
{
	MyPersonViewController *myperson = [[MyPersonViewController alloc] init];
	[self.navigationController pushViewController:myperson animated:YES];
}

-(void)addloginview
{
	LoginViewController *loginview = [[LoginViewController alloc] init];
	loginview.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:loginview];
	[self.navigationController presentViewController:nctl animated:NO completion:nil];
	
}

-(void)gotosetting:(id)sender
{
	MySettingViewController *mysetting = [[MySettingViewController alloc] init];
	[self.navigationController pushViewController:mysetting animated:YES];
}

-(void)photoTappednews:(UIGestureRecognizer*)sender
{
//	UIView *viewtemp = sender.view;
//	int tagnow = (int)viewtemp.tag-6890;
	
}

#pragma mark 接口
-(void)getuserhomepage:(NSString *)rcode
{
	
	[RequestInterface doGetJsonWithParametersNoAn:nil App:app RequestCode:rcode ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"personinfo"];
			 dicserviceinfo = [[dic objectForKey:@"data"] objectForKey:@"serviceinfo"];
			 NSMutableDictionary *dicmutable = [[NSMutableDictionary alloc] initWithDictionary:dicuserinfo];
			 [dicmutable writeToFile:UserMessage atomically:NO];
			 app.userinfo.userid = [dicmutable objectForKey:@"id"];
			 app.userinfo.useridentified = [dicmutable objectForKey:@"whetheridentifiedid"];
			 
			 [self tableviewheader:dicuserinfo];
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
