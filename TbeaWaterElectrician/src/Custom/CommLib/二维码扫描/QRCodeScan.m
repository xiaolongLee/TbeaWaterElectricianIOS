//
//  QRCodeScan.m
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-7-12.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import "QRCodeScan.h"
#import "Header.h"
#import "AppDelegate.h"
#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface QRCodeScan ()

@end

@implementation QRCodeScan
@synthesize resultText;
@synthesize delegate1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)returnback:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	backflag = 0;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self scanButtonTapped];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self.navigationController setNavigationBarHidden:NO];
    UIImage* img=LOADIMAGE(@"returnarrow", @"png");
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 40, 40);
    [btn setImage:img forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem* item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;

	[self initview:nil];
//
}

-(void)viewWillAppear:(BOOL)animated
{
	if(backflag == 1)
	{
		[self returnback:nil];
	}
}

-(void)initview:(id)sender
{
	UIImageView *imageviewtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
	imageviewtop.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:imageviewtop];
	
	UILabel * labresult= [[UILabel alloc] init];
	labresult.backgroundColor = [UIColor clearColor];
	labresult.frame=CGRectMake(80, 32, SCREEN_WIDTH-160, 20);
	labresult.textColor= COLORNOW(24, 24, 24);
	labresult.text=@"扫描结果";
	labresult.textAlignment = NSTextAlignmentCenter;
	labresult.font = FONTN(16.0f);
	[self.view addSubview:labresult];
	
//	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 5, 60, 40)];
//	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
//	[button setImage:LOADIMAGE(@"topreturn", @"png") forState:UIControlStateNormal];
//	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
//	[contentView addSubview:button];
//	self.view = contentView;
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	imageview.image = LOADIMAGE(@"qrcode", @"png");
	[self.view addSubview:imageview];
	
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	scrollview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scrollview];
}

- (void) scanButtonTapped
{    
    readerzbar = [ZBarReaderViewController new];
    
    readerzbar.readerDelegate = self;
    //非全屏
    readerzbar.wantsFullScreenLayout = NO;
    //隐藏底部控制按钮
    
    readerzbar.showsZBarControls = NO;
    
    //设置自己定义的界面
    
    [self setOverlayPickerView:readerzbar];
    
    ZBarImageScanner *scanner = readerzbar.scanner;
    
    [scanner setSymbology: ZBAR_I25
     
                   config: ZBAR_CFG_ENABLE
     
                       to: 0];
    
    [self presentViewController:readerzbar animated:NO completion:nil];
    
}



-(void)addnoscan:(id)sender
{
	UILabel * labresult= [[UILabel alloc] init];
	labresult.backgroundColor = [UIColor clearColor];
	labresult.frame=CGRectMake(80, SCREEN_HEIGHT-64/2, SCREEN_WIDTH-160, 20);
	labresult.textColor= COLORNOW(24, 24, 24);
	labresult.text=@"无法识别";
	labresult.textAlignment = NSTextAlignmentCenter;
	labresult.font = FONTN(16.0f);
	[self.view addSubview:labresult];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
	
    id<NSFastEnumeration> results =
	[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
	
    // EXAMPLE: do something useful with the barcode data
    resultText = symbol.data;
	
	if([resultText canBeConvertedToEncoding:NSShiftJISStringEncoding])
	{
		resultText = [NSString stringWithCString:[resultText cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
	}
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
	[reader dismissViewControllerAnimated:YES completion:nil];
}




- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
    //清除原有控件
//    reader
    
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
            
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
    }

	
	float nowwidth = 200;
	if(iphone6)
		nowwidth = 200*iphone6ratio;
	else if(iphone6p)
		nowwidth = 200*iphone6pratio;
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-nowwidth)/2)];
    upView.alpha = 0.4;
    upView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:upView];

    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(80, 22, SCREEN_WIDTH-160, 40);
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"二维码扫描";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = FONTN(17.0f);
    [reader.view addSubview:labIntroudction];
    
    //左侧的view
	
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.frame.size.height, (SCREEN_WIDTH-nowwidth)/2, nowwidth)];
    leftView.alpha = 0.4;
    leftView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:leftView];
	
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-nowwidth)/2+nowwidth, leftView.frame.origin.y, (SCREEN_WIDTH-nowwidth)/2, leftView.frame.size.height)];
    rightView.alpha = 0.4;
    rightView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:rightView];
	
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.frame.size.height+nowwidth, SCREEN_WIDTH, 500)];
    downView.alpha = 0.4;
    downView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:downView];
	
	
	UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(leftView.frame.size.width+30, upView.frame.size.height+20, nowwidth-60, 1)];
	
	line.backgroundColor = [UIColor redColor];
	
	[reader.view addSubview:line ];
	
	/* 添加动画 */
	
	[UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
		
		line.frame = CGRectMake(line.frame.origin.x, upView.frame.size.height+nowwidth-20, line.frame.size.width, 1);
		
	} completion:nil];
	
	
    //用于取消操作的button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(15, 25, 30, 30)];
    UIImage *imagecannel = LOADIMAGE(@"topreturn", @"png");
    [cancelButton setBackgroundImage:imagecannel forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];  
    [reader.view addSubview:cancelButton];  
    
}

- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
