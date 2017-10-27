//
//  RegiestViewStartController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "RegiestViewStartController.h"

@interface RegiestViewStartController ()

@end

@implementation RegiestViewStartController

- (void)viewDidLoad {
	[super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	getyanzhengcodeflag = 0;
	self.view.backgroundColor = COLORNOW(243, 243, 243);
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	selectmodel = 1;
	regiestphone = @"";
	regiestpwd = @"";
	regiestcode = @"";
	self.result = @" ";
	[self getregiestphone];  //获取电话
	content1 = [[NSMutableArray alloc] init];
	self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	self.maskView.backgroundColor = [UIColor blackColor];
	self.maskView.alpha = 0;
	self.maskView.tag = 801;
	[self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	[imageviewtopblue mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.top.and.right.mas_equalTo(self.view);
		make.height.equalTo(@64);
	}];
	
	UILabel *labdes = [[UILabel alloc] init];
	labdes.textColor = [UIColor whiteColor];
	labdes.backgroundColor = [UIColor clearColor];
	labdes.text = @"注册";
	labdes.textAlignment = NSTextAlignmentCenter;
	labdes.font = FONTN(16.0f);
	[self.view addSubview:labdes];
	[labdes mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@(SCREEN_WIDTH-140));
		make.top.mas_equalTo(imageviewtopblue.mas_top).offset(32);
		make.left.mas_equalTo(imageviewtopblue.mas_left).offset(70);
	}];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	btreturn.titleLabel.font = FONTN(12.0f);
	[btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
	[btreturn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view.mas_left);
		make.size.mas_equalTo(CGSizeMake(44, 44));
		make.top.mas_equalTo(20);
	}];


	//电话认证
	//UIView *viewphone =
	[self telcertificationview:imageviewtopblue];
	
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES];
}


