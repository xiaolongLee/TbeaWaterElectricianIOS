//
//  LoginViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = COLORNOW(243, 243, 243);
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	[self.navigationController setNavigationBarHidden:YES];
	[self initview];
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

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
	labdes.text = @"登录";
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
	
	//icon
	UIImageView *imageicon = [[UIImageView alloc] init];
	imageicon.image = LOADIMAGE(@"login_appicon", @"png");
	[self.view addSubview:imageicon];
	
	[imageicon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.view);
		make.size.mas_equalTo(CGSizeMake(80, 80));
		make.top.equalTo(@80.0f);
	}];
	
	//输入框
	UIView *textview =[self logintextfield:imageicon];
	
	//登录
	UIButton *btlogin = [UIButton buttonWithType:UIButtonTypeCustom];
	btlogin.backgroundColor = COLORNOW(27, 130, 210);
	[btlogin setTitle:@"登录" forState:UIControlStateNormal];
	[btlogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btlogin.titleLabel.font = FONTN(15.0f);
	[btlogin addTarget:self action:@selector(loginaction:) forControlEvents:UIControlEventTouchUpInside];
	btlogin.layer.cornerRadius= 2.0f;
	btlogin.clipsToBounds = YES;
	[self.view addSubview:btlogin];
	[btlogin mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view.mas_left).with.offset(20);
		make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
		make.top.mas_equalTo(textview.mas_bottom).with.offset(10);
		make.height.mas_equalTo(@40);
	}];
	
	//忘记密码
	UIButton *btforgot = [UIButton buttonWithType:UIButtonTypeCustom];
	[btforgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
	btforgot.titleLabel.font = FONTN(12.0f);
	[btforgot setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[btforgot addTarget:self action:@selector(clickforgetpwd:) forControlEvents:UIControlEventTouchUpInside];
	btforgot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	[self.view addSubview:btforgot];
	[btforgot mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(btlogin.mas_right);
		make.size.mas_equalTo(CGSizeMake(100, 30));
		make.top.mas_equalTo(btlogin.mas_bottom);
	}];
	
	//第三方登录
	[self threelogin:btforgot];
	
	//注册按钮
	UIButton *btregiest = [UIButton buttonWithType:UIButtonTypeCustom];
	[btregiest setTitle:@"注册" forState:UIControlStateNormal];
	btregiest.layer.borderColor = COLORNOW(27, 130, 210).CGColor;
	btregiest.layer.cornerRadius = 2.0f;
	btregiest.layer.borderWidth = 1.0f;
	[btregiest addTarget:self action:@selector(gotoregiest:) forControlEvents:UIControlEventTouchUpInside];
	btregiest.titleLabel.font = FONTN(14.0f);
	[btregiest setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
	[self.view addSubview:btregiest];
	[btregiest mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.size.mas_equalTo(CGSizeMake(60, 30));
		make.bottom.mas_equalTo(self.view.mas_bottom).offset(-40);
	}];
	
	
}

-(void)threelogin:(UIButton *)btforgot
{
	UIView *threeview = [[UIView alloc] init];
	threeview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:threeview];
	[threeview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@80);
		make.centerX.mas_equalTo(self.view);
		make.width.equalTo(@(35*5));
		make.top.equalTo(btforgot.mas_bottom).with.offset(50.0f);
	}];
	
	
	UILabel *labelname = [[UILabel alloc] init];
	labelname.text = @"第三方登录帐号";
	labelname.font = FONTN(13.0f);
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.backgroundColor = [UIColor clearColor];
	[threeview addSubview:labelname];
	[labelname mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(threeview.mas_top);
		make.centerX.mas_equalTo(threeview);
		make.size.mas_equalTo(CGSizeMake(200, 20));
	}];
	
	for(int i=0;i<3;i++)
	{
		UIButton *btthree = [UIButton buttonWithType:UIButtonTypeCustom];
		switch (i)
		{
			case 0:
				[btthree setImage:LOADIMAGE(@"login_weixinicon", @"png") forState:UIControlStateNormal];
				break;
			case 1:
				[btthree setImage:LOADIMAGE(@"login_qqicon", @"png") forState:UIControlStateNormal];
				break;
			case 2:
				[btthree setImage:LOADIMAGE(@"login_weiboicon", @"png") forState:UIControlStateNormal];
				break;
			case 3:
				[btthree setImage:LOADIMAGE(@"login_alipayicon", @"png") forState:UIControlStateNormal];
				break;
			
				
		}
		btthree.tag = EnThreeLoginButtonTag+i;
		[btthree addTarget:self action:@selector(clickThreeLogin:) forControlEvents:UIControlEventTouchUpInside];
		[threeview addSubview:btthree];
		[btthree mas_makeConstraints:^(MASConstraintMaker *make) {
			make.size.mas_equalTo(CGSizeMake(35, 35));
			make.top.mas_equalTo(labelname.mas_bottom).offset(20);
			make.left.mas_equalTo(threeview.mas_left).offset(35*(i*2));
			
		}];
	}
	
}

