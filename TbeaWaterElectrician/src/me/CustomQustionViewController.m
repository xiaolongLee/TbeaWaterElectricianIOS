//
//  CustomQustionViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CustomQustionViewController.h"

@interface CustomQustionViewController ()

@end

@implementation CustomQustionViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//去除导航栏下方的横线
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:ColorBlue];
	//	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self initview];
	
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
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
	self.title = @"客服中心";
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initheader];
	[self getcustomquest:@"1" Pagesize:@"10"];
	
//	[self getmyincome:@"1" Pagesize:@"10"];
	
}

-(void)initheader
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	viewheader.backgroundColor = ColorBlue;
	
	
	
	UIButton *buttontel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttontel.titleLabel.font = FONTN(15.0f);
	[buttontel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttontel setTitle:@"0838-2802916" forState:UIControlStateNormal];
	buttontel.layer.cornerRadius = 15.0f;
	buttontel.clipsToBounds = YES;
	buttontel.layer.borderWidth = 1.0f;
	buttontel.layer.borderColor = [UIColor whiteColor].CGColor;
	[buttontel addTarget:self action:@selector(customtel:) forControlEvents:UIControlEventTouchUpInside];
	buttontel.frame = CGRectMake((SCREEN_WIDTH-150)/2, 20, 150, 30);
	[buttontel setBackgroundColor:COLORNOW(105, 173, 225)];
	[viewheader addSubview:buttontel];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(0, buttontel.frame.origin.y+buttontel.frame.size.height+20, SCREEN_WIDTH, 30)];
	labelins.textColor = ColorBlackdeep;
	labelins.backgroundColor = Colorgray;
	labelins.font = FONTN(15.0f);
	labelins.text = @"   常见问题";
	[viewheader addSubview:labelins];
	
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewheader.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
	imageviewline.backgroundColor = ColorBlackVeryGray;
	[viewheader addSubview:imageviewline];
	
	tableview.tableHeaderView = viewheader;
}

#pragma mark IBaction
-(void)customtel:(id)sender
{
	UIButton *button =(UIButton *)sender;
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[button currentTitle]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tabbleview代理
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	
	UIView *view = [UIView new];
	
	view.backgroundColor = [UIColor clearColor];
	
	[tableView setTableFooterView:view];
	
	
}

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
	return 40;
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
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
	labelname.textColor = ColorBlackdeep;
	labelname.font = FONTN(15.0f);
	labelname.text = [dictemp objectForKey:@"question"];
	[cell.contentView addSubview:labelname];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
//	http://www.u-shang.net/enginterface/index.php/Apph5/userhelp?questionid=xxx
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
	webviewcontent.strtitle = [dictemp objectForKey:@"name"];
	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/userhelp?questionid=";
	str = [NSString stringWithFormat:@"%@%@",str,[dictemp objectForKey:@"id"]];
	webviewcontent.strnewsurl = str;
	[self.navigationController pushViewController:webviewcontent animated:YES];
}

#pragma mark 接口
-(void)getcustomquest:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
//	[params setObject:page forKey:@"page"];
//	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001014000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"questionlist"];
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
