//
//  MyInputOrderViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyInputOrderViewController.h"

@interface MyInputOrderViewController ()

@end

@implementation MyInputOrderViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] setAlpha:0];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

-(void)initview
{
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	//扫码记录
	self.title = @"填写订单";
	
	//返回按钮
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.delegate = self;
	tableview.dataSource = self;
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self addremoveview];
	[self getorderinfo];
}

-(void)addremoveview
{
	UIView *viewdoen = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
	viewdoen.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:viewdoen];
	
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.titleLabel.font = FONTN(15.0f);
	[buttondone setTitle:@"提交" forState:UIControlStateNormal];
	[buttondone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttondone addTarget:self action:@selector(clickcreateorder:) forControlEvents:UIControlEventTouchUpInside];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100,50 );
	[buttondone setBackgroundColor:Colorredcolor];
	[viewdoen addSubview:buttondone];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-200, 10, 180, 30)];
	labelprice.textColor = Colorredcolor;
	labelprice.font = FONTN(15.0f);
	labelprice.tag = EnOrderActMoneyLableTag;
	labelprice.textAlignment = NSTextAlignmentRight;
	labelprice.text = @"实际金额:￥0.00";
	[viewdoen addSubview:labelprice];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[tableview setContentOffset:CGPointMake(0, 100) animated:YES];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[tableview setContentOffset:CGPointMake(0, 0) animated:YES];
	return YES;
}

#pragma mark Actiondelegate
-(void)DGSelectOneAddr:(NSDictionary *)dicaddr
{
	NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
	[[cell.contentView viewWithTag:EnOrderAddrCellViewTag] removeFromSuperview];
	[cell.contentView addSubview:[self viewaddr:dicaddr]];
	straddrid = [dicaddr objectForKey:@"id"];
}

#pragma mark ibaction

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickcreateorder:(id)sender
{
	UITextField *textfieldmessage = [tableview viewWithTag:EnOrderToBussMessageTag];
	NSData *data=[NSJSONSerialization dataWithJSONObject:self.arraycommonditynumber options:NSJSONWritingPrettyPrinted error:nil];
	NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	
	if(([straddrid length]==0)||([strpaytypeid length]==0)||[strdeliverytypeid length]==0)
	{
		[MBProgressHUD showError:@"请选择收货地址" toView:app.window];
	}
	else
	{
		[self gotojiesuan:jsonStr ReceiveID:straddrid PayTypeId:strpaytypeid DeliveryTypeid:strdeliverytypeid OrderNote:textfieldmessage.text Money:stractualneedpaymoney];
	}
}

-(void)clicksendtype:(id)sender
{
	for(int i=0;i<5;i++)
	{
		UIButton *button  = [tableview viewWithTag:EnOrderSendTypeBtTag+i];
		[button setTitleColor:ColorBlackGray forState:UIControlStateNormal];
		button.layer.borderColor = ColorBlackGray.CGColor;
	}
	
	UIButton *button = (UIButton *)sender;
	[button setTitleColor:Colorredcolor forState:UIControlStateNormal];
	button.layer.borderColor = Colorredcolor.CGColor;
	int tagnow = (int)[button tag]-EnOrderSendTypeBtTag;
	NSArray *arraydelivery = [dicdata objectForKey:@"deliverytypelist"];
	NSDictionary *dictemp = [arraydelivery objectAtIndex:tagnow];
	strdeliverytypeid = [dictemp objectForKey:@"deliverytypeid"];
	UILabel *labelfee = [tableview viewWithTag:EnOrderTransFeeLabelTag];
	labelfee.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"deliveryfee"]];
	
	float sendfee = [[dictemp objectForKey:@"deliveryfee"] floatValue];
	float totalfee = [[dicdata objectForKey:@"totlemoney"] floatValue];
	UILabel *labelvalue = [self.view viewWithTag:EnOrderActMoneyLableTag];
	labelvalue.text = [NSString stringWithFormat:@"实际金额:￥%@",[NSString stringWithFormat:@"%.2f",totalfee+sendfee]];
	
}