#pragma mark 电话认证
-(UIView *)telcertificationview:(UIImageView *)imageviewtopblue
{
	UIView *viewleft = [[UIView alloc] init];
	viewleft.backgroundColor = [UIColor clearColor];
	viewleft.tag = EnRegiestLeftView;
	[self.view addSubview:viewleft];
	[viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-40));
		make.top.mas_equalTo(imageviewtopblue.mas_bottom);
		make.left.mas_equalTo(self.view.mas_left);
	}];
	
	
	//输入框
	UIImageView *imagewhitebg = [[UIImageView alloc] init];
	imagewhitebg.backgroundColor = [UIColor whiteColor];
	[viewleft addSubview:imagewhitebg];
	[imagewhitebg mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.mas_equalTo(viewleft);
		make.height.mas_equalTo(240);
	}];
	
	//线
	UILabel *imagelineh = [[UILabel alloc] init];
	imagelineh.backgroundColor = COLORNOW(225, 225, 225);
	[viewleft addSubview:imagelineh];
	[imagelineh mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@30);
		make.width.equalTo(@1);
		make.left.mas_equalTo(imagewhitebg.mas_left).with.offset(60);
		make.top.mas_equalTo(imagewhitebg.mas_top).with.offset(5);
	}];
	
	for(int i=1;i<6;i++)
	{
		UILabel *imageline = [[UILabel alloc] init];
		imageline.backgroundColor = COLORNOW(225, 225, 225);
		[viewleft addSubview:imageline];
		[imageline mas_makeConstraints:^(MASConstraintMaker *make) {
			make.height.equalTo(@1);
			make.right.mas_equalTo(imagewhitebg);
			make.left.mas_equalTo(imagewhitebg.mas_left).with.offset(10);
			make.top.mas_equalTo(imagewhitebg.mas_top).with.offset(40*i);
		}];
	}
	
	
	UILabel *imagequhao = [[UILabel alloc] init];
	imagequhao.textColor = COLORNOW(4, 4, 4);
	imagequhao.backgroundColor = [UIColor clearColor];
	imagequhao.text = @"+86";
	imagequhao.font = FONTN(13.0f);
	[viewleft addSubview:imagequhao];
	[imagequhao mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@30);
		make.top.mas_equalTo(viewleft.mas_top).offset(10);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	UIImageView *imagearraybottom = [[UIImageView alloc] init];
	imagearraybottom.image = LOADIMAGE(@"regiest_下拉", @"png");
	[viewleft addSubview:imagearraybottom];
	[imagearraybottom mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(10, 6));
		make.left.mas_equalTo(imagequhao.mas_right).with.offset(2);
		make.top.mas_equalTo(imagewhitebg.mas_top).with.offset(17);
	}];
	
	UILabel *imagecode = [[UILabel alloc] init];
	imagecode.textColor = COLORNOW(4, 4, 4);
	imagecode.backgroundColor = [UIColor clearColor];
	imagecode.text = @"验证码";
	imagecode.font = FONTN(14.0f);
	[viewleft addSubview:imagecode];
	[imagecode mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@50);
		make.top.mas_equalTo(viewleft.mas_top).offset(50);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	UILabel *imagepwd = [[UILabel alloc] init];
	imagepwd.textColor = COLORNOW(4, 4, 4);
	imagepwd.backgroundColor = [UIColor clearColor];
	imagepwd.text = @"密码";
	imagepwd.font = FONTN(14.0f);
	[viewleft addSubview:imagepwd];
	[imagepwd mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@40);
		make.top.mas_equalTo(viewleft.mas_top).offset(90);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	UILabel *imagepwd2 = [[UILabel alloc] init];
	imagepwd2.textColor = COLORNOW(4, 4, 4);
	imagepwd2.backgroundColor = [UIColor clearColor];
	imagepwd2.text = @"确认密码";
	imagepwd2.font = FONTN(14.0f);
	[viewleft addSubview:imagepwd2];
	[imagepwd2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@60);
		make.top.mas_equalTo(viewleft.mas_top).offset(130);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	UILabel *imagearea = [[UILabel alloc] init];
	imagearea.textColor = COLORNOW(4, 4, 4);
	imagearea.backgroundColor = [UIColor clearColor];
	imagearea.text = @"所在地区";
	imagearea.font = FONTN(14.0f);
	[viewleft addSubview:imagearea];
	[imagearea mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@60);
		make.top.mas_equalTo(viewleft.mas_top).offset(170);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	UILabel *imagelevel = [[UILabel alloc] init];
	imagelevel.textColor = COLORNOW(4, 4, 4);
	imagelevel.backgroundColor = [UIColor clearColor];
	imagelevel.text = @"上级经销商";
	imagelevel.font = FONTN(14.0f);
	[viewleft addSubview:imagelevel];
	[imagelevel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@80);
		make.top.mas_equalTo(viewleft.mas_top).offset(210);
		make.left.mas_equalTo(viewleft.mas_left).offset(10);
	}];
	
	
	
	UITextField *textfieldphone = [[UITextField alloc] init];
	textfieldphone.backgroundColor = [UIColor clearColor];
	textfieldphone.placeholder = @"手机号";
	textfieldphone.font = FONTN(14.0f);
	textfieldphone.delegate = self;
	UIView *leftview3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldphone.leftView = leftview3;
	textfieldphone.leftViewMode = UITextFieldViewModeAlways;
	textfieldphone.text = regiestphone;
	textfieldphone.tag = EnRegiestPhoneTextFieldTag;
	[viewleft addSubview:textfieldphone];
	[textfieldphone mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-90);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(5);
		
	}];
	
	UITextField *textfieldcode = [[UITextField alloc] init];
	textfieldcode.backgroundColor = [UIColor clearColor];
	textfieldcode.placeholder = @"请输入验证码";
	textfieldcode.font = FONTN(14.0f);
	textfieldcode.text = regiestcode;
	textfieldcode.delegate = self;
	UIView *leftview4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldcode.leftView = leftview4;
	textfieldcode.leftViewMode = UITextFieldViewModeAlways;
	textfieldcode.tag = EnRegiestCodeTextFieldTag;
	[viewleft addSubview:textfieldcode];
	[textfieldcode mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-90);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(45);
		
	}];
	
	UITextField *textfieldpwd = [[UITextField alloc] init];
	textfieldpwd.backgroundColor = [UIColor clearColor];
	textfieldpwd.placeholder = @"6-32位字母数字组合";
	textfieldpwd.font = FONTN(14.0f);
	textfieldpwd.text = regiestpwd;
	textfieldpwd.delegate = self;
	UIView *leftview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldpwd.leftView = leftview5;
	textfieldpwd.leftViewMode = UITextFieldViewModeAlways;
	textfieldpwd.secureTextEntry = YES;
	textfieldpwd.tag = EnRegiestPwdTextFieldTag;
	[viewleft addSubview:textfieldpwd];
	[textfieldpwd mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-90);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(85);
		
	}];
	
	UITextField *textfieldpwd2 = [[UITextField alloc] init];
	textfieldpwd2.backgroundColor = [UIColor clearColor];
	textfieldpwd2.placeholder = @"确认密码 6-32位字母数字组合";
	textfieldpwd2.font = FONTN(14.0f);
	textfieldpwd2.text = regiestpwd;
	textfieldpwd2.delegate = self;
	UIView *leftview8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldpwd2.leftView = leftview8;
	textfieldpwd2.leftViewMode = UITextFieldViewModeAlways;
	textfieldpwd2.secureTextEntry = YES;
	textfieldpwd2.tag = EnRegiestPwdTextFieldTag1;
	[viewleft addSubview:textfieldpwd2];
	[textfieldpwd2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-30);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(125);
		
	}];
	
	
	UITextField *textfieldarea = [[UITextField alloc] init];
	textfieldarea.backgroundColor = [UIColor clearColor];
	textfieldarea.placeholder = @"请如实选择,将直接影响你的扫码返利,不能修改";
	textfieldarea.font = FONTN(14.0f);
	textfieldarea.text = regiestpwd;
	textfieldarea.delegate = self;
	UIView *leftview6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldarea.leftView = leftview6;
	textfieldarea.leftViewMode = UITextFieldViewModeAlways;
	textfieldarea.tag = EnRegiestAreaTextFieldTag;
	[viewleft addSubview:textfieldarea];
	[textfieldarea mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-10);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(165);
		
	}];
	
	UITextField *textfieldlevel = [[UITextField alloc] init];
	textfieldlevel.backgroundColor = [UIColor clearColor];
	textfieldlevel.placeholder = @"请选择所在地区的上级经销商";
	textfieldlevel.font = FONTN(14.0f);
	textfieldlevel.text = regiestpwd;
	textfieldlevel.delegate = self;
	UIView *leftview7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldlevel.leftView = leftview7;
	textfieldlevel.leftViewMode = UITextFieldViewModeAlways;
	textfieldlevel.tag = EnRegiestLevelTextFieldTag;
	[viewleft addSubview:textfieldlevel];
	[textfieldlevel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagelineh.mas_right).with.offset(30);
		make.right.mas_equalTo(imagewhitebg.mas_right).offset(-90);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(205);
		
	}];
	
	
	//获取验证码
	UIButton *btgetcode = [UIButton buttonWithType:UIButtonTypeCustom];
	btgetcode.backgroundColor = [UIColor clearColor];
	[btgetcode setTitle:@"获取验证码" forState:UIControlStateNormal];
	[btgetcode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	btgetcode.titleLabel.font = FONTN(14.0f);
	btgetcode.layer.cornerRadius= 2.0f;
	btgetcode.layer.borderWidth = 1.0f;
	[btgetcode addTarget:self action:@selector(getphonecode:) forControlEvents:UIControlEventTouchUpInside];
	btgetcode.layer.borderColor = COLORNOW(187, 187, 187).CGColor;
	btgetcode.clipsToBounds = YES;
	btgetcode.tag = 7690;
	[viewleft addSubview:btgetcode];
	[btgetcode mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(@85);
		make.right.mas_equalTo(imagewhitebg.mas_right).with.offset(-5);
		make.top.mas_equalTo(imagewhitebg.mas_top).with.offset(6);
		make.height.mas_equalTo(28);
	}];
	
	
	
	//下一步
	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
	btnext.backgroundColor = COLORNOW(27, 130, 210);
	[btnext setTitle:@"确认" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	btnext.layer.cornerRadius= 2.0f;
	btnext.clipsToBounds = YES;
	[btnext addTarget:self action:@selector(getnextstep:) forControlEvents:UIControlEventTouchUpInside];
	[viewleft addSubview:btnext];
	[btnext mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(viewleft.mas_left).with.offset(10);
		make.right.mas_equalTo(viewleft.mas_right).with.offset(-10);
		make.top.mas_equalTo(imagewhitebg.mas_bottom).with.offset(15);
		make.height.mas_equalTo(@40);
	}];
	
	
	//用户协议
	UIImageView *imageprotocol = [[UIImageView alloc] init];
	imageprotocol.backgroundColor = [UIColor clearColor];
	imageprotocol.image = LOADIMAGE(@"regiest_OK", @"png");
	[viewleft addSubview:imageprotocol];
	[imageprotocol mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(btnext.mas_left);
		make.top.mas_equalTo(btnext.mas_bottom).offset(20);
		make.size.mas_equalTo(CGSizeMake(15, 15));
		make.height.mas_equalTo(120);
	}];
	
	UILabel *labins = [[UILabel alloc] init];
	labins.textColor = COLORNOW(187, 187, 187);
	labins.backgroundColor = [UIColor clearColor];
	labins.text = @"我已阅读并同意优商app";
	labins.font = FONTN(12.0f);
	[viewleft addSubview:labins];
	[labins mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@15);
		make.width.equalTo(@133);
		make.top.mas_equalTo(imageprotocol.mas_top);
		make.left.mas_equalTo(imageprotocol.mas_right).offset(5);
	}];
	
	UIButton *btuser = [UIButton buttonWithType:UIButtonTypeCustom];
	btuser.backgroundColor = [UIColor clearColor];
	[btuser setTitle:@"<用户使用协议>" forState:UIControlStateNormal];
	[btuser setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
	btuser.titleLabel.font = FONTN(12.0f);
	[btuser addTarget:self action:@selector(clickuserprotocol:) forControlEvents:UIControlEventTouchUpInside];
	btuser.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[viewleft addSubview:btuser];
	[btuser mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(labins.mas_right).with.offset(2);
		make.width.mas_equalTo(@100);
		make.top.mas_equalTo(btnext.mas_bottom).with.offset(16);
		make.height.mas_equalTo(@25);
	}];
	
	UILabel *labdes = [[UILabel alloc] init];
	labdes.textColor = COLORNOW(187, 187, 187);
	labdes.backgroundColor = [UIColor clearColor];
	labdes.numberOfLines = 5;
	labdes.text = @"为了您能正常的使用扫码返利功能，请如实的填写您的个人信。\n1.请如实选择您常在地区，选择后将直接影响您的返利，注册后不能更改。\n2.请如实选择您所在区域的经销商，如不清楚自己的上级经销商，选择默认，系统将自动分配到当地总经销商";
	labdes.font = FONTN(12.0f);
	[viewleft addSubview:labdes];
	[labdes mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@80);
		make.width.equalTo(@(SCREEN_WIDTH-30));
		make.top.mas_equalTo(labins.mas_bottom);
		make.left.mas_equalTo(imageprotocol.mas_right);
	}];
	
	UIButton *bttel = [UIButton buttonWithType:UIButtonTypeCustom];
	bttel.backgroundColor = [UIColor clearColor];
	[bttel setTitle:@"热线电话:028-88080980" forState:UIControlStateNormal];
	[bttel setTitleColor:COLORNOW(187, 187, 187) forState:UIControlStateNormal];
	bttel.titleLabel.font = FONTN(12.0f);
	[bttel addTarget:self action:@selector(clicktel:) forControlEvents:UIControlEventTouchUpInside];
	bttel.tag = EnHotPhoneBtTag;
	bttel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[viewleft addSubview:bttel];
	[bttel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(labins.mas_left);
		make.width.mas_equalTo(@150);
		make.top.mas_equalTo(labdes.mas_bottom).with.offset(5);
		make.height.mas_equalTo(@15);
	}];
	
	
	return viewleft;
}


