//
//  EvaluationViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "EvaluationViewController.h"

@interface EvaluationViewController ()

@end

@implementation EvaluationViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
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
	[buttonright addTarget:self action: @selector(saveevaluation:) forControlEvents: UIControlEventTouchUpInside];
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
	self.title = @"评价";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	EvaluationHeaderView *evaluation = [[EvaluationHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) Dic:self.diccommdity FromFlag:@"1"];
	[self.view addSubview:evaluation];
	
	UIImageView *imagebg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, evaluation.frame.origin.y+evaluation.frame.size.height+3, SCREEN_WIDTH, 800)];
	imagebg1.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:imagebg1];
	
	UIImageView *imagexin = [[UIImageView alloc] initWithFrame:CGRectMake(20, evaluation.frame.origin.y+evaluation.frame.size.height+10, 140, 25)];
	imagexin.image = LOADIMAGE(@"5xin", @"png");
	imagexin.tag = EnImageXingImageviewtag;
	[self.view addSubview:imagexin];
	
	nowxing = 5;
	
	for(int i=0;i<5;i++)
	{
		UIButton *buttonselect = [[UIButton alloc] initWithFrame:CGRectMake(imagexin.frame.origin.x+30*i-3, imagexin.frame.origin.y, 27, 25)];
		buttonselect.backgroundColor = [UIColor clearColor];
		buttonselect.tag = EnButtonXinTag+i;
		[buttonselect addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchDown];
		[self.view addSubview:buttonselect];
	}
	
	UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(imagexin.frame.origin.x,imagexin.frame.origin.y+imagexin.frame.size.height+10, SCREEN_WIDTH-40, 80)];
	textview.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	textview.layer.borderWidth = 0.5f;
	textview.font = FONTN(14.0f);
	textview.delegate = self;
	textview.tag = EnEvaluationTextViewTag;
	[self.view addSubview:textview];
	
	
}

-(void)saveevaluation:(id)sender
{
	UITextView *textview = [self.view viewWithTag:EnEvaluationTextViewTag];
	if([textview.text length] == 0)
	{
		[MBProgressHUD showError:@"请填写评价信息" toView:self.view];
	}
	else
	{
		[self gotoevaluation:textview.text XingLevel:[NSString stringWithFormat:@"%d",nowxing] CommodityId:[self.diccommdity objectForKey:@"commodityid"]];
	}
}

-(void)clickbt:(id)sender
{
	UIButton *bt = (UIButton *)sender;
	UIImageView *imagexin = (UIImageView *)[self.view viewWithTag:EnImageXingImageviewtag];
	int tagnow = (int)[bt tag] - EnButtonXinTag;
	nowxing = tagnow+1;
	switch (tagnow)
	{
		case 0:
			imagexin.image = LOADIMAGE(@"1xin", @"png");
			break;
		case 1:
			imagexin.image = LOADIMAGE(@"2xin", @"png");
			break;
		case 2:
			imagexin.image = LOADIMAGE(@"3xin", @"png");
			break;
		case 3:
			imagexin.image = LOADIMAGE(@"4xin", @"png");
			break;
		case 4:
			imagexin.image = LOADIMAGE(@"5xin", @"png");
			break;
	}
}


#pragma mark 接口
-(void)gotoevaluation:(NSString *)appraise XingLevel:(NSString *)xinlevel CommodityId:(NSString *)comid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:comid forKey:@"commodityid"];
	[params setObject:xinlevel forKey:@"starlevel"];
	[params setObject:appraise forKey:@"appraise"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001099000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [self.navigationController popViewControllerAnimated:YES];
			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
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
