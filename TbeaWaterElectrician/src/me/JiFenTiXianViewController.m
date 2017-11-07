//
//  JiFenTiXianViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/22.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "JiFenTiXianViewController.h"

@interface JiFenTiXianViewController ()
{
	BMKPointAnnotation* pointAnnotation;
}
@end

@implementation JiFenTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	content1 = [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = EnMaskViewActionTag;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self getmymoney];
	 [self gettixianjxslist];
	
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
    // Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)dicsrc
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"积分提现";
	
	NSDictionary *dic = [dicsrc objectForKey:@"mymoneyinfo"];
	NSDictionary *dicdistributor = [dicsrc objectForKey:@"recommonddistributorinfo"];
	
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 115)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	imageviewbg.layer.cornerRadius = 2.0f;
	imageviewbg.clipsToBounds = YES;
	[self.view addSubview:imageviewbg];
	
	UILabel *labeltixian = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+20, imageviewbg.frame.origin.y+10, 100, 20)];
	labeltixian.textColor = ColorBlackdeep;
	labeltixian.font = FONTN(15.0f);
	labeltixian.text = @"提现金额";
	[self.view addSubview:labeltixian];
	
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(labeltixian.frame.origin.x, labeltixian.frame.origin.y+labeltixian.frame.size.height+10, 20, 25)];
	labelmoney.textColor = ColorBlackdeep;
	labelmoney.font = FONTN(22.0f);
	labelmoney.text = @"￥123";
	[self.view addSubview:labelmoney];
	
	UITextField *textfieldmoney = [[UITextField alloc] init];
	textfieldmoney.frame = CGRectMake(labelmoney.frame.origin.x+labelmoney.frame.size.width+5, labelmoney.frame.origin.y, 200, labelmoney.frame.size.height);
	textfieldmoney.backgroundColor = [UIColor clearColor];
	textfieldmoney.placeholder = @"提现金额请填写整数";
	textfieldmoney.font = FONTN(18.0f);
	textfieldmoney.textColor = ColorBlackdeep;
	textfieldmoney.tag = EnMeTiXianMoneyTextFieldTag;
	[self.view addSubview:textfieldmoney];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x, labelmoney.origin.y+labelmoney.frame.size.height+10, imageviewbg.frame.size.width, 0.5)];
	imageline.backgroundColor = Colorgray;
	[self.view addSubview:imageline];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labeltixian.frame.origin.x, imageline.frame.origin.y+10, 255, 20)];
	labelins.textColor = ColorBlackGray;
	labelins.backgroundColor = [UIColor clearColor];
	labelins.font = FONTN(13.0f);
	labelins.text = [NSString stringWithFormat:@"积分余额￥%@，当前可提现金额￥%@",[dic objectForKey:@"currentmoney"],[dic objectForKey:@"canexchangemoney"]];
	[self.view addSubview:labelins];
	
	
	UIButton *btall = [UIButton buttonWithType:UIButtonTypeCustom];
	btall.frame = CGRectMake(labelins.frame.origin.x+labelins.frame.size.width,labelins.frame.origin.y-5, 60, 30);
	[btall setTitle:@"全部提现" forState:UIControlStateNormal];
	[btall setTitleColor:ColorBlue forState:UIControlStateNormal];
	btall.titleLabel.font = FONTN(14.0f);
	[btall addTarget:self action:@selector(tixianall:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btall];
	
	UIButton *btqrcode = [UIButton buttonWithType:UIButtonTypeCustom];
	btqrcode.frame = CGRectMake(imageviewbg.frame.origin.x,imageviewbg.frame.origin.y+imageviewbg.frame.size.height+20, imageviewbg.frame.size.width, 40);
	btqrcode.backgroundColor = COLORNOW(27, 130, 210);
	[btqrcode setTitle:@"生成二维码" forState:UIControlStateNormal];
	[btqrcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btqrcode.titleLabel.font = FONTN(15.0f);
	[btqrcode addTarget:self action:@selector(createqrcode:) forControlEvents:UIControlEventTouchUpInside];
	btqrcode.layer.cornerRadius= 2.0f;
	btqrcode.clipsToBounds = YES;
	[self.view addSubview:btqrcode];
	
	UILabel *labelbottomins = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x, btqrcode.frame.origin.y+btqrcode.frame.size.height+10, btqrcode.frame.size.width, 55)];
	labelbottomins.textColor = ColorBlackGray;
	labelbottomins.font = FONTN(13.0f);
	labelbottomins.numberOfLines = 3;
	labelbottomins.text = @"确认提现后，系统将生成一个提现二维码，请将此二维码给您注册所在区域内的任意授权经销商扫码确认后，您将换取相应的现金。";
	[self.view addSubview:labelbottomins];
	
	if([[dicdistributor objectForKey:@"longitude"] isEqualToString:@"-10000"])
	{
		UIImageView *imageviewditu = [[UIImageView alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, SCREEN_HEIGHT-390)];
		imageviewditu.image = LOADIMAGE(@"无经纬度", @"png");
		imageviewditu.tag = EnTiXianNoLaLongImageviewTag;
		imageviewditu.contentMode = UIViewContentModeScaleAspectFill;
		imageviewditu.clipsToBounds = YES;
		[self.view addSubview:imageviewditu];
	}
	else
	{
		WebViewContent *webviewcontent = [[WebViewContent alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, SCREEN_HEIGHT-390)];
		[self.view addSubview:webviewcontent];
		NSString *urlstr = [NSString stringWithFormat:@"http://www.u-shang.net/enginterface/index.php/Apph5/address?longitude=%@&latitude=%@",[dicdistributor objectForKey:@"longitude"],[dicdistributor objectForKey:@"latitude"]];
		[webviewcontent loadwebview:urlstr];
	}

	
	UIImageView *imageviewdis = [[UIImageView alloc] initWithFrame:CGRectMake(10, labelbottomins.frame.origin.y+labelbottomins.frame.size.height+5, SCREEN_WIDTH-20, 90)];
	imageviewdis.backgroundColor = [UIColor whiteColor];
	imageviewdis.layer.cornerRadius = 3.0f;
	imageviewdis.clipsToBounds = YES;
	imageviewdis.tag = EnTiXianAddrBgImageViewTag;
	[self.view addSubview:imageviewdis];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewdis.frame.origin.x+10, imageviewdis.frame.origin.y+5,imageviewdis.frame.size.width-50, 20)];
	labelname.textColor = ColorBlackdeep;
	labelname.font = FONTB(14.0f);
	labelname.tag = EnTiXianSlectJsxNameLabelTag;
	labelname.text = [dicdistributor objectForKey:@"name"];
	[self.view addSubview:labelname];
	
	UIButton *btselectaddr = [UIButton buttonWithType:UIButtonTypeCustom];
	btselectaddr.frame = CGRectMake(imageviewdis.frame.origin.x+imageviewdis.frame.size.width-40,labelname.frame.origin.y-5, 40, 30);
	[btselectaddr setTitleColor:COLORNOW(27, 130, 210) forState:UIControlStateNormal];
	[btselectaddr setTitle:@"选择" forState:UIControlStateNormal];
	btselectaddr.titleLabel.font = FONTN(15.0f);
	btselectaddr.backgroundColor = [UIColor clearColor];
	[btselectaddr addTarget:self action:@selector(clickselectaddr:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btselectaddr];
	
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+3,imageviewdis.frame.size.width-15, 35)];
	labeladdr.textColor = ColorBlackshallow;
	labeladdr.font = FONTN(13.0f);
	labeladdr.adjustsFontSizeToFitWidth = YES;
	labeladdr.tag = EnTiXianSlectJsxaddrLabelTag;
	labeladdr.numberOfLines = 2;
	labeladdr.text = [NSString stringWithFormat:@"地址:%@",[dicdistributor objectForKey:@"address"]];
	[self.view addSubview:labeladdr];
	
	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labeladdr.frame.origin.y+labeladdr.frame.size.height,imageviewdis.frame.size.width-50, 20)];
	labeltel.textColor = ColorBlackshallow;
	labeltel.font = FONTN(13.0f);
	labeltel.tag = EnTiXianSlectJsxtelLabelTag;
	labeltel.text = [NSString stringWithFormat:@"电话:%@",[dicdistributor objectForKey:@"mobilenumber"]];
	[self.view addSubview:labeltel];
	
	
	NSString *str = [NSString stringWithFormat:@"%@",[dicdistributor objectForKey:@"distance"]];
	CGSize size = [AddInterface getlablesize:str Fwidth:100 Fheight:20 Sfont:FONTN(13.0f)];
	
	UILabel *labeldis = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-size.width-10, labeltel.frame.origin.y,size.width+5, 20)];
	labeldis.textColor = ColorBlackshallow;
	labeldis.font = FONTN(13.0f);
	labeldis.text = str;
	labeldis.tag = EnTiXianSlectJsxdistanceLabelTag;
	[self.view addSubview:labeldis];
	
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(labeldis.frame.origin.x-18, labeltel.frame.origin.y+3, 11, 14)];
	imageicon.image = LOADIMAGE(@"locationgrayicon", @"png");
	[self.view addSubview:imageicon];

}

