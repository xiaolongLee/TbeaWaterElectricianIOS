//
//  ModifyPersonInfoViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ModifyPersonInfoViewController.h"

@interface ModifyPersonInfoViewController ()

@end

@implementation ModifyPersonInfoViewController

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
    self.title = [NSString stringWithFormat:@"更改%@",_FCtitle];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
	return 1;
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
	textfield1.tag = EnModifyPersonInfoTextfieldTag;
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.font = FONTN(14.0f);
	
	labeltitle.text = _FCtitle;
	textfield1.textColor = ColorBlackGray;
	textfield1.placeholder = [NSString stringWithFormat:@"请输入新的%@",_FCtitle];
	[cell.contentView addSubview:textfield1];

	
	return cell;
}

#pragma mark IBAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)gotonext:(id)sender
{
	UITextField *textfield = (UITextField *)[tableview viewWithTag:EnModifyPersonInfoTextfieldTag];
	if([textfield.text length]==0)
	{
		[MBProgressHUD showError:@"请输入要修改的信息" toView:app.window];
	}
	else if(([_FCtitle isEqualToString:@"电子邮件"])&&(![AddInterface isValidateEmail:textfield.text]))
	{
		[MBProgressHUD showError:@"请输入正确的邮箱地址" toView:app.window];
	}
	else if([_FCtitle isEqualToString:@"电子邮件"])
	{
		[self modifyuserinfo:@"email" ParaValue:textfield.text];
	}
    else if([_FCtitle isEqualToString:@"昵称"])
    {
        [self modifyuserinfo:@"nickname" ParaValue:textfield.text];
    }
}

#pragma mark 接口
-(void)modifyuserinfo:(NSString *)paratype ParaValue:(NSString *)paravalue
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:paravalue forKey:paratype];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001002001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 [self returnback];
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