#pragma  IBAction

-(void)returnback:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ActionDelegate
-(void)ReceiveAddrselectAddr:(NSDictionary *)dicaddr
{
	DLog(@"dicaddr====%@",dicaddr);
	
	UITextField *textfield1 = [self.view viewWithTag:EnRegiestAreaTextFieldTag];
	
	strproviceid = [dicaddr objectForKey:@"sproviceid"];
	strcityid = [dicaddr objectForKey:@"scityid"];
	strareaid = [dicaddr objectForKey:@"sareaid"];
	textfield1.text = [NSString stringWithFormat:@"%@ %@ %@",[dicaddr objectForKey:@"sprovicename"],[dicaddr objectForKey:@"scityname"],[dicaddr objectForKey:@"sareaname"]];
	dicaddrselect = dicaddr;
}



#pragma mark UItextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnRegiestAreaTextFieldTag)
	{
		[self returnkeytextfield];
		SelectAddrNotAddressViewController *selectaddr = [[SelectAddrNotAddressViewController alloc] init];
		selectaddr.delegate1 = self;
		[self.navigationController pushViewController:selectaddr animated:YES];
		return NO;
	}
	else if(textField.tag == EnRegiestLevelTextFieldTag)
	{
		[self returnkeytextfield];
		if([strproviceid length]==0||[strcityid length]==0||[strareaid length]==0)
		{
			[MBProgressHUD showError:@"请选择区域" toView:app.window];
		}
		else
		{
			[self getjxsList:strproviceid Cityid:strcityid AreaId:strareaid];
		}
		return NO;
	}
	return YES;
}

