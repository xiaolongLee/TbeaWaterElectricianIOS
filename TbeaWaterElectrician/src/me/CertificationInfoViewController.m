//
//  CertificationInfoViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CertificationInfoViewController.h"

@interface CertificationInfoViewController ()

@end

@implementation CertificationInfoViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(243, 243, 243);
	[self initview];
	[self getcertificationinfo];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	self.title = @"认证信息";
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	//选择框
	UIView * viewtop = [self topnumber];
	
	
	//	//实名认证
//	UIView *viewcer =
    [self namecertificationview:viewtop];
	
	
}


#pragma mark 实名认证
-(UIView *)namecertificationview:(UIView *)viewtopname
{
	UIView *viewright = [[UIView alloc] init];
	viewright.backgroundColor = [UIColor clearColor];
	viewright.tag = EnRegiestRightView;
	[self.view addSubview:viewright];
	[viewright mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-40-10));
		make.top.mas_equalTo(viewtopname.mas_bottom).offset(10);
		make.left.mas_equalTo(viewtopname.mas_left);
	}];
	
	//两个形态
	UIScrollView *scrollview = [[UIScrollView alloc] init];
	scrollview.backgroundColor = [UIColor clearColor];
	[viewright addSubview:scrollview];
	[scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.bottom.top.mas_equalTo(viewright);
		
	}];
	
	//信息输入
	
	UIView *inputview =  [self inputuserinfo:scrollview];
	
	//身份证书正反面
	UIView *cardpicview =  [self cardpic:inputview Scrollview:scrollview];
	
	
	//手持身份证
	//UIView *cardperson =
	[self cardperson:cardpicview Scrollview:scrollview];
	
	
	
	return viewright;
}