#pragma mark IBaction
-(void)tixianall:(id)sender
{
	UITextField *textfield = [self.view viewWithTag:EnMeTiXianMoneyTextFieldTag];
	textfield.text = [NSString stringWithFormat:@"%@",[[dicmymoney objectForKey:@"mymoneyinfo"] objectForKey:@"canexchangemoney"]];
}

-(void)createqrcode:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"请您确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfield = [self.view viewWithTag:EnMeTiXianMoneyTextFieldTag];
        [textfield resignFirstResponder];
        if([textfield.text length]==0)
        {
            [MBProgressHUD showError:@"请填写要提现的金额" toView:app.window];
        }
        else if(![AddInterface isValidatenumber:textfield.text])
        {
            [MBProgressHUD showError:@"只能输入数字" toView:app.window];
        }
        else
        {
            float nowmoney = [[[dicmymoney objectForKey:@"mymoneyinfo"] objectForKey:@"canexchangemoney"] floatValue];
            float inputmoney = [textfield.text floatValue];
            
            if(nowmoney<inputmoney)
            {
                [MBProgressHUD showError:@"你填写的提现金额不能超过可以提现的金额！" toView:app.window];
            }
            else if(inputmoney>0)
            {
                MyTiXianQRCodeViewController *tixiancode = [[MyTiXianQRCodeViewController alloc] init];
                tixiancode.tixianmoney = textfield.text;
                tixiancode.strdistribuid = selectdistribuid;
                [self.navigationController pushViewController:tixiancode animated:YES];
                
            }
            else
            {
                [MBProgressHUD showError:@"你填写的提现金额必须大于0！" toView:app.window];
            }
        }
        
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
	

}

