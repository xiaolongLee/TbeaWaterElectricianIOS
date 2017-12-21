//
//  MySettingViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "MySettingViewController.h"

@interface MySettingViewController ()

@end

@implementation MySettingViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"设置";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
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
	return 5;
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 10, 90, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	

	float floatsize ;
//    float floatdocment ;
//    float floattmp ;
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"个人消息";
			break;
		case 1:
			floatsize = [AddInterface folderSizeAtPath:Cache_path];
//			floatdocment = [AddInterface folderSizeAtPath:DOCUMENTS_FOLDER];
//			floattmp = [AddInterface folderSizeAtPath:Tmp_path];
			labeltitle.text = @"缓存清理";
			labelvalue.text =[NSString stringWithFormat:@"%0.1f M",floatsize-7.7>0?floatsize-7.7:0.1];
			[cell.contentView addSubview:labelvalue];
			break;
		case 2:
			labeltitle.text = @"帐户安全";
			
			break;
		case 3:
			labeltitle.text = @"实名认证";
			if([app.userinfo.useridentified isEqualToString:@"notidentify"])
			{
				labelvalue.text = @"未认证";
				
			}
			else if([app.userinfo.useridentified isEqualToString:@"identifying"])
			{
				labelvalue.text = @"认证中";
			}
            else if([app.userinfo.useridentified isEqualToString:@"identifyfailed"])
            {
                labelvalue.text = @"认证失败";
            }
			else
			{
				labelvalue.text = @"已认证";
			}
			[cell.contentView addSubview:labelvalue];
			break;
		case 4:
			
			labeltitle.text = @"退出";
			break;
			

	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MyPersonViewController *myperson;
	MyAccountSafeViewController *myaccount;
	CertificationViewController *certification;
	CertificationInfoViewController *cerinfo;
	UINavigationController *nctl;
    AuthBusinessViewController *authbusiness;
	switch (indexPath.row)
	{
		case 0:
			myperson = [[MyPersonViewController alloc] init];
			[self.navigationController pushViewController:myperson animated:YES];
			break;
		case 1:
			[self clickdeletebroke:nil];
			break;
		case 2:
			myaccount = [[MyAccountSafeViewController alloc] init];
			[self.navigationController pushViewController:myaccount animated:YES];
			break;
		case 3:
			if([app.userinfo.useridentified isEqualToString:@"notidentify"])
			{
				certification = [[CertificationViewController alloc] init];
				nctl = [[UINavigationController alloc] initWithRootViewController:certification];
				certification.fromflag = @"2";
				[self.navigationController presentViewController:nctl animated:YES completion:nil];
			}
			else
			{
                authbusiness = [[AuthBusinessViewController alloc] init];
                [self.navigationController pushViewController:authbusiness animated:YES];
//                cerinfo = [[CertificationInfoViewController alloc] init];
//                [self.navigationController pushViewController:cerinfo animated:YES];
			}
			break;
		case 4:
			[self removeselectitem:nil];
			break;
	}
}

-(void)clickdeletebroke:(id)sender
{
	
	float floatsize = [AddInterface folderSizeAtPath:Cache_path];
//	float floatdocment = [AddInterface folderSizeAtPath:DOCUMENTS_FOLDER];
//	float floattmp = [AddInterface folderSizeAtPath:Tmp_path];
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你需要清除的缓存大小约为%0.1f M",floatsize-7.7>0?floatsize-7.7:0.1] message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[AddInterface clearCache:Cache_path];
		[AddInterface clearCache:DOCUMENTS_FOLDER];
		[AddInterface clearCache:Tmp_path];
		[MBProgressHUD showError:@"已清除" toView:self.view];
	}];
	
	// Add the actions.
	[alertController addAction:cancelAction];
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

-(void)removeselectitem:(id)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要退出吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		
		NSFileManager *filemanger = [NSFileManager defaultManager];
		[filemanger removeItemAtPath:UserMessage error:nil];
		[self.navigationController popViewControllerAnimated:NO];
	}];
	
	// Add the actions.
	[alertController addAction:cancelAction];
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
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