-(UIView *)cardperson:(UIView *)cardpicview Scrollview:(UIScrollView *)scrollview
{
	UIView *cardpersonview = [[UIView alloc] init];
	cardpersonview.backgroundColor = [UIColor clearColor];
	[scrollview addSubview:cardpersonview];
	[cardpersonview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(@240);
		make.top.mas_equalTo(cardpicview.mas_bottom);
		make.left.right.mas_equalTo(scrollview);
		make.bottom.equalTo(cardpersonview.superview.mas_bottom).offset(-30);
	}];
	
	//白色背框
	UIImageView *imagewhitebg = [[UIImageView alloc] init];
	imagewhitebg.backgroundColor = [UIColor whiteColor];
	[cardpersonview addSubview:imagewhitebg];
	[imagewhitebg mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(cardpersonview.mas_top).offset(30);
		make.height.equalTo(@120);
		make.left.right.mas_equalTo(scrollview);
		
	}];
	
	UILabel *labeltitle = [[UILabel alloc] init];
	labeltitle.textColor = COLORNOW(72, 72, 72);
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.text = @"上传本人手持身份证照片";
	labeltitle.font = FONTN(13.0f);
	[cardpersonview addSubview:labeltitle];
	[labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@230);
		make.top.mas_equalTo(cardpersonview.mas_top).offset(5);
		make.left.mas_equalTo(cardpersonview.mas_left).offset(10);
	}];
	
	UIImageView *imageaddcard1 = [[UIImageView alloc] init];
	imageaddcard1.image = LOADIMAGE(@"regiest_addpic", @"png");

	imageaddcard1.userInteractionEnabled = YES;
	imageaddcard1.tag = EnRegiestCardPersonPicTag3;
	[cardpersonview addSubview:imageaddcard1];
	[imageaddcard1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(15);
		make.size.mas_equalTo(CGSizeMake(140, 92));
		make.left.mas_equalTo(imagewhitebg.mas_left).offset(10);
	}];
	
	//认证要求
	UILabel *labelyaoqiu = [[UILabel alloc] init];
	labelyaoqiu.backgroundColor = [UIColor clearColor];
	labelyaoqiu.textColor = COLORNOW(244, 160, 27);
	labelyaoqiu.font = FONTN(12.0f);
	labelyaoqiu.text = @"认证要求:";
	[cardpersonview addSubview:labelyaoqiu];
	[labelyaoqiu mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(130, 15));
		make.top.mas_equalTo(imageaddcard1.mas_top).offset(-2);
		make.left.mas_equalTo(imageaddcard1.mas_right).offset(10);
		
	}];
	
	
	UILabel *labelyaoqiu1 = [[UILabel alloc] init];
	labelyaoqiu1.backgroundColor = [UIColor clearColor];
	labelyaoqiu1.textColor = COLORNOW(244, 160, 27);
	labelyaoqiu1.font = FONTN(11.0f);
	labelyaoqiu1.textAlignment = NSTextAlignmentCenter;
	labelyaoqiu1.layer.cornerRadius = 2.0f;
	labelyaoqiu1.layer.borderColor = COLORNOW(244, 160, 27).CGColor;
	labelyaoqiu1.layer.borderWidth = 0.5f;
	labelyaoqiu1.text = @"本人上身免冠照";
	[cardpersonview addSubview:labelyaoqiu1];
	[labelyaoqiu1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(90, 15));
		make.top.mas_equalTo(labelyaoqiu.mas_bottom).offset(5);
		make.left.mas_equalTo(labelyaoqiu.mas_left);
		
	}];
	
	UILabel *labelyaoqiu2 = [[UILabel alloc] init];
	labelyaoqiu2.backgroundColor = [UIColor clearColor];
	labelyaoqiu2.textColor = COLORNOW(244, 160, 27);
	labelyaoqiu2.font = FONTN(11.0f);
	labelyaoqiu2.layer.cornerRadius = 2.0f;
	labelyaoqiu2.textAlignment = NSTextAlignmentCenter;
	labelyaoqiu2.layer.borderColor = COLORNOW(244, 160, 27).CGColor;
	labelyaoqiu2.layer.borderWidth = 0.5f;
	labelyaoqiu2.text = @"五冠清晰可见";
	[cardpersonview addSubview:labelyaoqiu2];
	[labelyaoqiu2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(75, 15));
		make.top.mas_equalTo(labelyaoqiu1.mas_bottom).offset(5);
		make.left.mas_equalTo(labelyaoqiu1.mas_left);
		
	}];
	
	UILabel *labelyaoqiu3 = [[UILabel alloc] init];
	labelyaoqiu3.backgroundColor = [UIColor clearColor];
	labelyaoqiu3.textColor = COLORNOW(244, 160, 27);
	labelyaoqiu3.font = FONTN(11.0f);
	labelyaoqiu3.layer.cornerRadius = 2.0f;
	labelyaoqiu3.textAlignment = NSTextAlignmentCenter;
	labelyaoqiu3.layer.borderColor = COLORNOW(244, 160, 27).CGColor;
	labelyaoqiu3.layer.borderWidth = 0.5f;
	labelyaoqiu3.text = @"身份证号码清晰可见";
	[cardpersonview addSubview:labelyaoqiu3];
	[labelyaoqiu3 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(110, 15));
		make.top.mas_equalTo(labelyaoqiu2.mas_bottom).offset(5);
		make.left.mas_equalTo(labelyaoqiu1.mas_left);
		
	}];
	
	UIButton *btlookpic = [UIButton buttonWithType:UIButtonTypeCustom];
	[btlookpic setImage:LOADIMAGE(@"regiest_pic1", @"png") forState:UIControlStateNormal];
	[btlookpic setTitle:@"查看示例照片" forState:UIControlStateNormal];
	[btlookpic setTitleEdgeInsets:UIEdgeInsetsMake(0, -70, 0, 0)];
	[btlookpic setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
	btlookpic.titleLabel.font = FONTN(12.0f);
	[btlookpic setBackgroundColor:[UIColor clearColor]];
	[btlookpic addTarget:self action:@selector(lookpic:) forControlEvents:UIControlEventTouchUpInside];
	[btlookpic setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
	[cardpersonview addSubview:btlookpic];
	[btlookpic mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(labelyaoqiu3.mas_left);
		make.size.mas_equalTo(CGSizeMake(150, 15));
		make.top.mas_equalTo(labelyaoqiu3.mas_bottom).offset(3);
	}];
	
//	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
//	btnext.backgroundColor = COLORNOW(27, 130, 210);
//	[btnext setTitle:@"提交审核" forState:UIControlStateNormal];
//	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	btnext.titleLabel.font = FONTN(15.0f);
//	btnext.layer.cornerRadius= 2.0f;
//	btnext.clipsToBounds = YES;
//	[btnext addTarget:self action:@selector(clickregiest) forControlEvents:UIControlEventTouchUpInside];
//	[cardpersonview addSubview:btnext];
//	[btnext mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(imagewhitebg.mas_left).with.offset(10);
//		make.right.mas_equalTo(imagewhitebg.mas_right).with.offset(-10);
//		make.top.mas_equalTo(imagewhitebg.mas_bottom).with.offset(20);
//		make.height.mas_equalTo(@40);
//	}];
	
	
	return cardpersonview;
}