#pragma mark IBaction
-(void)clickuserprotocol:(id)sender
{
	WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
	webviewcontent.strtitle = @"用户协议";
	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/userregisteragreement";
	webviewcontent.strnewsurl = str;
	[self.navigationController pushViewController:webviewcontent animated:YES];
}

-(void)clicktel:(id)sender
{
//	UIButton *button =(UIButton *)sender;
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[dictel objectForKey:@"contactmobile"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)returnkeytextfield
{
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnRegiestPwdTextFieldTag];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnRegiestPhoneTextFieldTag];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:EnRegiestCodeTextFieldTag];
	UITextField *textfield3 = (UITextField *)[self.view viewWithTag:EnRegiestCarRealNameTextFieldTag];
	UITextField *textfield4 = (UITextField *)[self.view viewWithTag:EnRegiestCardNumberTextFieldTag];
	[textfield resignFirstResponder];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];
}


-(void)getnextstep:(id)sender
{
//	RegiestSuccessViewController *regiestsuccess = [[RegiestSuccessViewController alloc] init];
//	[self.navigationController pushViewController:regiestsuccess animated:YES];
	
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnRegiestPwdTextFieldTag];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnRegiestPhoneTextFieldTag];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:EnRegiestCodeTextFieldTag];
	UITextField *textfield3 = (UITextField *)[self.view viewWithTag:EnRegiestAreaTextFieldTag];
	UITextField *textfield4 = (UITextField *)[self.view viewWithTag:EnRegiestLevelTextFieldTag];
	UITextField *textfield5 = (UITextField *)[self.view viewWithTag:EnRegiestPwdTextFieldTag1];
	DLog(@"[textfield.text length]===%d",(int)[textfield.text length]);
	if(([[textfield text] length]==0)||([[textfield1 text] length]==0)||([[textfield2 text] length]==0)||([[textfield3 text] length]==0)||([[textfield4 text] length]==0)||([[textfield5 text] length]==0))
	{
		[MBProgressHUD showError:@"请填写全注册信息" toView:self.view];
	}
	else if(![textfield.text isEqualToString:textfield5.text])
	{
		[MBProgressHUD showError:@"两次输入密码不相同" toView:self.view];
	}
	else if(((int)[textfield.text length]<6)||((int)[textfield.text length]>11))
	{
		[MBProgressHUD showError:@"密码请确定输入6-10位" toView:self.view];
	}
	else
	{
		regiestphone = textfield1.text;
		regiestpwd = textfield.text;
		regiestcode = textfield2.text;
		[self requestregiest];
	}
}

