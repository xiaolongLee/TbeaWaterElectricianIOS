//
//  MyAccountSafeViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "MyAccountSafeViewController.h"

@interface MyAccountSafeViewController ()

@end

@implementation MyAccountSafeViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
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
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"帐户安全";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self getnowaccountinfo];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewbg.backgroundColor = [UIColor clearColor];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 120, 20)];
	labeltitle.text = @"当前帐户风险等级:";
	labeltitle.font = FONTN(14.0f);
	labeltitle.textColor = ColorBlackdeep;
	[viewbg addSubview:labeltitle];
	
	UILabel *labellevel = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+3, 10, 20, 20)];
	labellevel.text = [dicuseraccount objectForKey:@"risklevel"];;
	labellevel.font = FONTN(14.0f);
	labellevel.textColor = Colorredcolor;
	[viewbg addSubview:labellevel];
	
	
	return viewbg;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 120, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"绑定手机";
			labelvalue.text = [dicuseraccount objectForKey:@"mobilenumber"];
			[cell.contentView addSubview:labelvalue];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 1:
			labeltitle.text = @"登录密码";
			labelvalue.text = @"修改";
			[cell.contentView addSubview:labelvalue];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 2:
			labeltitle.text = @"社交帐号绑定";
			labelvalue.text = @"绑定/解绑";
			[cell.contentView addSubview:labelvalue];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ModifyBindingTelViewController *modifybinding;
	ModifyPwdViewController *modifypwd;
	switch (indexPath.row)
	{
		case 0:
			modifybinding = [[ModifyBindingTelViewController alloc] init];
			modifybinding.strtel = [dicuseraccount objectForKey:@"mobilenumber"];
			[self.navigationController pushViewController:modifybinding animated:YES];
			break;
		case 1:
			modifypwd = [[ModifyPwdViewController alloc] init];
			[self.navigationController pushViewController:modifypwd animated:YES];
			break;
	}
}


#pragma mark 接口
-(void)getnowaccountinfo
{

	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001015000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicuseraccount = [[dic objectForKey:@"data"] objectForKey:@"useraccountinfo"];
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
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