-(UIView *)inputuserinfo:(UIScrollView *)scrollview
{
	UIView *viewinput = [[UIView alloc] init];
	viewinput.backgroundColor = [UIColor whiteColor];
	[scrollview addSubview:viewinput];
	[viewinput mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@80);
		make.width.equalTo(@SCREEN_WIDTH);
		make.left.top.right.mas_equalTo(scrollview);
	}];
	
	UILabel *imageline = [[UILabel alloc] init];
	imageline.backgroundColor = COLORNOW(225, 225, 225);
	[viewinput addSubview:imageline];
	[imageline mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@1);
		make.top.mas_equalTo(viewinput.mas_top).offset(40);
		make.left.mas_equalTo(viewinput.mas_left).offset(10);
		make.right.mas_equalTo(viewinput.mas_right);
	}];
	
	UILabel *labelname = [[UILabel alloc] init];
	labelname.textColor = COLORNOW(4, 4, 4);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.text = @"真实姓名";
	labelname.font = FONTN(14.0f);
	[viewinput addSubview:labelname];
	[labelname mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@60);
		make.top.mas_equalTo(viewinput.mas_top).offset(10);
		make.left.mas_equalTo(viewinput.mas_left).offset(10);
	}];
	
	UILabel *labelcode = [[UILabel alloc] init];
	labelcode.textColor = COLORNOW(4, 4, 4);
	labelcode.backgroundColor = [UIColor clearColor];
	labelcode.text = @"身份证号";
	labelcode.font = FONTN(14.0f);
	[viewinput addSubview:labelcode];
	[labelcode mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(labelname);
		make.top.mas_equalTo(imageline.mas_bottom).offset(10);
		make.left.mas_equalTo(labelname.mas_left);
	}];
	
	
	UITextField *textfieldname = [[UITextField alloc] init];
	textfieldname.backgroundColor = [UIColor clearColor];
	textfieldname.placeholder = @"请输入身份证上的姓名";
	textfieldname.font = FONTN(14.0f);
	textfieldname.delegate = self;
	UIView *leftview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldname.leftView = leftview1;
	textfieldname.leftViewMode = UITextFieldViewModeAlways;
	textfieldname.tag = EnRegiestCarRealNameTextFieldTag;
	[viewinput addSubview:textfieldname];
	[textfieldname mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(labelname.mas_right).with.offset(10);
		make.right.mas_equalTo(viewinput.mas_right).offset(-20);
		make.height.equalTo(@30);
		make.top.mas_equalTo(viewinput.mas_top).offset(5);
		
	}];
	
	UITextField *textfieldcode = [[UITextField alloc] init];
	textfieldcode.backgroundColor = [UIColor clearColor];
	textfieldcode.placeholder = @"请输入身份证号";
	textfieldcode.font = FONTN(14.0f);
	textfieldcode.delegate = self;
	UIView *leftview2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldcode.leftView = leftview2;
	textfieldcode.leftViewMode = UITextFieldViewModeAlways;
	textfieldcode.tag = EnRegiestCardNumberTextFieldTag;
	[viewinput addSubview:textfieldcode];
	[textfieldcode mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(textfieldname);
		make.height.equalTo(@30);
		make.left.mas_equalTo(textfieldname.mas_left);
		make.top.mas_equalTo(imageline.mas_top).offset(5);
		
	}];
	
	
	
	return viewinput;
	
}