-(UIView *)logintextfield:(UIImageView *)imageicon
{
	UIView *textview = [[UIView alloc] init];
	textview.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	textview.layer.borderWidth = 1.0f;
	textview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:textview];
	[textview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@80);
		make.left.mas_equalTo(self.view).offset(20);
		make.right.mas_equalTo(self.view).offset(-20);
		make.top.equalTo(imageicon.mas_bottom).with.offset(30.0f);
	}];
	
	DLog(@"textview====%f",textview.frame.size.width);
	
	UILabel *imageline = [[UILabel alloc] init];
	imageline.backgroundColor = COLORNOW(225, 225, 225);
	[textview addSubview:imageline];
	[imageline mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@1);
		make.top.mas_equalTo(textview).offset(40);
		make.left.mas_equalTo(textview);
		make.right.mas_equalTo(textview);
	}];
	
	UIImageView *imageheader = [[UIImageView alloc] init];
	imageheader.image = LOADIMAGE(@"login_usericon", @"png");
	[textview addSubview:imageheader];
	[imageheader mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(20, 21));
		make.top.equalTo(@10);
		make.left.equalTo(@15);
	}];
	
	UIImageView *imagepwd = [[UIImageView alloc] init];
	imagepwd.image = LOADIMAGE(@"login_pwdicon", @"png");
	[textview addSubview:imagepwd];
	[imagepwd mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(19, 26));
		make.top.equalTo(imageline.mas_bottom).with.offset(7);
		make.left.equalTo(@15);
	}];
	
	UITextField *textfield1 = [[UITextField alloc] init];
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.placeholder = @"手机号码";
	textfield1.font = FONTN(14.0f);
	textfield1.tag = EnLoginPhoneTextFieldTag;
	UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield1.leftView = leftview;
	textfield1.leftViewMode = UITextFieldViewModeAlways;
	[textview addSubview:textfield1];
	[textfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagepwd.mas_right).with.offset(20);
		make.right.mas_equalTo(textview).offset(-20);
		make.height.equalTo(@30);
		make.top.mas_equalTo(textview).offset(5);
		
	}];
	
	UITextField *textfield2 = [[UITextField alloc] init];
	textfield2.backgroundColor = [UIColor clearColor];
	textfield2.placeholder = @"登录密码";
	textfield2.font = FONTN(14.0f);
	textfield2.secureTextEntry = YES;
	UIView *leftview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield2.leftView = leftview1;
	textfield2.leftViewMode = UITextFieldViewModeAlways;
	textfield2.tag = EnLoginPwdTextFieldTag;
	[textview addSubview:textfield2];
	[textfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(imagepwd.mas_right).with.offset(20);
		make.right.mas_equalTo(textfield1).offset(-50);
		make.height.equalTo(@30);
		make.top.mas_equalTo(imageline).offset(5);
		
	}];
	
	
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//	[button setImage:LOADIMAGE(@"login_closepwd", @"png") forState:UIControlStateNormal];
//	[button addTarget:self action:@selector(setpwdsecure:) forControlEvents:UIControlEventTouchUpInside];
//	[textview addSubview:button];
//	[button mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.size.mas_equalTo(CGSizeMake(40, 40));
//		make.top.mas_equalTo(imageline.mas_bottom);
//		make.right.mas_equalTo(textview.mas_right);
//	}];
	
	return textview;
}

