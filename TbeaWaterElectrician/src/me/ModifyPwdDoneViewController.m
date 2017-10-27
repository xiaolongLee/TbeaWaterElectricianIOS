//
//  ModifyPwdDoneViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ModifyPwdDoneViewController.h"

@interface ModifyPwdDoneViewController ()

@end

@implementation ModifyPwdDoneViewController

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	UIImage* img=LOADIMAGE(@"123", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
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
	self.title = @"绑定完成";
	
	UIImageView *imageviewdone = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2,30, 100, 100)];
	imageviewdone.image = LOADIMAGE(@"me_tixiandone", @"png");
	[self.view addSubview:imageviewdone];
	
	UILabel *labeldone = [[UILabel alloc] initWithFrame:CGRectMake(20, imageviewdone.frame.origin.y+imageviewdone.frame.size.height+30, SCREEN_WIDTH-40, 20)];
	labeldone.textColor = ColorBlackdeep;
	labeldone.font = FONTN(16.0f);
	labeldone.text = @"绑定成功";
	labeldone.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labeldone];
	
	UILabel *labellogin = [[UILabel alloc] initWithFrame:CGRectMake(20, labeldone.frame.origin.y+labeldone.frame.size.height+30, SCREEN_WIDTH-40, 20)];
	labellogin.textColor = ColorBlackGray;
	labellogin.font = FONTN(13.0f);
	labellogin.text = @"请重新登录";
	labellogin.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labellogin];
	
	
	UIButton *btlogin = [UIButton buttonWithType:UIButtonTypeCustom];
	btlogin.frame = CGRectMake(40, labellogin.frame.origin.y+labellogin.frame.size.height+30, SCREEN_WIDTH-80, 35);
	btlogin.backgroundColor = COLORNOW(27, 130, 210);
	[btlogin setTitle:@"重新登录" forState:UIControlStateNormal];
	[btlogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btlogin.titleLabel.font = FONTN(15.0f);
	[btlogin addTarget:self action:@selector(gotologin:) forControlEvents:UIControlEventTouchUpInside];
	btlogin.layer.cornerRadius= 2.0f;
	btlogin.clipsToBounds = YES;
	[self.view addSubview:btlogin];
	
	//	[self getmyincome:@"1" Pagesize:@"10"];
	
}

#pragma mark IBAction
-(void)gotologin:(id)sender
{
	NSFileManager *filemanger = [NSFileManager defaultManager];
	[filemanger removeItemAtPath:UserMessage error:nil];
	[self.navigationController popToRootViewControllerAnimated:YES];
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
