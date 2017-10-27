//
//  MyTiXianHistoryListViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyTiXianHistoryListViewController.h"

@interface MyTiXianHistoryListViewController ()

@end

@implementation MyTiXianHistoryListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"提现记录";
	
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self gettixianlist:@"1" PageSize:@"10"];
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
	tableview.mj_footer = footer;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除全部记录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
			
		}];
		
		UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
			[self deletehistorylist:[dictemp objectForKey:@"id"] IndexPaht:indexPath];
		}];
		
		// Add the actions.
		[alertController addAction:cancelAction];
		[alertController addAction:otherAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
		
		
		
	}
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"删除";
}

#pragma mark IBAction
-(void)loadNewData:(id)sender
{
	[self gettixianlist:@"1" PageSize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self gettixianlist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
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
	return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	//NSArray *arrayhp = [dichp objectForKey:@"companylist"];
	return [arraydata count];
	
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
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	[cell.contentView addSubview:[self tableviewcell:dictemp]];
	
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	MyTiXianDoneViewController *tixiandone =  [[MyTiXianDoneViewController alloc] init];
	tixiandone.dicfrom = dictemp;
	tixiandone.fromflag = @"2";
	[self.navigationController pushViewController:tixiandone animated:YES];
	
	
}




-(UIView *)tableviewcell:(NSDictionary *)sender
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 109)];
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 150, 20)];
	labelname.text = [sender objectForKey:@"money"];
	labelname.font = FONTB(18.0f);
	labelname.textColor = ColorBlackdeep;
	[view addSubview:labelname];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-150, labelname.frame.origin.y,140, 20)];
	labeltime.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"takemoneytime"]];
	labeltime.font = FONTHelve(14.0f);
	labeltime.textAlignment = NSTextAlignmentRight;
	labeltime.textColor =  ColorBlackGray;
	[view addSubview:labeltime];
	

	
	return view;
}

#pragma mark 接口
-(void)gettixianlist:(NSString *)page PageSize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001120000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneylist"];
			 tableview.delegate = self;
			 tableview.dataSource  = self;
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

-(void)deletehistorylist:(NSString *)sid IndexPaht:(NSIndexPath *)indexpath
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:sid forKey:@"takemoneyid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001130000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [arraydata removeObjectAtIndex:indexpath.row];
			 [tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationFade];
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