#pragma mark IBAction
- (void)getAuthWithUserInfoFromSina
{
	[[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
		if (error) {
			
		} else {
			UMSocialUserInfoResponse *resp = result;
			
			// 授权信息
			NSLog(@"Sina uid: %@", resp.uid);
			NSLog(@"Sina accessToken: %@", resp.accessToken);
			NSLog(@"Sina refreshToken: %@", resp.refreshToken);
			NSLog(@"Sina expiration: %@", resp.expiration);
			
			// 用户信息
			NSLog(@"Sina name: %@", resp.name);
			NSLog(@"Sina iconurl: %@", resp.iconurl);
			NSLog(@"Sina gender: %@", resp.gender);
			
			// 第三方平台SDK源数据
			NSLog(@"Sina originalResponse: %@", resp.originalResponse);
		}
	}];
}

-(void)clickThreeLogin:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnThreeLoginButtonTag;
	
	switch (tagnow)
	{
		case 0: //微信
			
			break;
		case 1:  //QQ
			
			break;
		case 2: //微博
			[self getAuthWithUserInfoFromSina];
			break;

	}
}

-(void)clickforgetpwd:(id)sender
{
	ForgetPasswdGetVerifyCodeViewController *forgetpwd = [[ForgetPasswdGetVerifyCodeViewController alloc] init];
	[self.navigationController pushViewController:forgetpwd animated:YES];
}

-(void)returnkeytextfield
{
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnLoginPhoneTextFieldTag];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnLoginPwdTextFieldTag];
	[textfield resignFirstResponder];
	[textfield1 resignFirstResponder];
	
}

-(void)setpwdsecure:(id)sender
{
	UITextField *textfield2 = [self.view viewWithTag:EnLoginPwdTextFieldTag];
	if(textfield2.isSecureTextEntry == YES)
		textfield2.secureTextEntry = NO;
	else
		textfield2.secureTextEntry = YES;
}

-(void)loginaction:(id)sender
{
	[self returnkeytextfield];
	[self clicklogin];
}

-(void)returnback:(id)sender
{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)gotoregiest:(id)sender
{
	RegiestViewStartController *regiest = [[RegiestViewStartController alloc] init];
	[self.navigationController pushViewController:regiest animated:YES];
	
//	RegiestView *regiest = [[RegiestView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//	[app.window addSubview:regiest];
//	[UIView animateWithDuration:(0.4f)
//						  delay:(0.1)
//						options:UIViewAnimationOptionCurveLinear
//					 animations:^{
//						 regiest.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//					 } completion:^(BOOL finished) {
//						 
//					 }];
	
}

#pragma mark 接口
-(void)clicklogin
{
	UITextField *textfield1 = [self.view viewWithTag:EnLoginPhoneTextFieldTag];
	UITextField *textfield2 = [self.view viewWithTag:EnLoginPwdTextFieldTag];
	
	if(([[textfield1 text] length]==0)||([[textfield2 text] length]==0))
	{
		[MBProgressHUD showError:@"请填写电话和密码" toView:self.view];
	}
	else if(![AddInterface isValidateMobile:textfield1.text])
	{
		[MBProgressHUD showError:@"请填写正确格式的电话号码" toView:self.view];
	}
	else
	{
		NSMutableDictionary *params = [NSMutableDictionary dictionary];
		[params setObject:textfield1.text forKey:@"mobilenumber"];
		[params setObject:[AddInterface md5:textfield2.text] forKey:@"userpas"];
		[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG001001004000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
		 {
			 
		 }
											  Success:^(NSDictionary *dic)
		 {
			 DLog(@"dic====%@",dic);
			 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
			 {
				 NSMutableDictionary *dicmutable = [[NSMutableDictionary alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"userinfo"]];
	 			[dicmutable writeToFile:UserMessage atomically:NO];
	 			app.userinfo.userid = [dicmutable objectForKey:@"id"];
				app.userinfo.useridentified = [dicmutable objectForKey:@"whetheridentifiedid"];
				 
				[self.navigationController dismissViewControllerAnimated:YES completion:nil];
			 }
			 else
			 {
				 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 }
			 
		 }];
	}
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
