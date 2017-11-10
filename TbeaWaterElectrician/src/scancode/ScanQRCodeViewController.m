//
//  ScanQRCodeViewController.m
//  DiDi
//
//  Created by jaybin on 15/7/28.
//  Copyright (c) 2015年 jaybin. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "QRView.h"
#import "Masonry.h"
#import "UIColor+HEX.h"

#define IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]

#define LIGHTBUTTONTAG      200
#define IMPORTBUTTONTAG     201
#define IMPORTHisTory    202
#define ImageBgTag     203

@interface ScanQRCodeViewController (){
    ZBarReaderView *_readview;//扫描二维码ZBarReaderView
    QRView *_qrRectView;//自定义的扫描视图
    
    UIButton *_lightingBtn;//照明按钮
    UIButton *_importQRCodeImageBtn;//导入二维码图片按钮
    UIButton *_importQRCodeImage;
	UIButton *_HistoryQRCodeImageBtn; //历史记录
    UIImagePickerController *_picker;//系统相册视图
    
}

@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化扫描视图
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.navigationController setNavigationBarHidden:YES];
	codetype = EnToRebate;
    [self configuredZBarReader];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开始扫描
    [self setZBarReaderViewStart];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止扫描
    [self setZBarReaderViewStop];
}

/**
 *初始化扫描二维码对象ZBarReaderView
 *设置扫描二维码视图的窗口布局、参数
 */
-(void)configuredZBarReader{
    //初始化照相机窗口
    _readview = [[ZBarReaderView alloc] init];
    //设置扫描代理
    _readview.readerDelegate = self;
    //关闭闪光灯
    _readview.torchMode = 0;
    //显示帧率
    _readview.showsFPS = NO;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:_readview];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _readview.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    //Layout ZBarReaderView
    __weak __typeof(self) weakSelf = self;
    [_readview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
    }];
    
    //初始化扫描二维码视图的子控件
    [self configuredZBarReaderMaskView];
    
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    //[_readview start];
    //[_qrRectView startScan];
}


/**
 *自定义扫描二维码视图样式
 *初始化扫描二维码视图的子控件
 */
- (void)configuredZBarReaderMaskView{
	
	
    //扫描的矩形方框视图
    _qrRectView = [[QRView alloc] init];
    _qrRectView.transparentArea = CGSizeMake(SCREEN_WIDTH-100, SCREEN_WIDTH-100);
    _qrRectView.backgroundColor = [UIColor clearColor];
    [_readview addSubview:_qrRectView];
    [_qrRectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readview).with.offset(0);
        make.left.equalTo(_readview).with.offset(0);
        make.right.equalTo(_readview).with.offset(0);
        make.bottom.equalTo(_readview).with.offset(0);
    }];
	
//    UIImageView *imageviewselect = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-220)/2, (SCREEN_HEIGHT / 2 - (SCREEN_WIDTH-100) / 2 -40)-45, 220, 32)];
//    imageviewselect.tag = ImageBgTag;
//    imageviewselect.image = LOADIMAGE(@"QR_扫码返利", @"png");
//    [_qrRectView addSubview:imageviewselect];
	
//    UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonleft.frame = CGRectMake(imageviewselect.frame.origin.x, imageviewselect.frame.origin.y, imageviewselect.frame.size.width, imageviewselect.frame.size.height);
//    [buttonleft addTarget:self action:@selector(btclickleft:) forControlEvents:UIControlEventTouchUpInside];
//    [_qrRectView addSubview:buttonleft];
//
//    UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonright.frame = CGRectMake(imageviewselect.frame.origin.x+110, imageviewselect.frame.origin.y, imageviewselect.frame.size.width, imageviewselect.frame.size.height);
//    [buttonright addTarget:self action:@selector(btclickright:) forControlEvents:UIControlEventTouchUpInside];
//    [_qrRectView addSubview:buttonright];
	
	
	//手工输入
	UIButton *buttoninput = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttoninput setImage:LOADIMAGE(@"QR_手工输入", @"png") forState:UIControlStateNormal];
	[buttoninput addTarget:self action:@selector(btClickedinput:) forControlEvents:UIControlEventTouchUpInside];
	[_qrRectView addSubview:buttoninput];
	[buttoninput mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_qrRectView.top).offset((SCREEN_HEIGHT / 2 - (SCREEN_WIDTH-100) / 2 -40)+(SCREEN_WIDTH-100)+20);
		make.centerX.equalTo(_qrRectView);
		make.size.mas_equalTo(CGSizeMake(60, 38));
	}];
	
    //照明按钮
    _lightingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_lightingBtn setImage:LOADIMAGE(@"QR_电筒", @"png") forState:UIControlStateNormal];
    [_lightingBtn setBackgroundColor:[UIColor clearColor]];
    _lightingBtn.tag = LIGHTBUTTONTAG;
    [_lightingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_qrRectView addSubview:_lightingBtn];
    [_lightingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttoninput.mas_bottom).with.offset(30);
        make.centerX.equalTo(_qrRectView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
	

    //导入二维码图片
    _importQRCodeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_importQRCodeImageBtn setImage:LOADIMAGE(@"QR_相册", @"png") forState:UIControlStateNormal];
	[_importQRCodeImageBtn setBackgroundColor:[UIColor clearColor]];
    _importQRCodeImageBtn.tag = IMPORTBUTTONTAG;
    [_importQRCodeImageBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_qrRectView addSubview:_importQRCodeImageBtn];
    [_importQRCodeImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lightingBtn.mas_top);
        make.left.equalTo(_lightingBtn.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
	
	//历史记录
	_HistoryQRCodeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_HistoryQRCodeImageBtn setImage:LOADIMAGE(@"QR_历史", @"png") forState:UIControlStateNormal];
	[_HistoryQRCodeImageBtn setBackgroundColor:[UIColor clearColor]];
	_HistoryQRCodeImageBtn.tag = IMPORTHisTory;
	[_HistoryQRCodeImageBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_qrRectView addSubview:_HistoryQRCodeImageBtn];
	[_HistoryQRCodeImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_lightingBtn.mas_top);
		make.right.equalTo(_lightingBtn.mas_left).with.offset(-20);
		make.size.mas_equalTo(CGSizeMake(40, 40));
	}];
	
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"hp_colse", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[_readview addSubview:btreturn];
}

