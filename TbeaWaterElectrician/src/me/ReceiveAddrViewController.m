//
//  ReceiveAddrViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ReceiveAddrViewController.h"

@interface ReceiveAddrViewController ()

@end

@implementation ReceiveAddrViewController
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self requestreceiveaddr];
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
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
	self.title = @"收货地址管理";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initfootview];
}

-(void)initfootview
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
	viewfoot.backgroundColor = [UIColor clearColor];
	
	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
	btnext.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 35);
	btnext.backgroundColor = COLORNOW(27, 130, 210);
	[btnext setTitle:@"新增收货地址" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	[btnext addTarget:self action:@selector(AddAddress:) forControlEvents:UIControlEventTouchUpInside];
	btnext.layer.cornerRadius= 2.0f;
	btnext.clipsToBounds = YES;
	[viewfoot addSubview:btnext];
	
	tableview.tableFooterView = viewfoot;
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
	return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
	
	cell.backgroundColor = [UIColor clearColor];
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 60)];
	imageview.backgroundColor = [UIColor whiteColor];
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 60, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.text = [dictemp objectForKey:@"contactperson"];
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+5, labeltitle.frame.origin.y, 155, 20)];
	labeltel.textColor = ColorBlackdeep;
	labeltel.text = [dictemp objectForKey:@"contactmobile"];
	labeltel.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltel];
	
	float noworiginx = labeltitle.frame.origin.x;
	if([[dictemp objectForKey:@"isdefault"] intValue]==1)
	{
		UILabel *labeldefault = [[UILabel alloc] initWithFrame:CGRectMake(noworiginx, labeltitle.frame.origin.y+labeltitle.frame.size.height+4, 35, 16)];
		labeldefault.cornerRadius = 3.0f;
		labeldefault.clipsToBounds = YES;
		labeldefault.textColor = [UIColor whiteColor];
		labeldefault.backgroundColor = Colorredcolor;
		labeldefault.text = @"默认";
		labeldefault.textAlignment = NSTextAlignmentCenter;
		labeldefault.font = FONTN(13.0f);
		[cell.contentView addSubview:labeldefault];
		noworiginx = labeldefault.frame.size.width+noworiginx+5;
	}
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(noworiginx, labeltitle.frame.origin.y+labeltitle.frame.size.height+2, SCREEN_WIDTH-80, 20)];
	labeladdr.textColor = ColorBlackGray;
	labeladdr.text = [dictemp objectForKey:@"address"];
	labeladdr.font = FONTN(14.0f);
	[cell.contentView addSubview:labeladdr];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([self.fromaddr isEqualToString:@"1"])//地址管理进来 可以进入修改地址
	{
		NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
		ReceiveAddNewAddrViewController *addr = [[ReceiveAddNewAddrViewController alloc] init];
		addr.straddrid = [dictemp objectForKey:@"id"];
		[self.navigationController pushViewController:addr animated:YES];
	}
	else if([self.fromaddr isEqualToString:@"2"]) //选择发货地址
	{
		if([self.delegate1 respondsToSelector:@selector(DGSelectOneAddr:)])
		{
			NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
			[self.delegate1	DGSelectOneAddr:dictemp];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
	else if([self.fromaddr isEqualToString:@"3"])  //商品网页过来的
	{
		if([self.delegate1 respondsToSelector:@selector(DGSelectCommdityAddr:)])
		{
			NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
			[self.delegate1	DGSelectCommdityAddr:dictemp];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
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
		NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
		[self requestremoveaddr:[dictemp objectForKey:@"id"] IndexPath:indexPath];
		

	}
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"删除";
}


#pragma mark IBAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)AddAddress:(id)sender
{
	ReceiveAddNewAddrViewController *addr = [[ReceiveAddNewAddrViewController alloc] init];
	addr.straddrid = @"";
	[self.navigationController pushViewController:addr animated:YES];
}


#pragma mark 接口
-(void)requestreceiveaddr
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];

	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001003000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"addresslist"]];
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

-(void)requestremoveaddr:(NSString *)removeid IndexPath:(NSIndexPath *)indexpath
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:removeid forKey:@"receiveaddrid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001004001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
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
