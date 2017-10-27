//
//  ModifyBindingNewTelViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ModifyBindingNewTelViewController.h"

@interface ModifyBindingNewTelViewController ()

@end

@implementation ModifyBindingNewTelViewController

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
	self.title = @"更改绑定手机号";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initfootview];
	getyanzhengcodeflag = 0;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewbg.backgroundColor = [UIColor clearColor];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 20)];
	labeltitle.text = @"绑定新手机号码";
	labeltitle.font = FONTN(14.0f);
	labeltitle.adjustsFontSizeToFitWidth = YES;
	labeltitle.textColor = ColorBlackdeep;
	[viewbg addSubview:labeltitle];
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
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 55, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+10, 7, 120, 26)];
	textfield1.layer.cornerRadius = 2.0f;
	textfield1.clipsToBounds = YES;
	textfield1.delegate = self;
	UIView *leftview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield1.leftView = leftview1;
	textfield1.leftViewMode = UITextFieldViewModeAlways;
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.font = FONTN(14.0f);
	
	UIButton *buttonyanzhengcode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonyanzhengcode.titleLabel.font = FONTN(13.0f);
	[buttonyanzhengcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonyanzhengcode setTitle:@"获取验证码" forState:UIControlStateNormal];
	buttonyanzhengcode.layer.cornerRadius = 4.0f;
	buttonyanzhengcode.clipsToBounds = YES;
	buttonyanzhengcode.tag = EnModifyBindingNewGetCodeBtTag;
	buttonyanzhengcode.layer.borderWidth = 1.0f;
	buttonyanzhengcode.layer.borderColor = [UIColor whiteColor].CGColor;
	[buttonyanzhengcode addTarget:self action:@selector(getphonecode:) forControlEvents:UIControlEventTouchUpInside];
	buttonyanzhengcode.frame = CGRectMake(SCREEN_WIDTH-100, 5, 90, 30);
	[buttonyanzhengcode setBackgroundColor:COLORNOW(27, 130, 210)];
	
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"手机号";
			textfield1.textColor = ColorBlackdeep;
			textfield1.placeholder = @"输入您的新号码";
			textfield1.tag = EnModifyBindingNewTelTextfieldTag;
			[cell.contentView addSubview:textfield1];
			[cell.contentView addSubview:buttonyanzhengcode];
			break;
		case 1:
			labeltitle.text = @"验证码";
			textfield1.textColor = ColorBlackdeep;
			textfield1.enabled = YES;
			textfield1.tag = EnModifyBindingNewCodeTextfieldTag;
			textfield1.placeholder = @"填写验证码";
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
-(void)returnkeytextfield
{
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnModifyBindingNewTelTextfieldTag];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnModifyBindingNewCodeTextfieldTag];
	[textfield resignFirstResponder];
	[textfield1 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)getphonecode:(id)sender
{
	if(getyanzhengcodeflag == 0)
	{
		UITextField *textfield1 = [self.view viewWithTag:EnModifyBindingNewTelTextfieldTag];
		
		
		if([[textfield1 text] length]==0)
		{
			[MBProgressHUD showError:@"请填写电话" toView:self.view];
		}
		else if(![AddInterface isValidateMobile:textfield1.text])
		{
			[MBProgressHUD showError:@"请填写正确格式的电话号码" toView:self.view];
		}
		else
		{
			[self returnkeytextfield];
			getyanzhengcodeflag = 1;
			[self clickgetcode];
			timerone= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updasecond:) userInfo:nil repeats:YES];
		}
	}
	
}

-(void)updasecond:(id)sender
{
	UIButton *button = (UIButton *)[self.view viewWithTag:EnModifyBindingNewGetCodeBtTag];
	NSString *strtemp = [button currentTitle];
	if([strtemp length]== 5)
	{
		[button setTitle:@"重新获取(60)" forState:UIControlStateNormal];
	}
	else
	{
		NSString *strsecond = [strtemp substringFromIndex:5];
		strsecond = [strsecond substringToIndex:[strsecond length]-1];
		int second = [strsecond intValue];
		[button setTitle:[NSString stringWithFormat:@"重新获取(%d)",second-1] forState:UIControlStateNormal];
		if(second > 1)
		{
			
			button.enabled = NO;
		}
		else
		{
			getyanzhengcodeflag = 0;
			[button setTitle:@"获取验证码" forState:UIControlStateNormal];
			button.enabled = YES;
			[timerone invalidate];
			timerone = nil;
		}
	}
}

-(void)gotonext:(id)sender
{
	UITextField *textfield1 = [self.view viewWithTag:EnModifyBindingNewTelTextfieldTag];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:EnModifyBindingNewCodeTextfieldTag];
	if([textfield1.text length]==0)
	{
		[MBProgressHUD showError:@"请填写电话号码" toView:app.window];
	}
	else if([textfield2.text length] == 0)
	{
		[MBProgressHUD showError:@"请填写验证码" toView:app.window];
	}
	else
	{
		[self yanzhengnewtel:textfield1.text Code:textfield2.text];
	}

}

#pragma mark 接口
-(void)clickgetcode
{
	UITextField *textfield1 = [self.view viewWithTag:EnModifyBindingNewTelTextfieldTag];
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:textfield1.text forKey:@"mobile"];
	[params setObject:@"TBEAENG005001005001" forKey:@"servicecode"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	{
	 
	}
	Success:^(NSDictionary *dic)
	{
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			[MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	 
	}];
}

//修改新电话号码
-(void)yanzhengnewtel:(NSString *)tel Code:(NSString *)code
{
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:tel forKey:@"newmobile"];
	[params setObject:code forKey:@"verifycode"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001005001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 ModifyBindingDoneViewController *binddone = [[ModifyBindingDoneViewController alloc] init];
			 [self.navigationController pushViewController:binddone animated:YES];
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
