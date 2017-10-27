//
//  ModifyPwdViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController

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
	self.title = @"更改登录密码";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
	[btnext setTitle:@"完成" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	[btnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+10, 7, 200, 26)];
	textfield1.layer.cornerRadius = 2.0f;
	textfield1.clipsToBounds = YES;
	textfield1.delegate = self;
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.font = FONTN(14.0f);
	textfield1.secureTextEntry = YES;

	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"老密码";
			textfield1.textColor = ColorBlackGray;
			textfield1.placeholder = @"请输入当前登录密码";
			textfield1.tag = EnModifyOldPwdTextfieldTag;
			[cell.contentView addSubview:textfield1];
			break;
		case 1:
			labeltitle.text = @"新密码";
			textfield1.textColor = ColorBlackdeep;
			textfield1.placeholder = @"请设置新密码";
			textfield1.tag = EnModifyNewPwdTextfieldTag1;
			[cell.contentView addSubview:textfield1];
			break;
		case 2:
			labeltitle.text = @"确认密码";
			textfield1.textColor = ColorBlackdeep;
			textfield1.placeholder = @"请设置新密码";
			textfield1.tag = EnModifyNewPwdTextfieldTag2;
			[cell.contentView addSubview:textfield1];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row)
	{
			
	}
}

#pragma mark IBAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)gotonext:(id)sender
{
	UITextField *textfield1 = [tableview viewWithTag:EnModifyOldPwdTextfieldTag];
	UITextField *textfield2 = [tableview viewWithTag:EnModifyNewPwdTextfieldTag1];
	UITextField *textfield3 = [tableview viewWithTag:EnModifyNewPwdTextfieldTag2];
	if([textfield1.text length]==0||[textfield2.text length]==0||[textfield3.text length]==0)
	{
		[MBProgressHUD showError:@"请填入密码" toView:app.window];
	}
	else if(![textfield2.text isEqualToString:textfield3.text])
	{
		[MBProgressHUD showError:@"请两次输入的密码不同" toView:app.window];
	}
	else if(((int)[textfield2.text length]<6)||((int)[textfield2.text length]>10))
	{
		[MBProgressHUD showError:@"密码请确定输入6-10位" toView:self.view];
	}
	else
	{
		[self requestmodifypwd:[AddInterface md5:textfield1.text] NewPwd:[AddInterface md5:textfield2.text]];
	}
}


#pragma mark 接口
-(void)requestmodifypwd:(NSString *)oldpwd NewPwd:(NSString *)newpwd
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:oldpwd forKey:@"olduserpas"];
	[params setObject:newpwd forKey:@"newuserpas"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001007000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 ModifyPwdDoneViewController *modifydone = [[ModifyPwdDoneViewController alloc] init];
			 [self.navigationController pushViewController:modifydone animated:YES];
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