-(void)getphonecode:(id)sender
{
	if(getyanzhengcodeflag == 0)
	{
		UITextField *textfield1 = [self.view viewWithTag:EnRegiestPhoneTextFieldTag];
		
		
		if([[textfield1 text] length]==0)
		{
			[MBProgressHUD showError:@"请填写电话和密码" toView:self.view];
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
	UIButton *button = (UIButton *)[self.view viewWithTag:7690];
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


#pragma mark 获取验证码
-(void)clickgetcode
{
	UITextField *textfield1 = [self.view viewWithTag:EnRegiestPhoneTextFieldTag];
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:textfield1.text forKey:@"mobile"];
	[params setObject:@"TBEAENG001001002000" forKey:@"servicecode"];
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



-(void)getjxsList:(NSString *)pid Cityid:(NSString *)cityid AreaId:(NSString *)areaid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:pid forKey:@"provinceid"];
	[params setObject:cityid forKey:@"cityid"];
	[params setObject:areaid forKey:@"zoneid"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001002001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydistributor = [[dic objectForKey:@"data"] objectForKey:@"distributorlist"];
			 [self showaccession:1];
//			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}


-(void)getregiestphone
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001002002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dictel = [[dic objectForKey:@"data"] objectForKey:@"pageinfo"];
			 UIButton *button = [self.view viewWithTag:EnHotPhoneBtTag];
			 [button setTitle:[NSString stringWithFormat:@"热线电话:%@",[[[dic objectForKey:@"data"] objectForKey:@"pageinfo"] objectForKey:@"contactmobile"]] forState:UIControlStateNormal];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}


-(void)requestregiest
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:regiestphone forKey:@"mobile"];
	[params setObject:[AddInterface md5:regiestpwd] forKey:@"password"];
	[params setObject:regiestcode forKey:@"verifycode"];
	[params setObject:strproviceid forKey:@"provinceid"];
	[params setObject:strcityid forKey:@"cityid"];
	[params setObject:strareaid forKey:@"zoneid"];
	[params setObject:strlevelid forKey:@"distributorid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001002000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			NSMutableDictionary *dicmutable = [[NSMutableDictionary alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"userinfo"]];
			[dicmutable writeToFile:UserMessage atomically:NO];
			app.userinfo.userid = [dicmutable objectForKey:@"id"];
			RegiestSuccessViewController *certification = [[RegiestSuccessViewController alloc] init];
			certification.strtel = [dictel objectForKey:@"contactmobile"];
			[self.navigationController pushViewController:certification animated:YES];
			
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}

	}];
	
}