-(UIView *)cardpic:(UIView *)inpuview Scrollview:(UIScrollView *)scrollview
{
	UIView *cardpicview = [[UIView alloc] init];
	cardpicview.backgroundColor = [UIColor clearColor];
	[scrollview addSubview:cardpicview];
	[cardpicview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(@300);
		make.top.mas_equalTo(inpuview.mas_bottom);
		make.left.right.mas_equalTo(scrollview);
	}];
	
	//白色背框
	UIImageView *imagewhitebg = [[UIImageView alloc] init];
	imagewhitebg.backgroundColor = [UIColor whiteColor];
	[cardpicview addSubview:imagewhitebg];
	[imagewhitebg mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(cardpicview.mas_top).offset(30);
		make.height.equalTo(@200);
		make.left.right.mas_equalTo(scrollview);
	}];
	
	UILabel *labeltitle = [[UILabel alloc] init];
	labeltitle.textColor = COLORNOW(72, 72, 72);
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.text = @"上传身份证正反面照片";
	labeltitle.font = FONTN(13.0f);
	[cardpicview addSubview:labeltitle];
	[labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@20);
		make.width.equalTo(@230);
		make.top.mas_equalTo(cardpicview.mas_top).offset(5);
		make.left.mas_equalTo(cardpicview.mas_left).offset(10);
	}];
	//
	UIImageView *imageattention = [[UIImageView alloc] init];
	imageattention.backgroundColor = [UIColor whiteColor];
	imageattention.image = LOADIMAGE(@"regiest_attention", @"png");
	[cardpicview addSubview:imageattention];
	[imageattention mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(10);
		make.size.mas_equalTo(CGSizeMake(11, 15));
		make.left.mas_equalTo(scrollview).offset(10);
	}];
	float nowheight = 10;
	NSString *nstr = @"一张身份证只能绑定一个手机码号，为了您的帐户安全，请务必使用本人身份进行实名认证。 请上传原始比例的身份证正反面，请勿裁剪涂改，保证身份信息清晰完整显示，否则无法通过审核。";
	
	CGSize size =  [AddInterface getlablesize:nstr Fwidth:SCREEN_WIDTH-40 Fheight:200 Sfont:FONTN(12.0f)];
	DLog(@"size====%f",size.height);
	UILabel *labelinfo = [[UILabel alloc] init];
	labelinfo.text = nstr;
	labelinfo.font = FONTN(12.0f);
	labelinfo.numberOfLines = 0;
	labelinfo.textColor = COLORNOW(172, 172, 172);
	[cardpicview addSubview:labelinfo];
	[labelinfo mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imageattention.mas_top);
		make.size.mas_equalTo(size);
		make.left.mas_equalTo(imageattention.mas_right).offset(5);
	}];
	nowheight = nowheight+size.height+10;
	
	//添加card
	UIImageView *imageaddcard1 = [[UIImageView alloc] init];
	imageaddcard1.image = LOADIMAGE(@"regiest_addpic", @"png");

	imageaddcard1.userInteractionEnabled = YES;
	imageaddcard1.tag = EnRegiestCardPersonPicTag1;
	[cardpicview addSubview:imageaddcard1];
	[imageaddcard1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(nowheight);
		make.size.mas_equalTo(CGSizeMake(130, 86));
		make.left.mas_equalTo((SCREEN_WIDTH-130*2-20)/2);
	}];
	
	UIImageView *imageaddcard2 = [[UIImageView alloc] init];
	imageaddcard2.image = LOADIMAGE(@"regiest_addpic", @"png");
		imageaddcard2.userInteractionEnabled = YES;
	imageaddcard2.tag = EnRegiestCardPersonPicTag2;
	[cardpicview addSubview:imageaddcard2];
	[imageaddcard2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imageaddcard1.mas_top);
		make.size.mas_equalTo(imageaddcard1);
		make.left.mas_equalTo(imageaddcard1.mas_right).offset(20);
	}];
	
	nowheight = nowheight+86+20;
	
	//身份证示例
	UIImageView *imagecard11 = [[UIImageView alloc] init];
	imagecard11.image = LOADIMAGE(@"regiest_card1", @"png");
	[cardpicview addSubview:imagecard11];
	[imagecard11 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imagewhitebg.mas_top).offset(nowheight);
		make.size.mas_equalTo(CGSizeMake(80, 50));
		make.left.mas_equalTo(imageaddcard1.mas_centerX).offset(-40);
	}];
	
	UIImageView *imagecard22 = [[UIImageView alloc] init];
	imagecard22.image = LOADIMAGE(@"regiest_card2", @"png");
	[cardpicview addSubview:imagecard22];
	[imagecard22 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(imagecard11.mas_top);
		make.size.mas_equalTo(imagecard11);
		make.left.mas_equalTo(imageaddcard2.mas_centerX).offset(-40);
	}];
	
	nowheight = nowheight+ 50+10;
	[imagewhitebg mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(cardpicview.mas_top).offset(30);
		make.height.mas_equalTo(nowheight);
		make.left.right.mas_equalTo(scrollview);
	}];
	
	[cardpicview mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(nowheight+30);
		make.top.mas_equalTo(inpuview.mas_bottom);
		make.left.right.mas_equalTo(scrollview);
	}];
	
	
	return cardpicview;
}