-(void)clickpaytype:(id)sender
{
	for(int i=0;i<5;i++)
	{
		UIButton *button  = [tableview viewWithTag:EnOrderPayTypeBtTag+i];
		[button setTitleColor:ColorBlackGray forState:UIControlStateNormal];
		button.layer.borderColor = ColorBlackGray.CGColor;
	}
	
	UIButton *button = (UIButton *)sender;
	[button setTitleColor:Colorredcolor forState:UIControlStateNormal];
	button.layer.borderColor = Colorredcolor.CGColor;
	
	int tagnow = (int)[button tag]-EnOrderPayTypeBtTag;
	NSArray *arraydelivery = [dicdata objectForKey:@"paytypelist"];
	NSDictionary *dictemp = [arraydelivery objectAtIndex:tagnow];
	strpaytypeid = [dictemp objectForKey:@"paytypeid"];
	
}

#pragma mark tableview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITextField *textfieldmessage = [tableview viewWithTag:EnOrderToBussMessageTag];
	[textfieldmessage resignFirstResponder];
//	[tableview setContentOffset:CGPointMake(0, 0) animated:YES];
}

//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	
	UIView *view = [UIView new];
	
	view.backgroundColor = [UIColor clearColor];
	
	[tableView setTableFooterView:view];
	
	
}

-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row)
	{
		case 0:
			return 65;
		case 1:
			return 85;
		default:
			return 40;
	}
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	//NSArray *arrayhp = [dichp objectForKey:@"companylist"];
	return 8;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor clearColor];
	
	UILabel *labelname;
	UILabel *labelvalue;
	UITextField *textfield;
	NSDictionary *delivery;
	switch (indexPath.row)
	{
		case 0:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			[cell.contentView addSubview:[self viewaddr:[dicdata objectForKey:@"receiveaddrinfo"]]];
			break;
		case 1:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			[cell.contentView addSubview:[self viewproduct:self.arraycommonditypic]];
			break;
		case 2:
			[cell.contentView addSubview:[self viewpeishongtype:[dicdata objectForKey:@"deliverytypelist"]]];
			break;
		case 3:
			[cell.contentView addSubview:[self viewpaytype:[dicdata objectForKey:@"paytypelist"]]];
			break;
		case 4:
			cell.backgroundColor = [UIColor whiteColor];
			labelname = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 80, 20)];
			labelname.textColor = ColorBlackdeep;
			labelname.font = FONTN(15.0f);
			labelname.text = @"商品金额";
			[cell.contentView addSubview:labelname];
			
			labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,10, 140, 20)];
			labelvalue.textColor = Colorredcolor;
			labelvalue.font = FONTN(15.0f);
			labelvalue.text =[NSString stringWithFormat:@"￥%@",[dicdata objectForKey:@"totlemoney"]];
			stractualneedpaymoney = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"totlemoney"]];
			labelvalue.textAlignment = NSTextAlignmentRight;
			[cell.contentView addSubview:labelvalue];
			break;
		case 5:
			cell.backgroundColor = [UIColor whiteColor];
			labelname = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 80, 20)];
			labelname.textColor = ColorBlackdeep;
			labelname.font = FONTN(15.0f);
			labelname.text = @"运费";
			[cell.contentView addSubview:labelname];
			
			labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,10, 140, 20)];
			labelvalue.textColor = Colorredcolor;
			labelvalue.font = FONTN(15.0f);
			delivery = [[dicdata objectForKey:@"deliverytypelist"] objectAtIndex:0];
			labelvalue.text = [NSString stringWithFormat:@"￥%@",[delivery objectForKey:@"deliveryfee"]];
			labelvalue.tag = EnOrderTransFeeLabelTag;
			labelvalue.textAlignment = NSTextAlignmentRight;
			[cell.contentView addSubview:labelvalue];
			break;
		case 6:
			cell.backgroundColor = COLORNOW(250, 250, 250);
			labelname = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 280, 20)];
			labelname.textColor = COLORNOW(255, 133, 0);
			labelname.font = FONTN(13.0f);
			labelname.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"promotioninfo"]];
			
			[cell.contentView addSubview:labelname];
			break;
		case 7:
			cell.backgroundColor = [UIColor whiteColor];
			textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 30)];
			textfield.backgroundColor = [UIColor clearColor];
			textfield.placeholder = @"选填:给商家留言(最多45字)";
			textfield.font = FONTN(14.0f);
			textfield.textColor = ColorBlackdeep;
			textfield.delegate = self;
			textfield.tag = EnOrderToBussMessageTag;
			[cell.contentView addSubview:textfield];
			break;
		default:
			cell.textLabel.text = @"123";
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ReceiveAddrViewController *addaddr;
	switch (indexPath.row)
	{
		case 0:
			addaddr = [[ReceiveAddrViewController alloc] init];
			addaddr.fromaddr = @"2";
			addaddr.delegate1 = self;
			[self.navigationController pushViewController:addaddr animated:YES];
			break;
			
		default:
			break;
	}
}