-(void)returnback
{
	[self hideMyPicker];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 接口
-(void)clickselectaddr:(id)sender
{
	[self showaccession:1];
}

-(void)getmymoney
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001009000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicmymoney = [dic objectForKey:@"data"];
			 selectdistribuid = [[dicmymoney objectForKey:@"recommonddistributorinfo"] objectForKey:@"id"];
			 [self initview:dicmymoney];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
}


-(void)gettixianjxslist
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001009001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayjxsdata = [[dic objectForKey:@"data"] objectForKey:@"distributorlist"];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
}

#pragma mark - 滚轮选择
-(void)showaccession:(int)sender
{
	[self showpickview:sender];
}

-(UIView *)initviewsheet:(CGRect)frameview
{
	UIView *viewsheet = [[UIView alloc] initWithFrame:frameview];
	viewsheet.backgroundColor = [UIColor whiteColor];
	
	UIPickerView *picview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 216)];
	picview.delegate = self;
	picview.tag = 9990;
	[viewsheet addSubview:picview];
	
	UIButton *buttoncancel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncancel.frame = CGRectMake(0, 0, 80, 40);
	buttoncancel.titleLabel.font = FONTMEDIUM(15.0f);
	[buttoncancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttoncancel addTarget:self action:@selector(cancelbt:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncancel setTitle:@"取消" forState:UIControlStateNormal];
	[viewsheet addSubview:buttoncancel];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
	buttondone.titleLabel.font = FONTMEDIUM(15.0f);
	[buttondone addTarget:self action:@selector(ensurebt:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	[viewsheet addSubview:buttondone];
	
	return viewsheet;
}

- (void)showpickview:(int)sender
{
	[content1 removeAllObjects];
	
	for(int i=0;i<[arrayjxsdata count];i++)
	{
		NSDictionary *dictemp = [arrayjxsdata objectAtIndex:i];
		[content1 addObject:[dictemp objectForKey:@"name"]];
	}
	[[self.view viewWithTag:EnViewSheetTag] removeFromSuperview];
	[maskView removeFromSuperview];
	
	[self.view addSubview:maskView];
	maskView.alpha = 0;
	UIView *viewsheet = [self initviewsheet:CGRectMake(0, SCREEN_HEIGHT-255, SCREEN_WIDTH, 255)];
	viewsheet.tag = EnViewSheetTag;
	[app.window addSubview:viewsheet];
	
	UIPickerView *picview = (UIPickerView *)[app.window viewWithTag:9990];
	[picview selectRow:[content1 count]/2 inComponent:0 animated:NO];
	result1  = [content1 objectAtIndex:[content1 count]/2];
	
	[UIView animateWithDuration:0.3 animations:^{
		maskView.alpha = 0.3;
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x, SCREEN_HEIGHT-viewsheet.frame.size.height, viewsheet.frame.size.width, viewsheet.frame.size.height);
	}];
	
}

- (void)hideMyPicker {
	UIView *viewsheet = (UIView *)[app.window viewWithTag:EnViewSheetTag];
	[UIView animateWithDuration:0.3 animations:^{
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x,SCREEN_HEIGHT, viewsheet.frame.size.width, viewsheet.frame.size.height);
		maskView.alpha = 0;
	} completion:^(BOOL finished) {
		[viewsheet removeFromSuperview];
		[maskView removeFromSuperview];
	}];
}