#pragma mark - 滚轮选择
-(void)showaccession:(int)sender
{
	[self returnkeytextfield];
	[self showpickview:1];
	
}

-(UIView *)initviewsheet:(CGRect)frameview
{
	UIView *viewsheet = [[UIView alloc] initWithFrame:frameview];
	viewsheet.backgroundColor = [UIColor whiteColor];
	
	UIPickerView *picview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 216)];
	picview.delegate = self;
	picview.tag = 9990;
	[viewsheet addSubview:picview];
	
	UIButton *buttoncancel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncancel.frame = CGRectMake(0, 0, 80, 40);
	buttoncancel.titleLabel.font = FONTMEDIUM(15.0f);
	[buttoncancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttoncancel addTarget:self action:@selector(cancelbt:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncancel setTitle:@"取消" forState:UIControlStateNormal];
	[viewsheet addSubview:buttoncancel];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
	buttondone.titleLabel.font = FONTMEDIUM(15.0f);
	[buttondone addTarget:self action:@selector(ensurebt:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	[viewsheet addSubview:buttondone];
	
	return viewsheet;
}

- (void)showpickview:(int)sender
{
	[content1 removeAllObjects];
	if(selectmodel == 1)   //市
	{
		if([arraydistributor count]==0)
		{
			[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
			return;
		}
		for(int i=0;i<[arraydistributor count];i++)
		{
			NSDictionary *dictype = [arraydistributor objectAtIndex:i];
			[content1 addObject:[dictype objectForKey:@"name"]];
		}
	}

	self.result = [content1 objectAtIndex:0];
	
	[[self.view viewWithTag:800] removeFromSuperview];
	[self.maskView removeFromSuperview];
	
	[self.view addSubview:self.maskView];
	self.maskView.alpha = 0;
	UIView *viewsheet = [self initviewsheet:CGRectMake(0, SCREEN_HEIGHT-255, SCREEN_WIDTH, 255)];
	viewsheet.tag = 800;
	[self.view addSubview:viewsheet];
	
	UIPickerView *picview = (UIPickerView *)[self.view viewWithTag:9990];
	
	[picview selectRow:[content1 count]/2 inComponent:0 animated:NO];
	self.result  = [content1 objectAtIndex:[content1 count]/2];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.maskView.alpha = 0.3;
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x, SCREEN_HEIGHT-viewsheet.frame.size.height, viewsheet.frame.size.width, viewsheet.frame.size.height);
	}];
	
}

- (void)hideMyPicker {
	UIView *viewsheet = (UIView *)[self.view viewWithTag:800];
	[UIView animateWithDuration:0.3 animations:^{
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x,SCREEN_HEIGHT, viewsheet.frame.size.width, viewsheet.frame.size.height);
		self.maskView.alpha = 0;
	} completion:^(BOOL finished) {
		[viewsheet removeFromSuperview];
		[self.maskView removeFromSuperview];
	}];
}



- (void)cancelbt:(id)sender {
	[self hideMyPicker];
}

- (void)ensurebt:(id)sender {
	
	[self hideMyPicker];
	if(selectmodel == 1)
	{
		UITextField *texttemp = (UITextField *)[self.view viewWithTag:EnRegiestLevelTextFieldTag];
		texttemp.text = self.result;
		for(int i=0;i<[arraydistributor count];i++)
		{
			NSDictionary *dictemp = [arraydistributor objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:self.result])
			{
				strlevelid = [dictemp objectForKey:@"id"];
				break;
			}
		}
	}
	
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	return 1;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if(component == 0)
		return [content1 count];
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component == 0)
		return [content1 objectAtIndex:row];
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component == 0)
		self.result = [content1 objectAtIndex:row];
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
