//
//  MyTiXianDoneViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyTiXianDoneViewController.h"

@interface MyTiXianDoneViewController ()

@end

@implementation MyTiXianDoneViewController
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//去除导航栏下方的横线
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:ColorBlue];
	//	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}


-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
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
	
	if([self.fromflag isEqualToString:@"1"])
	{
	UIView *contentviewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentviewright.bounds];
	[buttonright setTitle:@"历史记录" forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTN(15.0f);
	[buttonright addTarget:self action: @selector(gototixianlist:) forControlEvents: UIControlEventTouchUpInside];
	[contentviewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentviewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	}
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"提现成功";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initheaderview];
	
	if([self.fromflag isEqualToString:@"1"])
		[self initfootview];
	
}

-(void)initheaderview
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
	viewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = viewheader;
	
	UIImageView *imageviewdone = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 30, 80, 80)];
	imageviewdone.image = LOADIMAGE(@"me_shopcardone", @"png");
	[viewheader addSubview:imageviewdone];
	
	//
	UILabel *labeldone = [[UILabel alloc] initWithFrame:CGRectMake(10, imageviewdone.frame.origin.y+imageviewdone.frame.size.height+10, SCREEN_WIDTH-20, 20)];
	labeldone.textColor = ColorBlackdeep;
	labeldone.font = FONTN(15.0f);
	labeldone.text = @"提现成功";
	labeldone.textAlignment = NSTextAlignmentCenter;
	[viewheader addSubview:labeldone];
	
	UILabel *labelordernumber = [[UILabel alloc] initWithFrame:CGRectMake(labeldone.frame.origin.x, labeldone.frame.origin.y+labeldone.frame.size.height+5, SCREEN_WIDTH-20, 20)];
	labelordernumber.textColor = ColorBlackGray;
	labelordernumber.font = FONTN(13.0f);
	labelordernumber.text = @"你的提现二维码已使用，请及时换取现金";//[NSString stringWithFormat:@"订单编号:%@",self.strorderid];
	labelordernumber.textAlignment = NSTextAlignmentCenter;
	[viewheader addSubview:labelordernumber];
	
//	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labeldone.frame.origin.x, labelordernumber.frame.origin.y+labelordernumber.frame.size.height+10, SCREEN_WIDTH-20, 20)];
//	labelins.textColor = ColorBlackGray;
//	labelins.font = FONTN(13.0f);
//	labelins.text = self.strorderins;
//	labelins.textAlignment = NSTextAlignmentCenter;
//	[viewheader addSubview:labelins];
	
}

-(void)initfootview
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
	viewfoot.backgroundColor = [UIColor clearColor];
	
	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
	btnext.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 35);
	btnext.backgroundColor = COLORNOW(27, 130, 210);
	[btnext setTitle:@"确认" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	[btnext addTarget:self action:@selector(tixiandone:) forControlEvents:UIControlEventTouchUpInside];
	btnext.layer.cornerRadius= 2.0f;
	btnext.clipsToBounds = YES;
	[viewfoot addSubview:btnext];
	
	tableview.tableFooterView = viewfoot;
}

#pragma mark IBaction
-(void)gototixianlist:(id)sender
{
	MyTiXianHistoryListViewController *mytixian = [[MyTiXianHistoryListViewController alloc] init];
	[self.navigationController pushViewController:mytixian animated:YES];
}

-(void)tixiandone:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark tableview delegate
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
	return 3;
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200, 10, 190, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"提现时间";
			labelvalue.text = [NSString stringWithFormat:@"%@",[self.dicfrom objectForKey:@"takemoneytime"]];
			[cell.contentView addSubview:labelvalue];
			break;
		case 1:
			labeltitle.text = @"提现单位";
			labelvalue.text = [NSString stringWithFormat:@"%@",[self.dicfrom objectForKey:@"distributorname"]];
			[cell.contentView addSubview:labelvalue];
			break;
		case 2:
			labeltitle.text = @"提现金额";
			labelvalue.text = [NSString stringWithFormat:@"￥%@",[self.dicfrom objectForKey:@"money"]];
			[cell.contentView addSubview:labelvalue];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
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
