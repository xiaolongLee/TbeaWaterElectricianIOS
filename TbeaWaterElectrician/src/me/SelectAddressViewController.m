//
//  SelectAddressViewController.m
//  TeBian
//
//  Created by xyy520 on 16/12/2.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SelectAddressViewController.h"

@interface SelectAddressViewController ()


@end

@implementation SelectAddressViewController
@synthesize delegate1;




-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"选择地址";
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
	[buttonright addTarget:self action: @selector(clicksave) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:3009] removeFromSuperview];
}

-(void)returnkeytextfield
{
	UITextField *textfield1 = [self.view viewWithTag:8100];
	UITextField *textfield2 = [self.view viewWithTag:8101];
	UITextField *textfield3 = [self.view viewWithTag:8102];
	UITextField *textfield4 = [self.view viewWithTag:8103];
	
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];
}

-(void)clicksave
{
	[self returnkeytextfield];
	UITextField *textfield1 = [self.view viewWithTag:8100];
	UITextField *textfield2 = [self.view viewWithTag:8101];
	UITextField *textfield3 = [self.view viewWithTag:8102];
	UITextField *textfield4 = [self.view viewWithTag:8103];
	if([textfield1.text length]==0||[textfield2.text length]==0||[textfield3.text length]==0||[textfield4.text length] == 0)
	{
		[MBProgressHUD showError:@"请选择正确的地址" toView:app.window];
	}
	else
	{
		if([self.delegate1 respondsToSelector:@selector(ReceiveAddrselectAddr:)])
		{
			NSDictionary *addr = [NSDictionary dictionaryWithObjectsAndKeys:sproviceid,@"sproviceid",
									 scityid,@"scityid",
									 sareaid,@"sareaid",
									 sprovicename,@"sprovicename",
									 scityname,@"scityname",
									 sareaname,@"sareaname",
									 textfield4.text,@"addrtext",nil];
			[delegate1 ReceiveAddrselectAddr:addr];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
}

-(void)initview
{
	self.result = @" ";
	sproviceid = @"";
	scityid = @"";
	sareaid = @"";
	sprovicename = @"";
	scityname = @"";
	sareaname = @"";
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	content1 = [[NSMutableArray alloc] init];
	self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	self.maskView.backgroundColor = [UIColor blackColor];
	self.maskView.alpha = 0;
	self.maskView.tag = 801;
	[self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	selectmodel = 0;
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	for(int i=0;i<4;i++)
	{
		NSString *placestr;
		switch (i)
		{
			case 0:
				placestr = @"选择省份";
				break;
			case 1:
				placestr = @"选择市";
				break;
			case 2:
				placestr = @"选择区域";
				break;
			case 3:
				placestr = @"详细地址";
				break;
		}
		
		
		
		UITextField *textfield = [self textfieldaddr:CGRectMake(30, 30+40*i, SCREEN_WIDTH-60, 35) PlaceStr:placestr];
		textfield.tag = 8100+i;
		[self.view addSubview:textfield];
		
		if(self.dicaddr!=nil)
		{
			sproviceid = [self.dicaddr objectForKey:@"provinceid"];
			scityid =[self.dicaddr objectForKey:@"cityid"];
			sareaid = [self.dicaddr objectForKey:@"zoneid"];
			sprovicename = [self.dicaddr objectForKey:@"province"];
			scityname = [self.dicaddr objectForKey:@"city"];
			sareaname = [self.dicaddr objectForKey:@"zone"];
			switch (i)
			{
				case 0:
					textfield.text = sprovicename;
					break;
				case 1:
					textfield.text = scityname;
					break;
				case 2:
					textfield.text = sareaname;
					break;
				case 3:
					textfield.text =  [self.dicaddr objectForKey:@"address"];
					break;
			}
		}
	}
}

-(UITextField *)textfieldaddr:(CGRect)frame PlaceStr:(NSString *)placestr
{
	UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:frame];
	textfield1.layer.cornerRadius = 3;
	textfield1.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfield1.layer.borderWidth = 0.5f;
	textfield1.backgroundColor = [UIColor whiteColor];
	textfield1.delegate = self;
	textfield1.placeholder = placestr;
	textfield1.font = FONTN(14.0f);
	textfield1.returnKeyType = UIReturnKeyDone;
	textfield1.leftView = leftview;
	leftview.userInteractionEnabled = NO;
	textfield1.leftViewMode = UITextFieldViewModeAlways;
	
	return textfield1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self returnkeytextfield];
	if(textField.tag == 8100)
	{
		selectmodel = 0;
		[self requestprovince];
		return NO;
	}
	else if(textField.tag == 8101)
	{
		selectmodel = 1;
		if([sproviceid length]>0)
		{
			[self requestcity:sproviceid];
		}
		else
		{
			[MBProgressHUD showError:@"请选择省份" toView:app.window];
		}
		return NO;
	}
	else if(textField.tag == 8102)
	{
		selectmodel = 2;
		if([scityid length]>0)
		{
			[self requestcityarea:scityid];
		}
		else
		{
			[MBProgressHUD showError:@"请先选择城市" toView:app.window];
		}
		return NO;
	}
	
	return YES;
}

//获取省
-(void)requestprovince
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001002001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayprove = [[dic objectForKey:@"data"] objectForKey:@"provincelist"];
			 [self showpickview:1];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

//获取市
-(void)requestcity:(NSString *)sproceid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:sproceid forKey:@"provinceid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraycity = [[dic objectForKey:@"data"] objectForKey:@"citylist"];
			 [self showpickview:1];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

//获取区域
-(void)requestcityarea:(NSString *)persondata
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scityname forKey:@"cityname"];
	[RequestInterface doGetJsonWithParametersNoAn1:params App:app RequestCode:@"TBEAENG003001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayarea = [[dic objectForKey:@"data"] objectForKey:@"locationlist"];
			 [self showpickview:1];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}



