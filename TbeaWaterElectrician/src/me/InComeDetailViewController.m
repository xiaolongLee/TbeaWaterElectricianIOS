//
//  InComeDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "InComeDetailViewController.h"

@interface InComeDetailViewController ()

@end

@implementation InComeDetailViewController

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
	self.title = @"收支明细";
	
	if([self.fromflag isEqualToString:@"1"])
	{
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
	else
	{
		UIImageView *imageviewtopblue = [[UIImageView alloc] init];
		imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
		imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
		[self.view addSubview:imageviewtopblue];
		
		//扫码记录
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
		labeltitle.text = @"收支明细 ";
		labeltitle.font = FONTN(17.0f);
		labeltitle.textAlignment = NSTextAlignmentCenter;
		labeltitle.textColor = [UIColor whiteColor];
		[self.view addSubview:labeltitle];
		
		//返回按钮
		UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
		btreturn.frame = CGRectMake(10, 22, 40, 40);
		[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
		[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
		[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
		[self.view addSubview:btreturn];
	}
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	if([self.fromflag isEqualToString:@"1"])
	{
		tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
	}
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self getincomelist:@"1" PageSize:@"10"];
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
	
}

////先要设Cell可编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return YES;
//}
////定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return UITableViewCellEditingStyleDelete;
//}
////进入编辑模式，按下出现的编辑按钮后,进行删除操作
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	if (editingStyle == UITableViewCellEditingStyleDelete) {
//		NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
//		[self deletescanlist:[dictemp objectForKey:@"id"] IndexPaht:indexPath];
//		
//	}
//}
////修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return @"删除";
//}

#pragma mark IBAction
-(void)loadNewData:(id)sender
{
	[self getincomelist:@"1" PageSize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self getincomelist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clearalldata
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除全部记录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[arraydata removeAllObjects];
		[tableview reloadData];
	}];
	
	// Add the actions.
	[alertController addAction:cancelAction];
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
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
	return 60;
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
		cell.accessoryType = UITableViewCellAccessoryNone;
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
	
	if([[dictemp objectForKey:@"eventid"] isEqualToString:@"ordercommodity"])
	{
		
	}
	else if([[dictemp objectForKey:@"eventid"] isEqualToString:@"takemoney"])
	{
		
	}
	else if([[dictemp objectForKey:@"eventid"] isEqualToString:@"appealaward"])
	{
		
	}
	

}


-(UIView *)tableviewcell:(NSDictionary *)sender
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109)];
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width-70, 20)];
	labelname.text = [sender objectForKey:@"event"];
	labelname.font = FONTHelve(15.0f);
	if([[sender objectForKey:@"eventid"] isEqualToString:@"exchangecommodity"])
	{
		labelname.textColor = ColorBlackdeep;
	}
	else if([[sender objectForKey:@"eventid"] isEqualToString:@"ordercommodity"])
	{
		labelname.textColor = ColorBlackdeep;
	}
	else if([[sender objectForKey:@"eventid"] isEqualToString:@"takemoney"])
	{
		labelname.textColor = ColorBlue4;
	}
	else if([[sender objectForKey:@"eventid"] isEqualToString:@"givemoneyforscore"])
	{
		labelname.textColor = ColorBlue4;
	}
	else if([[sender objectForKey:@"eventid"] isEqualToString:@"appealaward"])
	{
		labelname.textColor = ColorOrange;
	}
	
	[view addSubview:labelname];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-100, labelname.frame.origin.y, 90, 20)];
	labelprice.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"thisvalue"]];
	labelprice.font = FONTHelve(15.0f);
	labelprice.textAlignment = NSTextAlignmentRight;
	labelprice.textColor =  Colorredcolor;
	if([[sender objectForKey:@"eventid"] isEqualToString:@"exchangecommodity"])
	{
		labelprice.textColor = ColorGreen;
	}
	
	[view addSubview:labelprice];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+5, 145, 20)];
	labeltime.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"time"]];
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = ColorBlackGray;
	[view addSubview:labeltime];
	
	UILabel *labelstatus = [[UILabel alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x, labeltime.frame.origin.y, labelprice.frame.size.width, 20)];
	labelstatus.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"currenttotlemoney"]];
	labelstatus.font = FONTN(14.0f);
	labelstatus.textAlignment = NSTextAlignmentRight;
	labelstatus.textColor = ColorBlackGray;
	[view addSubview:labelstatus];
	
	return view;
}

#pragma mark 接口
-(void)getincomelist:(NSString *)page PageSize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001006001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"receivelist"];
			 tableview.delegate = self;
			 tableview.dataSource  = self;
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

-(void)deletescanlist:(NSString *)sid IndexPaht:(NSIndexPath *)indexpath
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:sid forKey:@"scancodeid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG006001004000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
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
