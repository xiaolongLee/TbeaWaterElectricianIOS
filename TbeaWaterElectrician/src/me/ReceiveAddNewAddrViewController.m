//
//  ReceiveAddNewAddrViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ReceiveAddNewAddrViewController.h"

@interface ReceiveAddNewAddrViewController ()

@end

@implementation ReceiveAddNewAddrViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setTitle:@"保存" forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTMEDIUM(14.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[buttonright addTarget:self action: @selector(saveaddr:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"新增收货地址";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	
	
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	
	isselect = EnNotSelect;
	if([self.straddrid length]>0)
	{
		[self requestaddrinfo:self.straddrid];
	}
	else
	{
		tableview.delegate = self;
		tableview.dataSource = self;
		[self initfootview];
	}
}

-(void)initfootview
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
	viewfoot.backgroundColor = [UIColor clearColor];
	
	UIButton *btsetting = [UIButton buttonWithType:UIButtonTypeCustom];
	btsetting.frame = CGRectMake(0, 5, SCREEN_WIDTH, 40);
	btsetting.backgroundColor = [UIColor whiteColor];
	[btsetting setTitle:@"设置为默认收货地址" forState:UIControlStateNormal];
	[btsetting setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
	if([self.straddrid length]>0)
	{
		if([[modifydicaddr objectForKey:@"isdefault"] intValue]==0)
		{
			isselect = EnNotSelect;
			[btsetting setImage:LOADIMAGE(@"nearby_select", @"png") forState:UIControlStateNormal];
		}
		else
		{
			isselect = EnSelectd;
			[btsetting setImage:LOADIMAGE(@"defaultaddrselected", @"png") forState:UIControlStateNormal];
		}
	}
	else
	{
		[btsetting setImage:LOADIMAGE(@"nearby_select", @"png") forState:UIControlStateNormal];
	}
	[btsetting setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	btsetting.titleLabel.font = FONTN(15.0f);
	btsetting.tag = EnReceiveAddrDefaultAddrBtTag;
	[btsetting addTarget:self action:@selector(clicksetting:) forControlEvents:UIControlEventTouchUpInside];
	[viewfoot addSubview:btsetting];
	
	tableview.tableFooterView = viewfoot;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if((textField.tag==EnAddNewAddrTFTag4)||(textField.tag==EnAddNewAddrTFTag5))
	{
		SelectAddressViewController *selectaddr = [[SelectAddressViewController alloc] init];
		selectaddr.delegate1 = self;
		if([self.straddrid length]>0)
			selectaddr.dicaddr = modifydicaddr;
		[self.navigationController pushViewController:selectaddr animated:YES];
		return NO;
	}
	return YES;
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
	return 4;
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
	
	
	
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"收件人";
			textfield1.textColor = ColorBlackGray;
			textfield1.placeholder = @"请输入收件人姓名";
			if([self.straddrid length]>0)
				textfield1.text = [modifydicaddr objectForKey:@"contactperson"];
			textfield1.tag = EnAddNewAddrTFTag1;
			[cell.contentView addSubview:textfield1];
			break;
		case 1:
			labeltitle.text = @"手机号码";
			textfield1.textColor = ColorBlackdeep;
			textfield1.placeholder = @"请输入手机号";
			textfield1.tag = EnAddNewAddrTFTag2;
			if([self.straddrid length]>0)
				textfield1.text = [modifydicaddr objectForKey:@"contactmobile"];
			[cell.contentView addSubview:textfield1];
			break;
//		case 2:
//			labeltitle.text = @"邮编";
//			textfield1.textColor = ColorBlackdeep;
//			textfield1.placeholder = @"请输入邮编";
//			textfield1.tag = EnAddNewAddrTFTag3;
//			
//			[cell.contentView addSubview:textfield1];
//			break;
		case 2:
			labeltitle.text = @"省市区";
			textfield1.textColor = ColorBlackdeep;
			textfield1.tag = EnAddNewAddrTFTag4;
			if([self.straddrid length]>0)
				textfield1.text = [NSString stringWithFormat:@"%@%@%@",[modifydicaddr objectForKey:@"province"],[modifydicaddr objectForKey:@"city"],[modifydicaddr objectForKey:@"zone"]];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			[cell.contentView addSubview:textfield1];
			break;
		case 3:
			labeltitle.text = @"详细地址";
			textfield1.textColor = ColorBlackdeep;
			textfield1.placeholder = @"点击设置详细地址";
			textfield1.tag = EnAddNewAddrTFTag5;
			if([self.straddrid length]>0)
				textfield1.text = [modifydicaddr objectForKey:@"address"];
			[cell.contentView addSubview:textfield1];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark actiondelegate
-(void)ReceiveAddrselectAddr:(NSDictionary *)dicaddr
{
	DLog(@"dicaddr====%@",dicaddr);
	
	UITextField *textfield1 = [tableview viewWithTag:EnAddNewAddrTFTag4];
	UITextField *textfield2 = [tableview viewWithTag:EnAddNewAddrTFTag5];
	strproviceid = [dicaddr objectForKey:@"sproviceid"];
	strcityid = [dicaddr objectForKey:@"scityid"];
	strareaid = [dicaddr objectForKey:@"sareaid"];
	straddress = [dicaddr objectForKey:@"addrtext"];
	textfield1.text = [NSString stringWithFormat:@"%@ %@ %@",[dicaddr objectForKey:@"sprovicename"],[dicaddr objectForKey:@"scityname"],[dicaddr objectForKey:@"sareaname"]];
	textfield2.text = [dicaddr objectForKey:@"addrtext"];
	dicaddrselect = dicaddr;
}

#pragma mark IBAction
-(void)clicksetting:(id)sender
{
	UIButton *button = (UIButton *)sender;
	if(isselect==EnNotSelect)
	{
		isselect = EnSelectd;
		[button setImage:LOADIMAGE(@"defaultaddrselected", @"png") forState:UIControlStateNormal];
		
	}
	else
	{
		isselect = EnNotSelect;
		[button setImage:LOADIMAGE(@"nearby_select", @"png") forState:UIControlStateNormal];
	}
}

-(void)returnkeytextfield
{
	UITextField *textfield1 = [self.view viewWithTag:EnAddNewAddrTFTag1];
	UITextField *textfield2 = [self.view viewWithTag:EnAddNewAddrTFTag2];
	UITextField *textfield3 = [self.view viewWithTag:EnAddNewAddrTFTag3];
	UITextField *textfield4 = [self.view viewWithTag:EnAddNewAddrTFTag4];
	UITextField *textfield5 = [self.view viewWithTag:EnAddNewAddrTFTag5];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];
	[textfield5 resignFirstResponder];
}

-(void)saveaddr:(id)sender
{
	[self returnkeytextfield];
	UITextField *textfield1 = [self.view viewWithTag:EnAddNewAddrTFTag1];
	UITextField *textfield2 = [self.view viewWithTag:EnAddNewAddrTFTag2];
	UITextField *textfield4 = [self.view viewWithTag:EnAddNewAddrTFTag4];
	UITextField *textfield5 = [self.view viewWithTag:EnAddNewAddrTFTag5];
	if([textfield1.text length]==0||[textfield2.text length]==0||[textfield4.text length]==0||[textfield5.text length]==0)
	{
		 [MBProgressHUD showError:@"请填写完整的地址信息" toView:app.window];
	}
	else if(![AddInterface isValidateMobile:textfield2.text])
	{
		[MBProgressHUD showError:@"请填写正确的电话号码" toView:app.window];
	}
	else if([self.straddrid length]>0)
	{
		[self modifyaddrinfo:textfield1.text Mobile:textfield2.text SproviceId:strproviceid ScityId:strcityid SareaId:strareaid AddrText:straddress];
	}
	else
	{
		[self requestmodifyaddr:textfield1.text Mobile:textfield2.text Dicaddr:dicaddrselect];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)gotonext:(id)sender
{
	ModifyPwdDoneViewController *modifydone = [[ModifyPwdDoneViewController alloc] init];
	[self.navigationController pushViewController:modifydone animated:YES];
}


#pragma mark 接口
-(void)requestmodifyaddr:(NSString *)person Mobile:(NSString *)mobile Dicaddr:(NSDictionary *)dicaddr
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:person forKey:@"contactperson"];
	[params setObject:mobile forKey:@"contactmobile"];
	[params setObject:[dicaddr objectForKey:@"sproviceid"] forKey:@"provinceid"];
	[params setObject:[dicaddr objectForKey:@"scityid"] forKey:@"cityid"];
	[params setObject:[dicaddr objectForKey:@"sareaid"] forKey:@"zoneid"];
	[params setObject:[dicaddr objectForKey:@"addrtext"] forKey:@"address"];
	[params setObject:[NSString stringWithFormat:@"%d",isselect] forKey:@"isdefault"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001004000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 [self.navigationController popViewControllerAnimated:YES];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

-(void)modifyaddrinfo:(NSString *)person Mobile:(NSString *)mobile SproviceId:(NSString *)sproviceid ScityId:(NSString *)scityid SareaId:(NSString *)sareaid AddrText:(NSString *)addrtext
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:self.straddrid forKey:@"receiveaddrid"];
	[params setObject:person forKey:@"contactperson"];
	[params setObject:mobile forKey:@"contactmobile"];
	[params setObject:sproviceid forKey:@"provinceid"];
	[params setObject:scityid forKey:@"cityid"];
	[params setObject:sareaid forKey:@"zoneid"];
	[params setObject:addrtext forKey:@"address"];
	[params setObject:[NSString stringWithFormat:@"%d",isselect] forKey:@"isdefault"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001004002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 [self.navigationController popViewControllerAnimated:YES];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

-(void)requestaddrinfo:(NSString *)addrid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:addrid forKey:@"receiveaddrid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001003002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 modifydicaddr = [[dic objectForKey:@"data"] objectForKey:@"addressinfo"];
			 strproviceid = [modifydicaddr objectForKey:@"provinceid"];
			 strcityid = [modifydicaddr objectForKey:@"cityid"];
			 strareaid = [modifydicaddr objectForKey:@"zoneid"];
			 straddress = [modifydicaddr objectForKey:@"address"];
			 [self initfootview];
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