- (void)buttonClicked:(UIButton *)sender{
    switch (sender.tag) {
        case LIGHTBUTTONTAG://照明按钮
        {
            if(0 != _readview.torchMode){
                //关闭闪光灯
                _readview.torchMode = 0;
            }else if (0 == _readview.torchMode){
                //打开闪光灯
                _readview.torchMode = 1;
            }
            
        }
            break;
        case IMPORTBUTTONTAG://导入二维码图片
        {
            [self presentImagePickerController];
        }
            break;
		case IMPORTHisTory: //历史记录
		{
			[self gotoscanhistory];
		}
			break;
        default:
            break;
    }
}

/**
 *打开二维码扫描视图ZBarReaderView
 */
- (void)setZBarReaderViewStart{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview start];//开始扫描二维码
    [_qrRectView startScan];
    
}

/**
 *关闭二维码扫描视图ZBarReaderView
 */
- (void)setZBarReaderViewStop{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview stop];//关闭扫描二维码
    [_qrRectView stopScan];
}

//弹出系统相册、相机
-(void)presentImagePickerController{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker = [[UIImagePickerController alloc] init];
    _picker.sourceType               = sourceType;
    _picker.allowsEditing            = YES;
    _picker.delegate                 = self;
	
//	[self presentViewController:_picker animated:NO completion:nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_picker.view];
    [_picker.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.size.equalTo(window);
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //收起相册
    [picker.view removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark navigation 代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
	viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark IBAction
-(void)pickerremove
{
	[_picker.view removeFromSuperview];
}



-(void)gotoscanhistory
{
	ScanHistoryViewController *scanhistory = [[ScanHistoryViewController alloc] init];
	[self.navigationController pushViewController:scanhistory animated:YES];
}

-(void)returnback:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)btClickedinput:(id)sender
{
	ScanInputQRCodeViewController *scaninput = [[ScanInputQRCodeViewController alloc] init];
	scaninput.codetype = codetype;
	[self.navigationController pushViewController:scaninput animated:YES];

}

//-(void)btclickleft:(id)sender
//{
//    UIImageView *imageview = [_qrRectView viewWithTag:ImageBgTag];
//    imageview.image = LOADIMAGE(@"QR_扫码返利", @"png");
//    codetype = EnToRebate;
//}
//
//-(void)btclickright:(id)sender
//{
//    UIImageView *imageview = [_qrRectView viewWithTag:ImageBgTag];
//    imageview.image = LOADIMAGE(@"QR_产品溯源", @"png");
//    codetype = EnToOrgin;
//}

#pragma mark -
#pragma mark ZBarReaderViewDelegate
//扫描二维码的时候，识别成功会进入此方法，读取二维码内容
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{
    //停止扫描
    [self setZBarReaderViewStop];
    
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    NSString *urlStr = symbol.data;
    
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
        
        return;
    }
    
    NSLog(@"urlStr: %@",urlStr);

	
	[self getscancode:urlStr ];
	
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//导入二维码的时候会进入此方法，处理选中的相片获取二维码内容
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //停止扫描
    [self setZBarReaderViewStop];
    
    //处理选中的相片,获得二维码里面的内容
    ZBarReaderController *reader = [[ZBarReaderController alloc] init];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGImageRef cgimage = image.CGImage;
    ZBarSymbol *symbol = nil;
    for(symbol in [reader scanImage:cgimage])
        break;
    NSString *urlStr = symbol.data;
    
    [picker.view removeFromSuperview];
    
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"此二维码不能识别" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];

        return;
    }
	[self getscancode:urlStr];
    NSLog(@"urlStr: %@",urlStr);
	
}

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
		//	 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 [self donecodevalid:[dic objectForKey:@"msg"]];
		 }
	  }];
}

-(void)donecodevalid:(NSString *)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sender message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[self setZBarReaderViewStart];
	}];
	
	// Add the actions.
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
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
