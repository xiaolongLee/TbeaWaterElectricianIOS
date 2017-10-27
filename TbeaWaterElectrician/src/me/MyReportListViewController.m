//
//  MyReportListViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyReportListViewController.h"

@interface MyReportListViewController ()

@end

@implementation MyReportListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initview];
	
	self.title = @"我的举报";
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
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayheight = [[NSMutableArray alloc] init];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self getmyreportlist:@"1" Pagesize:@"10"];
	
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
//	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
//	tableview.mj_footer = footer;
	
//	UserLocationObject *location = [[UserLocationObject alloc] init];
//	[location getnowlocation];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

#pragma mark ActionDelegate
-(void)DGGetUserLocatioObject:(id)sender
{
	DLog(@"app.dile====%@",app.dili.dilicity);
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
	return [[arrayheight objectAtIndex:indexPath.row] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arrayheight count];
	
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
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-120-15, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	labeltitle.text = [dictemp objectForKey:@"title"];
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-135, labeltitle.frame.origin.y, 125, 20)];
	labeltime.textColor = ColorBlackGray;
	labeltime.font = FONTN(12.0f);
	labeltime.text = [dictemp objectForKey:@"appealtime"];
	labeltime.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labeltime];
	
	if([[dictemp objectForKey:@"replycontent"] length]>0)
	{
		CGSize size = [AddInterface getlablesize:[dictemp objectForKey:@"replycontent"] Fwidth:SCREEN_WIDTH-30 Fheight:200 Sfont:FONTN(14.0f)];
		
		UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(15, labeltitle.frame.origin.y+labeltitle.frame.size.height, SCREEN_WIDTH-30, size.height)];
		labelins.textColor = ColorBlackGray;
		labelins.font = FONTN(14.0f);
		labelins.numberOfLines = 0;
		labelins.text =  [dictemp objectForKey:@"replycontent"];
		[cell.contentView addSubview:labelins];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	MyReportDetailViewController *report = [[MyReportDetailViewController alloc] init];
	report.strreportid = [dictemp objectForKey:@"id"];
	[self.navigationController pushViewController:report animated:YES];
	
}

#pragma mark IBaction
-(void)loadNewData:(id)sender
{
	[self getmyreportlist:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self getmyreportlist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

#pragma mark 接口
-(void)getmyreportlist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001024000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"appeallist"];
			 [arrayheight removeAllObjects];
			 for(int i=0;i<[arraydata count];i++)
			 {
				 NSDictionary *dictmep = [arraydata objectAtIndex:i];
				 if([[dictmep objectForKey:@"replycontent"] length]==0)
				 {
					 [arrayheight addObject:[NSString stringWithFormat:@"%f",40.0f]];
				 }
				 else
				 {
					 CGSize size = [AddInterface getlablesize:[dictmep objectForKey:@"replycontent"] Fwidth:SCREEN_WIDTH-30 Fheight:200 Sfont:FONTN(14.0f)];
					 [arrayheight addObject:[NSString stringWithFormat:@"%f",size.height+35]];
				 }
			 }
			 
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