-(UIView *)topnumber
{
	UIView *viewtopphone = [[UIView alloc] init];
	viewtopphone.backgroundColor = [UIColor clearColor];
	viewtopphone.tag = EnRegiestTopView;
	[self.view addSubview:viewtopphone];
	[viewtopphone mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view.mas_left);
		make.top.mas_equalTo(self.view.mas_top);
		make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
	}];
	
	
	UILabel *labdes = [[UILabel alloc] init];
	labdes.textColor = COLORNOW(187, 187, 187);
	labdes.backgroundColor = [UIColor clearColor];
	labdes.numberOfLines = 3;
	labdes.text = @"提醒：为了您的帐户安全，提现时会随机验证您的账户认证信息，请务必用本人身份证进行实名认证。\n(一个身份证只能绑定一个手机号码)";
	labdes.font = FONTN(13.0f);
	
	[viewtopphone addSubview:labdes];
	[labdes mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@50);
		make.width.equalTo(@(SCREEN_WIDTH-30));
		make.top.mas_equalTo(viewtopphone.mas_top).offset(10);
		make.left.mas_equalTo(viewtopphone.mas_left).offset(10);
	}];
	
	
	
	
	
	return viewtopphone;
}


#pragma  IBAction

-(void)photoTappednews:(UIGestureRecognizer*)sender
{
	//	UIView *viewtemp = sender.view;
	
	[[self.view viewWithTag:EnViewLookImage] removeFromSuperview];
}


-(void)lookpic:(id)sender
{
	UIView *viewlookimage = [[UIView alloc] init];
	viewlookimage.backgroundColor = [UIColor clearColor];
	viewlookimage.tag = EnViewLookImage;
	[self.view addSubview:viewlookimage];
	
	[viewlookimage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.bottom.right.mas_equalTo(self);
		
	}];
	
	UIImageView *imageview = [[UIImageView alloc] init];
	imageview.backgroundColor = COLORNOW(20, 20, 20);
	imageview.alpha = 0.8;
	imageview.userInteractionEnabled = YES;
	imageview.clipsToBounds = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappednews:)];
	[imageview addGestureRecognizer:singleTap];
	[viewlookimage addSubview:imageview];
	[imageview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.bottom.right.mas_equalTo(viewlookimage);
	}];
	
	UIImageView *imageviewpic = [[UIImageView alloc] init];
	imageviewpic.backgroundColor = COLORNOW(20, 20, 20);
	imageviewpic.image = LOADIMAGE(@"regiest_testpic4", @"png");
	[viewlookimage addSubview:imageviewpic];
	[imageviewpic mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(180, 218));
		make.centerX.mas_equalTo(self.view);
		make.centerY.mas_equalTo(self.view);
	}];
	
	UIButton *btclose = [UIButton buttonWithType:UIButtonTypeCustom];
	[btclose setImage:LOADIMAGE(@"regiest_closepic", @"png") forState:UIControlStateNormal];
	[btclose addTarget:self action:@selector(photoTappednews:) forControlEvents:UIControlEventTouchUpInside];
	[viewlookimage addSubview:btclose];
	[btclose mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(40, 40));
		make.centerX.mas_equalTo(self.view);
		make.top.mas_equalTo(imageviewpic.mas_bottom).offset(10);
		
	}];
	
}

#pragma mark UItextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 获取验证码
-(void)getcertificationinfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001002004" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dictemp = [[dic objectForKey:@"data"] objectForKey:@"useridentifyinfo"];
			 UITextField *textfield1 = [self.view viewWithTag:EnRegiestCarRealNameTextFieldTag];
			 UITextField *textfield2 = [self.view viewWithTag:EnRegiestCardNumberTextFieldTag];
			 UIImageView *imageview1 = [self.view viewWithTag:EnRegiestCardPersonPicTag1];
			 UIImageView *imageview2 = [self.view viewWithTag:EnRegiestCardPersonPicTag2];
			 UIImageView *imageview3 = [self.view viewWithTag:EnRegiestCardPersonPicTag3];
			 
			 textfield1.text = [dictemp objectForKey:@"realname"];
			 textfield2.text = [dictemp objectForKey:@"personcardid"];
			 NSURL *urlstr1 = [NSURL URLWithString:[dictemp objectForKey:@"personidcard1"]];
			 [imageview1 setImageWithURL:urlstr1 placeholderImage:LOADIMAGE(@"testpic2", @"png")];

			 NSURL *urlstr2 = [NSURL URLWithString:[dictemp objectForKey:@"personidcard2"]];
			 [imageview2 setImageWithURL:urlstr2 placeholderImage:LOADIMAGE(@"testpic2", @"png")];
			 
			 NSURL *urlstr3 = [NSURL URLWithString:[dictemp objectForKey:@"personidcardwithperson"]];
			 [imageview3 setImageWithURL:urlstr3 placeholderImage:LOADIMAGE(@"testpic2", @"png")];
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
