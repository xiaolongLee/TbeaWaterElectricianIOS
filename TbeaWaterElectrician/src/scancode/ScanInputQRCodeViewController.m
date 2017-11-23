//
//  ScanInputQRCodeViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanInputQRCodeViewController.h"

@interface ScanInputQRCodeViewController ()

@end

@implementation ScanInputQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
	labeltitle.text = @"手工输入";
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
	
	[self initviewroot]; //初始化手工输入页面
}

-(void)initviewroot
{
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 190, 20)];
	labeltitle.text = @"输入二维码编号";
	labeltitle.font = FONTN(14.0f);
	labeltitle.textColor = ColorBlackGray;
	[self.view addSubview:labeltitle];
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, labeltitle.frame.origin.y+labeltitle.frame.size.height+3,SCREEN_WIDTH-40,35)];
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.layer.borderColor = ColorBlackGray.CGColor;
	textfield1.layer.borderWidth = 0.5f;
	textfield1.layer.cornerRadius = 1.0f;
	textfield1.clipsToBounds = YES;
	textfield1.placeholder = @"输入编码";
	UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield1.leftView = leftview;
	textfield1.leftViewMode = UITextFieldViewModeAlways;
	textfield1.font = FONTN(15.0f);
	textfield1.delegate = self;
	textfield1.tag = EnScanQRTextfieldTag;
	[self.view addSubview:textfield1];
	
	UIButton *btdone = [UIButton buttonWithType:UIButtonTypeCustom];
	btdone.frame = CGRectMake(textfield1.frame.origin.x, textfield1.frame.origin.y+textfield1.frame.size.height+10, textfield1.frame.size.width, 35);
	[btdone setTitle:@"确定" forState:UIControlStateNormal];
	btdone.backgroundColor = ColorBlue;
	btdone.layer.cornerRadius = 2.0f;
	[btdone addTarget:self action:@selector(clickinputdon) forControlEvents:UIControlEventTouchUpInside];
	btdone.titleLabel.font = FONTN(15.0f);
	[btdone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.view addSubview:btdone];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickinputdon
{
	UITextField *textfield = [self.view viewWithTag:EnScanQRTextfieldTag];
	[textfield resignFirstResponder];
	if([textfield.text length]>0)
	{
		[self getscancode:[NSString stringWithFormat:@"tbscrfl_%@",textfield.text]];
	}
	else
	{
		[MBProgressHUD showError:@"请输入输入二维码编号" toView:self.view];
	}
}

#pragma mark 接口
#pragma mark 接口
-(void)getscancode:(NSString *)scancode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:scancode forKey:@"scancode"];
    [params setObject:[NSString stringWithFormat:@"%@ %@ %@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality] forKey:@"address"];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG006000001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
                                          Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             NSString *dicqrtype = [[[dic objectForKey:@"data"] objectForKey:@"qrtypeinfo"] objectForKey:@"qrtype"];
             if([dicqrtype isEqualToString:@"verifytbeaproduct"])  //扫码溯源
             {
                 ScanOrginDetailViewController *scanorgin = [[ScanOrginDetailViewController alloc] init];
                 scanorgin.scancode = scancode;
                 [self.navigationController pushViewController:scanorgin animated:YES];
             }
             else if([dicqrtype isEqualToString:@"scanrebate"]) //扫码返利
             {
                 ScanRebateViewController *scanrebate = [[ScanRebateViewController alloc] init];
                 scanrebate.scancode = scancode;
                 scanrebate.fromflag = 1;
                 [self.navigationController pushViewController:scanrebate animated:YES];
             }
             else if([dicqrtype isEqualToString:@"meetingcheckin"]) //签到
             {
                 ScanSignInViewController *scansignin = [[ScanSignInViewController alloc] init];
                 scansignin.FCscancode = scancode;
                 [self.navigationController pushViewController:scansignin animated:YES];
             }
             
         }
         else
         {
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
             //[self donecodevalid:[dic objectForKey:@"msg"]];
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