-(UIView *)viewpaytype:(NSArray *)arraypay
{
	UIView *viewcell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewcell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labeltype = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 70, 20)];
	labeltype.textColor = ColorBlackdeep;
	labeltype.font = FONTN(15.0f);
	labeltype.text = @"支付方式";
	[viewcell addSubview:labeltype];
	
	for(int i=0;i<[arraypay count];i++)
	{
		NSDictionary *dictemp = [arraypay objectAtIndex:i];
		UIButton *buttonpayreceive = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonpayreceive.titleLabel.font = FONTN(13.0f);
		[buttonpayreceive setTitle:[dictemp objectForKey:@"paytypename"] forState:UIControlStateNormal];
		[buttonpayreceive setTitleColor:ColorBlackGray forState:UIControlStateNormal];
		buttonpayreceive.layer.cornerRadius = 2.0f;
		buttonpayreceive.clipsToBounds = YES;
		buttonpayreceive.layer.borderColor = ColorBlackGray.CGColor;
		buttonpayreceive.layer.borderWidth = 1.0f;
		if(i==0)
		{
			[buttonpayreceive setTitleColor:Colorredcolor forState:UIControlStateNormal];
			buttonpayreceive.layer.borderColor = Colorredcolor.CGColor;
			strpaytypeid = [dictemp objectForKey:@"paytypeid"];
		}
		buttonpayreceive.tag = EnOrderPayTypeBtTag+i;
		[buttonpayreceive addTarget:self action:@selector(clickpaytype:) forControlEvents:UIControlEventTouchUpInside];
		buttonpayreceive.frame = CGRectMake(SCREEN_WIDTH-80-80*([arraypay count]-1-i), 6, 70,28 );
		[buttonpayreceive setBackgroundColor:[UIColor clearColor]];
		[viewcell addSubview:buttonpayreceive];
	}
	return viewcell;
}

-(UIView *)viewpeishongtype:(NSArray *)arraysend
{
	UIView *viewcell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewcell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labeltype = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 70, 20)];
	labeltype.textColor = ColorBlackdeep;
	labeltype.font = FONTN(15.0f);
	labeltype.text = @"配送方式";
	[viewcell addSubview:labeltype];
	for(int i=0;i<[arraysend count];i++)
	{
		NSDictionary *dictemp = [arraysend objectAtIndex:i];
		UIButton *buttonsendself = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonsendself.titleLabel.font = FONTN(13.0f);
		[buttonsendself setTitle:[dictemp objectForKey:@"deliverytypename"] forState:UIControlStateNormal];
		[buttonsendself setTitleColor:ColorBlackGray forState:UIControlStateNormal];
		buttonsendself.layer.cornerRadius = 2.0f;
		buttonsendself.clipsToBounds = YES;
		buttonsendself.layer.borderColor = ColorBlackGray.CGColor;
		buttonsendself.layer.borderWidth = 1.0f;
		if(i==0)
		{
			[buttonsendself setTitleColor:Colorredcolor forState:UIControlStateNormal];
			buttonsendself.layer.borderColor = Colorredcolor.CGColor;
			strdeliverytypeid = [dictemp objectForKey:@"deliverytypeid"];
		}
		
		buttonsendself.tag = EnOrderSendTypeBtTag+i;
		[buttonsendself addTarget:self action:@selector(clicksendtype:) forControlEvents:UIControlEventTouchUpInside];
		buttonsendself.frame = CGRectMake(SCREEN_WIDTH-80-80*([arraysend count]-1-i), 6, 70,28 );
		[buttonsendself setBackgroundColor:[UIColor clearColor]];
		[viewcell addSubview:buttonsendself];
	}
	return viewcell;
}

