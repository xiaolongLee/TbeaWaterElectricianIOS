//
//  ScanSignInViewController.m
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanSignInViewController.h"

@interface ScanSignInViewController ()

@end

@implementation ScanSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initview];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
//    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
//    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
//    buttonright.titleLabel.font = FONTN(14.0f);
//    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [buttonright setTitle:@"查看" forState:UIControlStateNormal];
//    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
//    [buttonright addTarget:self action: @selector(ClickLook:) forControlEvents: UIControlEventTouchUpInside];
//    [contentViewright addSubview:buttonright];
//    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
//    self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}



-(void)initview
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"签到成功";
    //初始化注册按钮之上
    
    
    //
    [self getsignininfocode];
    
}

-(void)initviewtopsuccess:(NSString *)checkmsg CheckStatus:(NSString *)status
{
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 50, 70, 70)];
    imageviewicon.image = LOADIMAGE(@"scanqrpaydone", @"png");
    if([status isEqualToString:@"2"])
        imageviewicon.image = LOADIMAGE(@"签到失败", @"png");
    [self.view addSubview:imageviewicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2,imageviewicon.frame.origin.y+imageviewicon.frame.size.height+10, 200, 20)];
    labelname.text = checkmsg;
    labelname.font = FONTN(15.0f);
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor blackColor];
    [self.view addSubview:labelname];
    
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.origin.y+labelname.frame.size.height+20, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(227, 227, 227);
    [self.view addSubview:imageline];
    
    
    NSString *strins = [NSString stringWithFormat:@"状态\n签到时间:%@\n签到地点:%@",[FCdicdata objectForKey:@"checkintime"],[FCdicdata objectForKey:@"checkinplace"]];
    CGSize size = [AddInterface getlablesize:strins Fwidth:SCREEN_WIDTH-30 Fheight:200 Sfont:FONTN(14.0f)];
    
    NSMutableAttributedString *attributedString= [AddInterface getlabelspage:strins Space:3];
    
    UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(20, imageline.frame.origin.y+imageline.frame.size.height+10, size.width, size.height)];
    labelins.text =strins;
    labelins.font = FONTN(14.0f);
    [labelins setAttributedText:attributedString];
    labelins.backgroundColor = [UIColor clearColor];
    labelins.numberOfLines = 0;
    [labelins sizeToFit];
    labelins.textColor = COLORNOW(172, 172, 172);
    [self.view addSubview:labelins];
    
}

-(void)initviewtopfaile:(NSString *)strmsg
{
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 50, 70, 70)];
    imageviewicon.image = LOADIMAGE(@"签到失败", @"png");;
    [self.view addSubview:imageviewicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-260)/2,imageviewicon.frame.origin.y+imageviewicon.frame.size.height+10, 260, 40)];
    labelname.text = strmsg;
    labelname.font = FONTN(15.0f);
    labelname.numberOfLines = 2;
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor blackColor];
    [self.view addSubview:labelname];
    
}

-(void)initviewunder
{
    UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonloging.frame = CGRectMake(30, SCREEN_HEIGHT-64-80, SCREEN_WIDTH-60, 40);
    buttonloging.layer.cornerRadius = 3.0f;
    buttonloging.backgroundColor = COLORNOW(0, 170, 238);
    buttonloging.clipsToBounds = YES;
    [buttonloging setTitle:@"完成" forState:UIControlStateNormal];
    [buttonloging addTarget:self action:@selector(clickdone) forControlEvents:UIControlEventTouchUpInside];
    [buttonloging setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonloging.titleLabel.font = FONTN(16.0f);
    [self.view addSubview:buttonloging];
}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdone
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ClickLook:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 接口
-(void)getsignininfocode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_FCscancode forKey:@"scancode"];
    [params setObject:[NSString stringWithFormat:@"%@ %@ %@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality] forKey:@"address"];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG00500201003" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
     Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             FCdicdata = [[dic objectForKey:@"data"] objectForKey:@"meetingcheckininfo"];
             [self initviewtopsuccess:[dic objectForKey:@"msg"] CheckStatus:[NSString stringWithFormat:@"%@",[FCdicdata objectForKey:@"checkstatus"]]];
             
             //初始化按钮之下
             [self initviewunder];
         }
         else
         {
            // [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
             [self initviewtopfaile:[dic objectForKey:@"msg"]];
             //初始化按钮之下
             [self initviewunder];
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
