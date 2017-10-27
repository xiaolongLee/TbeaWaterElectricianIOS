//
//  EvaluationCommodityListViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "EvaluationCommodityListViewController.h"

@interface EvaluationCommodityListViewController ()

@end

@implementation EvaluationCommodityListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initview];
	
	self.title = @"评价中心";
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
	arraydata = [self.diccommdity objectForKey:@"commoditylist"];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.delegate = self;
	tableview.dataSource = self;
	tableview.backgroundColor = [UIColor whiteColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	
//	UserLocationObject *location = [[UserLocationObject alloc] init];
//	[location getnowlocation];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
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
	return 80;
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
	EvaluationHeaderView *evaluation = [[EvaluationHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) Dic:dictemp FromFlag:@"2"];
	evaluation.delegate1 = self;
	[cell.contentView addSubview:evaluation];
		
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	NearByGoodsDetailViewController *goodsdetail = [[NearByGoodsDetailViewController alloc] init];
	goodsdetail.strproductid = [dictemp objectForKey:@"commodityid"];
	goodsdetail.strdistrid = [dictemp objectForKey:@"companyid"];
	goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
	
	[self.navigationController pushViewController:goodsdetail animated:YES];
	
}

#pragma markActionDelegate
-(void)DGgotoEvaluationView:(NSDictionary *)sender
{
	EvaluationViewController *evaluationlist = [[EvaluationViewController alloc] init];
	evaluationlist.diccommdity = sender;
	[self.navigationController pushViewController:evaluationlist animated:YES];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
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