-(UIView *)viewaddr:(NSDictionary *)dic
{
	UIView *viewcell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
	viewcell.backgroundColor = [UIColor whiteColor];
	viewcell.tag = EnOrderAddrCellViewTag;
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
	labelname.textColor = ColorBlackdeep;
	labelname.font = FONTMEDIUM(15.0f);
	labelname.text = [dic objectForKey:@"contactperson"];
	[viewcell addSubview:labelname];
	
	UILabel *labeltel = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+5, labelname.frame.origin.y, 150, 20)];
	labeltel.textColor = ColorBlackdeep;
	labeltel.font = FONTMEDIUM(15.0f);
	labeltel.text = [dic objectForKey:@"contactmobile"];
	[viewcell addSubview:labeltel];
	
	UIImageView *imagelocation = [[UIImageView alloc] initWithFrame:CGRectMake(labelname.frame.origin.x-13,labelname.frame.origin.y+labelname.frame.size.height+8 , 10, 14)];
	imagelocation.image = LOADIMAGE(@"附近gray", @"png");
	[viewcell addSubview:imagelocation];
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+5, 250, 20)];
	labeladdr.textColor = ColorBlackdeep;
	labeladdr.font = FONTN(13.0f);
	labeladdr.text =  [dic objectForKey:@"address"];
	[viewcell addSubview:labeladdr];
	
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewcell.frame.origin.y+viewcell.frame.size.height-2, SCREEN_WIDTH, 2)];
	imageline.image = LOADIMAGE(@"me_shopcarcolordive", @"png");
	[viewcell addSubview:imageline];
	
	return viewcell;

}

-(UIView *)viewproduct:(NSArray *)arrayproduct
{
	UIView *viewcell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
	viewcell.backgroundColor = [UIColor clearColor];
	
	UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 80)];
	imagebg.backgroundColor = [UIColor whiteColor];
	[viewcell addSubview:imagebg];
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH-30-60, 60)];
	scrollview.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:scrollview];
	
	float noworginx = 0;
	for(int i=0;i<[arrayproduct count];i++)
	{
		NSDictionary *dicproduct = [arrayproduct objectAtIndex:i];
		
		UIImageView *imagelocation = [[UIImageView alloc] initWithFrame:CGRectMake(noworginx, 0, 60, 60)];
		NSURL *urlstr = [NSURL URLWithString:[dicproduct objectForKey:@"commoditypicture"]];
		[imagelocation setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
		[scrollview addSubview:imagelocation];
		noworginx = noworginx+70;
	}
	
	return viewcell;
}

#pragma mark 接口
-(void)getorderinfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001015000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicdata = [dic objectForKey:@"data"];
			 straddrid = [[dicdata objectForKey:@"receiveaddrinfo"] objectForKey:@"receiveaddrid"];
			 UILabel *labelvalue = [self.view viewWithTag:EnOrderActMoneyLableTag];
			 NSDictionary *delivery = [[dicdata objectForKey:@"deliverytypelist"] objectAtIndex:0];
			 float sendfee = [[delivery objectForKey:@"deliveryfee"] floatValue];
			 float totalfee = [[dicdata objectForKey:@"totlemoney"] floatValue];
			 labelvalue.text = [NSString stringWithFormat:@"实际金额:￥%@",[NSString stringWithFormat:@"%.2f",totalfee+sendfee]];
			 
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
}

-(void)gotojiesuan:(NSString *)strjson ReceiveID:(NSString *)rid PayTypeId:(NSString *)paytypeid DeliveryTypeid:(NSString *)dtypeid OrderNote:(NSString *)ordernote Money:(NSString *)money
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:strjson forKey:@"orderdetailidlist"];
	[params setObject:rid forKey:@"receiveaddrid"];
	[params setObject:paytypeid forKey:@"paytypeid"];
	[params setObject:dtypeid forKey:@"deliverytypeid"];
	[params setObject:ordernote forKey:@"ordernote"];
	[params setObject:money forKey:@"actualneedpaymoney"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001016000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 MyOrderDaoFuViewController *myorder = [[MyOrderDaoFuViewController alloc] init];
			 myorder.strorderid = [[[dic objectForKey:@"data"] objectForKey:@"userorderinfo"] objectForKey:@"orderid"];
			 myorder.strorderfee = [[[dic objectForKey:@"data"] objectForKey:@"userorderinfo"] objectForKey:@"actualneedpaymoney"];
			 myorder.strorsendtype = [[[dic objectForKey:@"data"] objectForKey:@"userorderinfo"] objectForKey:@"deliverytype"];
			 myorder.strorderpaytype = [[[dic objectForKey:@"data"] objectForKey:@"userorderinfo"] objectForKey:@"paytype"];
			 if([paytypeid isEqualToString:@"payoffline"])
			 {
				 myorder.strorderins = @"请在24小时内支付,否则系统将取消该笔订单";
			 }
			 else
			 {
				  myorder.strorderins = @"";
			 }
			 [self.navigationController pushViewController:myorder animated:YES];
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
