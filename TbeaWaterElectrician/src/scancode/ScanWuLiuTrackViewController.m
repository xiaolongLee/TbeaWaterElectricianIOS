//
//  ScanWuLiuTrackViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanWuLiuTrackViewController.h"

@interface ScanWuLiuTrackViewController ()

@end

@implementation ScanWuLiuTrackViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	
	//扫码记录
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
	labeltitle.text = @"物流跟踪";
	labeltitle.font = FONTN(17.0f);
	labeltitle.textAlignment = NSTextAlignmentCenter;
	labeltitle.textColor = [UIColor whiteColor];
	[self.view addSubview:labeltitle];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
	

}

//-()

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
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