-(void)returntextfieldkey:(id)sender
{
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:8100];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:8101];
	UITextField *textfield3 = (UITextField *)[self.view viewWithTag:8102];
	UITextField *textfield4 = (UITextField *)[self.view viewWithTag:8103];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];
}

#pragma mark - 滚轮选择
-(void)showaccession:(id)sender
{
	[self returntextfieldkey:nil];
	[self showpickview:selectmodel];

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
	if(selectmodel == 0)  //省
	{
		if([arrayprove count]==0)
		{
			[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
			return;
		}
		for(int i=0;i<[arrayprove count];i++)
		{
			NSDictionary *dictype = [arrayprove objectAtIndex:i];
			[content1 addObject:[dictype objectForKey:@"name"]];
		}
	}
	else if(selectmodel == 1)   //市
	{
		if([arraycity count]==0)
		{
			[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
			return;
		}
		for(int i=0;i<[arraycity count];i++)
		{
			NSDictionary *dictype = [arraycity objectAtIndex:i];
			[content1 addObject:[dictype objectForKey:@"name"]];
		}
	}
	else if(selectmodel == 2)   //区
	{
		if([arrayarea count]==0)
		{
			[MBProgressHUD showError:@"无选择项,请在后台添加" toView:app.window];
			return;
		}
		for(int i=0;i<[arrayarea count];i++)
		{
			NSDictionary *dictype = [arrayarea objectAtIndex:i];
			[content1 addObject:[dictype objectForKey:@"name"]];
		}
	}
	
	self.result = [content1 objectAtIndex:0];
	
	[[self.view viewWithTag:800] removeFromSuperview];
	[self.maskView removeFromSuperview];
	
	[self.view addSubview:self.maskView];
	self.maskView.alpha = 0;
	UIView *viewsheet = [self initviewsheet:CGRectMake(0, SCREEN_HEIGHT-255, SCREEN_WIDTH, 255)];
	viewsheet.tag = 800;
	[self.view addSubview:viewsheet];
	
	UIPickerView *picview = (UIPickerView *)[self.view viewWithTag:9990];
	
	[picview selectRow:[content1 count]/2 inComponent:0 animated:NO];
	self.result  = [content1 objectAtIndex:[content1 count]/2];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.maskView.alpha = 0.3;
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x, SCREEN_HEIGHT-viewsheet.frame.size.height, viewsheet.frame.size.width, viewsheet.frame.size.height);
	}];
	
}

- (void)hideMyPicker {
	UIView *viewsheet = (UIView *)[self.view viewWithTag:800];
	[UIView animateWithDuration:0.3 animations:^{
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x,SCREEN_HEIGHT, viewsheet.frame.size.width, viewsheet.frame.size.height);
		self.maskView.alpha = 0;
	} completion:^(BOOL finished) {
		[viewsheet removeFromSuperview];
		[self.maskView removeFromSuperview];
	}];
}



- (void)cancelbt:(id)sender {
	[self hideMyPicker];
}

- (void)ensurebt:(id)sender {
	
	[self hideMyPicker];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:8101];
	UITextField *textfield3 = (UITextField *)[self.view viewWithTag:8102];
	UITextField *textfield4 = (UITextField *)[self.view viewWithTag:8103];
	if(selectmodel == 0)
	{
		UITextField *texttemp = (UITextField *)[self.view viewWithTag:8100];
		texttemp.text = self.result;
		sprovicename = self.result;
		for(int i=0;i<[arrayprove count];i++)
		{
			NSDictionary *dictemp = [arrayprove objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:self.result])
			{
				sproviceid = [dictemp objectForKey:@"id"];
				break;
			}
		}
		textfield2.text = @"";
		textfield3.text = @"";
		textfield4.text = @"";
	}
	else if(selectmodel == 1)
	{
		UITextField *texttemp = (UITextField *)[self.view viewWithTag:8101];
		texttemp.text = self.result;
		scityname = self.result;
		for(int i=0;i<[arraycity count];i++)
		{
			NSDictionary *dictemp = [arraycity objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:self.result])
			{
				scityid = [dictemp objectForKey:@"id"];
				break;
			}
		}
		textfield3.text = @"";
		textfield4.text = @"";
	}
	else if(selectmodel == 2)
	{
		UITextField *texttemp = (UITextField *)[self.view viewWithTag:8102];
		texttemp.text = self.result;
		sareaname = self.result;
		for(int i=0;i<[arrayarea count];i++)
		{
			NSDictionary *dictemp = [arrayarea objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:self.result])
			{
				sareaid = [dictemp objectForKey:@"id"];
				break;
			}
		}
		textfield4.text = @"";
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
	if(component == 0)
		return [content1 count];
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component == 0)
		return [content1 objectAtIndex:row];
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component == 0)
		self.result = [content1 objectAtIndex:row];
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