- (void)cancelbt:(id)sender {
	[self hideMyPicker];
}

- (void)ensurebt:(id)sender {
	
	[self hideMyPicker];
	
	UILabel *labelname = [self.view viewWithTag:EnTiXianSlectJsxNameLabelTag];
	UILabel *labeladdr = [self.view viewWithTag:EnTiXianSlectJsxaddrLabelTag];
	UILabel *labeltel = [self.view viewWithTag:EnTiXianSlectJsxtelLabelTag];
	UILabel *labeldistance = [self.view viewWithTag:EnTiXianSlectJsxdistanceLabelTag];
	for(int i=0;i<[arrayjxsdata count];i++)
	{
		NSDictionary *dictemp = [arrayjxsdata objectAtIndex:i];
		
		if([[dictemp objectForKey:@"name"] isEqualToString:result1])
		{
			dicselectaddr = dictemp;
			selectdistribuid = [dicselectaddr objectForKey:@"id"];
			labelname.text = [dictemp objectForKey:@"name"];
			labeladdr.text = [NSString stringWithFormat:@"地址:%@",[dictemp objectForKey:@"address"]];
			labeltel.text = [NSString stringWithFormat:@"电话:%@",[dictemp objectForKey:@"mobilenumber"]];
			NSString *str = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"distance"]];
			labeldistance.text = str;
			
			[[self.view viewWithTag:EnTiXianNoLaLongImageviewTag] removeFromSuperview];
			[[self.view viewWithTag:EnTiXianDiTuWebViewTag] removeFromSuperview];
			UIImageView *imageviewdis  = [self.view viewWithTag:EnTiXianAddrBgImageViewTag];
			if([[dicselectaddr objectForKey:@"longitude"] isEqualToString:@"-10000"])
			{
				UIImageView *imageviewditu = [[UIImageView alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, SCREEN_HEIGHT-390)];
				imageviewditu.image = LOADIMAGE(@"无经纬度", @"png");
				imageviewditu.contentMode = UIViewContentModeScaleAspectFill;
				imageviewditu.tag = EnTiXianNoLaLongImageviewTag;
				imageviewditu.clipsToBounds = YES;
				[self.view insertSubview:imageviewditu belowSubview:imageviewdis];
			}
			else
			{
				WebViewContent *webviewcontent = [[WebViewContent alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, SCREEN_HEIGHT-390)];
				[self.view insertSubview:webviewcontent belowSubview:imageviewdis];
				webviewcontent.tag = EnTiXianDiTuWebViewTag;
				NSString *urlstr = [NSString stringWithFormat:@"http://www.u-shang.net/enginterface/index.php/Apph5/address?longitude=%@&latitude=%@",[dicselectaddr objectForKey:@"longitude"],[dicselectaddr objectForKey:@"latitude"]];
				[webviewcontent loadwebview:urlstr];
			}
			
		}
	}
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	return 1;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [content1 count];
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSDictionary *dictemp = [arrayjxsdata objectAtIndex:row];
	return [NSString stringWithFormat:@"%@ %@",[content1 objectAtIndex:row],[dictemp objectForKey:@"distance"]];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
	
	
	UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 30)];
	
	myView.textAlignment = NSTextAlignmentCenter;
	NSDictionary *dictemp = [arrayjxsdata objectAtIndex:row];
	myView.text = [NSString stringWithFormat:@"%@ %@",[content1 objectAtIndex:row],[dictemp objectForKey:@"distance"]];
	
	myView.font =FONTN(16.0f);         //用label来设置字体大小
	myView.adjustsFontSizeToFitWidth = YES;
	myView.backgroundColor = [UIColor clearColor];

	return myView;
	
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	result1 = [content1 objectAtIndex:row];
	DLog(@"result1====%@",result1);
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
