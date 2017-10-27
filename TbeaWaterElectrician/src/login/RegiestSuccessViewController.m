//
//  RegiestSuccessViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "RegiestSuccessViewController.h"

@interface RegiestSuccessViewController ()

@end

@implementation RegiestSuccessViewController

-(void)returnback
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];

	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
	
	UILabel *labdes = [[UILabel alloc] init];
	labdes.textColor = [UIColor whiteColor];
	labdes.backgroundColor = [UIColor clearColor];
	labdes.text = @"注册成功";
	labdes.textAlignment = NSTextAlignmentCenter;
	labdes.font = FONTN(16.0f);
	labdes.frame = CGRectMake(70, 32, SCREEN_WIDTH-140, 20);
	[self.view addSubview:labdes];
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIImageView *imageviewdone = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 64+30, 80, 80)];
	imageviewdone.image = LOADIMAGE(@"regiestdone", @"png");
	[self.view addSubview:imageviewdone];
	
	UILabel *labeldone = [[UILabel alloc] initWithFrame:CGRectMake(10, imageviewdone.frame.origin.y+imageviewdone.frame.size.height+10, SCREEN_WIDTH-20, 20)];
	labeldone.textColor = ColorBlackdeep;
	labeldone.font = FONTN(15.0f);
	labeldone.text = @"注册成功";
	labeldone.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labeldone];
	
	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
	btnext.backgroundColor = COLORNOW(27, 130, 210);
	[btnext setTitle:@"确认" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	btnext.layer.cornerRadius= 2.0f;
	btnext.frame = CGRectMake(15, labeldone.frame.origin.y+labeldone.frame.size.height+40, SCREEN_WIDTH-30, 35);
	btnext.clipsToBounds = YES;
	[btnext addTarget:self action:@selector(getnextstep:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnext];
	
	UILabel *labeltishi = [[UILabel alloc] initWithFrame:CGRectMake(btnext.frame.origin.x, btnext.frame.origin.y+btnext.frame.size.height+20, btnext.frame.size.width, 80)];
	labeltishi.textColor = COLORNOW(187, 187, 187);
	labeltishi.font = FONTN(14.0f);
	labeltishi.numberOfLines = 4;
	labeltishi.text = @"特别提示:\n为了您帐户安全,扫码返利提现需实名认证；也为了方便您能及时的提取现金，请提前准备好相关的证件进行实名认证";
	[self.view addSubview:labeltishi];
	
	
	UIButton *btgotocer = [UIButton buttonWithType:UIButtonTypeCustom];
	btgotocer.backgroundColor = [UIColor clearColor];
	[btgotocer setTitle:@"前往认证" forState:UIControlStateNormal];
	[btgotocer setTitleColor:ColorBlue forState:UIControlStateNormal];
	btgotocer.titleLabel.font = FONTN(14.0f);
	btgotocer.frame = CGRectMake(labeltishi.frame.origin.x, labeltishi.frame.origin.y+labeltishi.frame.size.height, 160, 25);
	btgotocer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[btgotocer addTarget:self action:@selector(clickgotocer:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btgotocer];
	
	UIButton *bttel = [UIButton buttonWithType:UIButtonTypeCustom];
	bttel.backgroundColor = [UIColor clearColor];
	bttel.frame = CGRectMake(btgotocer.frame.origin.x, btgotocer.frame.origin.y+btgotocer.frame.size.height, 200, 25);
	[bttel setTitle:[NSString stringWithFormat:@"热线电话:%@",self.strtel] forState:UIControlStateNormal];
	[bttel setTitleColor:COLORNOW(187, 187, 187) forState:UIControlStateNormal];
	bttel.titleLabel.font = FONTN(14.0f);
	[bttel addTarget:self action:@selector(clicktel:) forControlEvents:UIControlEventTouchUpInside];
	bttel.tag = EnHotPhoneBtTag;
	bttel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[self.view addSubview:bttel];

}

-(void)getnextstep:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)clickgotocer:(id)sender
{
	CertificationViewController *certification = [[CertificationViewController alloc] init];
	certification.fromflag = @"1";
	[self.navigationController pushViewController:certification animated:YES];
}

-(void)clicktel:(id)sender
{
//	UIButton *button =(UIButton *)sender;
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.strtel];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
