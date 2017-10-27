//
//  ScanReportCodeViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanReportCodeViewController.h"

@interface ScanReportCodeViewController ()

@end

@implementation ScanReportCodeViewController

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
	UserLocationObject *location = [[UserLocationObject alloc] init];
	location.delegate1 = self;
	[location getnowlocation];
	[self getreportinfo];
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = [UIColor whiteColor];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	
	//扫码记录
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
	labeltitle.text = @"我要举报";
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
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	content1 = [[NSMutableArray alloc] init];
	arraypic = [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = EnMaskViewActionTag;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = self.strtitle;
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initfootview:arraypic];
	[self getmyreporttype];
}

-(UIView *)viewphoto:(NSMutableArray *)sender Rect:(CGRect)Rect
{
	UIView *viewbg = [[UIView alloc] initWithFrame:Rect];
	viewbg.backgroundColor = [UIColor whiteColor];
	
	float orginx = 20;
	float orginy = 20;
	float widthnow = 60;
	if(iphone6)
		widthnow = 70;
	else if(iphone6p)
		widthnow = 80;
	float space = ((SCREEN_WIDTH-40)-4*widthnow)/3;
	
	
	
	int counth = 0;
	int countv = 0;
	int countpic = (int)[sender count]==8?8:(int)[sender count]+1;
	counth = (countpic%4==0?countpic/4:countpic/4+1);
	
	UIButton *buttonphoto = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonphoto.frame = CGRectMake(20,20, widthnow, widthnow);
	[buttonphoto setBackgroundColor:[UIColor clearColor]];
	buttonphoto.tag = EnMyReportAddPicButtonTag;
	[buttonphoto setBackgroundImage:LOADIMAGE(@"addpic", @"png") forState:UIControlStateNormal];
	[buttonphoto addTarget:self action:@selector(clickselectphoto:) forControlEvents:UIControlEventTouchUpInside];
	[viewbg addSubview:buttonphoto];
	
	for(int i=0;i<counth;i++)
	{
		DLog(@"heightnow===%f",orginy);
		
		countv = 4;
		if(i== counth-1)
		{
			countv = countpic%4==0?4:countpic%4;
		}
		for(int j=0;j<countv;j++)
		{
			
			if(([sender count]!=8)&&(i== counth-1)&&(j==countv-1))
			{
				buttonphoto.frame = CGRectMake(orginx+(space+widthnow)*j, orginy, widthnow, widthnow);
			}
			else
			{
				UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(orginx+(space+widthnow)*j, orginy, widthnow, widthnow)];
				imagepic.image =[[sender objectAtIndex:i*4+j] objectForKey:@"result"];
				imagepic.tag = EnMyReportPicImageViewTag+i*4+j;
				imagepic.contentMode = UIViewContentModeScaleAspectFill;
				imagepic.clipsToBounds = YES;
				[viewbg addSubview:imagepic];
				
				UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
				buttondelete.frame = CGRectMake(imagepic.frame.origin.x+imagepic.frame.size.width-20, imagepic.frame.origin.y+3, 15, 15);
				[buttondelete setBackgroundColor:[UIColor clearColor]];
				buttondelete.tag = EnMyReportDeletePicBtTag+i*4+j;
				[buttondelete setBackgroundImage:LOADIMAGE(@"deleteicon", @"png") forState:UIControlStateNormal];
				[buttondelete addTarget:self action:@selector(clickdeletephoto:) forControlEvents:UIControlEventTouchUpInside];
				[viewbg addSubview:buttondelete];
			}
			
		}
		orginy = orginy+widthnow+20;
	}
	if(countpic==0)
		orginy = orginy+widthnow+20;
	viewbg.frame = CGRectMake(0, viewbg.frame.origin.y, SCREEN_WIDTH, orginy);
	return viewbg;
}

-(void)initfootview:(NSMutableArray *)sender
{
	tableview.tableFooterView = nil;
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
	viewbg.backgroundColor = [UIColor clearColor];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTHelve(15.0f);
	labeltitle.text = @"上传图片";
	labeltitle.backgroundColor = [UIColor clearColor];
	[viewbg addSubview:labeltitle];
	
	
	UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 80)];
	imagebg.backgroundColor = [UIColor whiteColor];
	[viewbg addSubview:imagebg];
	
	float widthnow = 60;
	if(iphone6)
		widthnow = 70;
	else if(iphone6p)
		widthnow = 80;
	
	UIView *viewcontent = [self viewphoto:sender Rect:CGRectMake(0, 40, SCREEN_WIDTH, 80)];
	[viewbg addSubview:viewcontent];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(10, viewcontent.frame.origin.y+viewcontent.frame.size.height+20,SCREEN_WIDTH-10, 70)];
	labelins.textColor = ColorBlackVeryGray;
	labelins.font = FONTN(12.0f);
	labelins.numberOfLines = 4;
	labelins.text = @"请尽量填写您购买产品的地点、时间和商家名称，最好拍照取证，\n以便我公司人员排查，谢谢你的合作。\n联系电话 0838-2801518";
	[viewbg addSubview:labelins];
	
	UIButton *btdone = [UIButton buttonWithType:UIButtonTypeCustom];
	btdone.backgroundColor = COLORNOW(27, 130, 210);
	btdone.frame = CGRectMake(10, labelins.frame.origin.y+labelins.frame.size.height+10,SCREEN_WIDTH-20, 35);
	[btdone setTitle:@"提交" forState:UIControlStateNormal];
	[btdone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btdone.titleLabel.font = FONTN(15.0f);
	[btdone addTarget:self action:@selector(clickbtdone:) forControlEvents:UIControlEventTouchUpInside];
	btdone.layer.cornerRadius= 2.0f;
	btdone.clipsToBounds = YES;
	[viewbg addSubview:btdone];
	
	viewbg.frame = CGRectMake(0, 0, SCREEN_WIDTH, btdone.frame.origin.y+btdone.frame.size.height+20);
	
	tableview.tableFooterView = viewbg;
	
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
	viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark IBaction
-(void)clickbtdone:(id)sender
{
	//	appealcategoryid,appealtime，scanaddress，provinceid，cityid，distributorid，commodityid，appealcontent
	UITextField *textfield0 = [tableview viewWithTag:EnReportTypeTextfieldTag];
	UITextField *textfield1 = [tableview viewWithTag:EnReportTimeTextfieldTag];
	UITextField *textfield2 = [tableview viewWithTag:EnReportScanAddressTextfieldTag];
	UITextField *textfield3 = [tableview viewWithTag:EnReportAreaTextfieldTag];
	UITextField *textfield4 = [tableview viewWithTag:EnReportUpJXSTextfieldTag];
	UITextField *textfield5 = [tableview viewWithTag:EnReportProductTextfieldTag];
	UITextField *textfield6 = [tableview viewWithTag:EnReportContentTextViewTag];
	
	if([textfield0.text length]==0||[textfield1.text length]==0||[textfield2.text length]==0||[textfield3.text length]==0||[textfield4.text length]==0||[textfield5.text length]==0||[textfield6.text length]==0)
	{
		[MBProgressHUD showError:@"请填写完全举报信息" toView:app.window];
	}
	else
	{
		[self uploadreport:reportid Appealtime:textfield1.text ScanAddress:textfield2.text Provinceid:[dicreportinfo objectForKey:@"provinceid"] CityId:[dicreportinfo objectForKey:@"cityid"] DisTributorid:[dicreportinfo objectForKey:@"distributorid"] CommodityId:self.strcommdityid AppealContent:textfield6.text Scancode:self.strscancode];
	}
	
}

-(void)clickselectphoto:(id)sender
{
	FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
	manager.maxSelect = 10;
	manager.delegate1 = self;
	manager.complate = ^(NSArray *array)
	{
		DLog(@"array====%@",[array objectAtIndex:0]);
		
		for(int i=0;i<[array count];i++)
		{
			NSDictionary *dic = [array objectAtIndex:i];
			int flag = 0;
			for(int j=0;j<[arraypic count];j++)
			{
				NSDictionary *dicphoto = [arraypic objectAtIndex:j];
				if([[dic objectForKey:@"localid"] isEqualToString:[dicphoto objectForKey:@"localid"]])
				{
					flag = 1;
					break;
				}
			}
			
			if(flag == 0)
			{
				[arraypic addObject:[array objectAtIndex:i]];
			}
		}
		
		[self initfootview:arraypic];
		
	};
	[manager showInView:self Photo:@"1"];
}

-(void)clickdeletephoto:(id)sender
{
	UIView *view = tableview.tableFooterView;
	UIButton *buttondelete = (UIButton *)sender;
	int tagnow = (int)[buttondelete tag]- EnMyReportDeletePicBtTag;
	for(int i=0;i<100;i++)
	{
		[[view viewWithTag:EnMyReportPicImageViewTag+i] removeFromSuperview];
		[[view viewWithTag:EnMyReportDeletePicBtTag+i] removeFromSuperview];
	}
	[arraypic removeObjectAtIndex:tagnow];
	
	[self initfootview:arraypic];
}

#pragma mark UitextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnReportTypeTextfieldTag)
	{
		 [self showaccession:1];
		
		return NO;
	}
	
	return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITextView *textview = [tableview viewWithTag:EnReportContentTextViewTag];
	[textview resignFirstResponder];
}


#pragma mark actiondelegate
-(void)DGGetUserLocatioObject:(id)sender
{
	UITextField *textfield = [tableview viewWithTag:EnReportScanAddressTextfieldTag];
	textfield.text = [app.dili.diliprovince stringByAppendingString:app.dili.dilicity];
	DLog(@"app.dile====%@",app.dili.dilicity);
}

#pragma mark tableview delegate
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
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 1)
		return 40;
	return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 1)
	{
		UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
		viewbg.backgroundColor = COLORNOW(240, 240, 240);
		
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
		labeltitle.textColor = ColorBlackdeep;
		labeltitle.font = FONTHelve(15.0f);
		labeltitle.text = @"举报内容";
		labeltitle.backgroundColor = [UIColor clearColor];
		[viewbg addSubview:labeltitle];
		
		return viewbg;
	}
	else
		return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==0)
		return 40;
	return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section==0)
		return 6;
	return 1;
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
	
	cell.backgroundColor = [UIColor whiteColor];
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTHelve(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UITextField *textfieldvalue = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+5, 10, 190, 20)];
	textfieldvalue.textColor = ColorBlackdeep;
	textfieldvalue.font = FONTN(14.0f);
	textfieldvalue.delegate = self;
	if(indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				labeltitle.text = @"举报类型";
				textfieldvalue.placeholder  = @"选择举报类型";
				textfieldvalue.text = reportname;
				textfieldvalue.tag = EnReportTypeTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 1:
				labeltitle.text = @"举报时间";
				textfieldvalue.tag = EnReportTimeTextfieldTag;
				textfieldvalue.text = [AddInterface returnnowdate];
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 2:
				labeltitle.text = @"扫码地点";
				textfieldvalue.placeholder = @"扫码地点";
				textfieldvalue.text = [app.dili.diliprovince stringByAppendingString:app.dili.dilicity];
				textfieldvalue.tag = EnReportScanAddressTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 3:
				labeltitle.text = @"所属区域";
				textfieldvalue.placeholder =@"所属区域";
				if([dicreportinfo count]>0)
				textfieldvalue.text = [[dicreportinfo objectForKey:@"provincename"] stringByAppendingString:[dicreportinfo objectForKey:@"cityname"]];
				textfieldvalue.tag = EnReportAreaTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 4:
				labeltitle.text = @"上级经销商";
				textfieldvalue.placeholder = @"上级经销商";
				if([dicreportinfo count]>0)
					textfieldvalue.text = [dicreportinfo objectForKey:@"distributor"];
				textfieldvalue.tag = EnReportUpJXSTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 5:
				labeltitle.text = @"使用产品";
				textfieldvalue.placeholder = @"使用产品";
				textfieldvalue.text = self.strcommdityname;
				textfieldvalue.tag = EnReportProductTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
		}
	}
	else if(indexPath.section == 1)
	{
		UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 80)];
		textview.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
		textview.layer.borderWidth = 0.5f;
		textview.font = FONTN(14.0f);
		textview.delegate = self;
		textview.tag = EnReportContentTextViewTag;
		[cell.contentView addSubview:textview];
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



#pragma mark 接口
-(void)uploadreport:(NSString *)freportid Appealtime:(NSString *)apptime ScanAddress:(NSString *)scanaddress  Provinceid:(NSString *)provinceid CityId:(NSString *)cityid DisTributorid:(NSString *)distributorid CommodityId:(NSString *)commid AppealContent:(NSString *)appcontent Scancode:(NSString *)scancode
{
	
//	appealcategoryid,appealtime，scanaddress，provinceid，cityid，distributorid，commodityid，appealcontent
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:freportid forKey:@"appealcategoryid"];
	[params setObject:apptime forKey:@"appealtime"];
	[params setObject:scanaddress forKey:@"scanaddress"];
	[params setObject:provinceid forKey:@"provinceid"];
	[params setObject:cityid forKey:@"cityid"];
	[params setObject:distributorid forKey:@"distributorid"];
	[params setObject:commid forKey:@"commodityid"];
	[params setObject:appcontent forKey:@"appealcontent"];
	[params setObject:scancode forKey:@"scancode"];
	
	NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
	for(int i=0;i<[arraypic count];i++)
	{
		DLog(@"arraypic====%@",[arraypic objectAtIndex:i]);
		NSDictionary *dictemp = [arraypic objectAtIndex:i];
		UIImage *image = [AddInterface scaleToSize:[dictemp objectForKey:@"result"] size:CGSizeMake(1000, 1000)];
		[arrayimage addObject:image];
		
	}
	[RequestInterface doGetJsonWithArraypic:arrayimage Parameters:params App:app RequestCode:@"TBEAENG005001023000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			[self.navigationController popToRootViewControllerAnimated:YES];
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	}];
}


-(void)getmyreporttype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001023001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayreporttype = [[dic objectForKey:@"data"] objectForKey:@"appealcategorylist"];
			 UITextField *textfieldvalue = [tableview viewWithTag:EnReportTypeTextfieldTag];
			 if([arrayreporttype count]>0)
			 {
				 NSDictionary *dictemp = [arrayreporttype objectAtIndex:0];
				  reportid = [dictemp objectForKey:@"id"];
				 textfieldvalue.text = [dictemp objectForKey:@"name"];
			 }


			 
			//1
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
}

-(void)getreportinfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001023002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicreportinfo = [[dic objectForKey:@"data"] objectForKey:@"appealinfo"];
			 UITextField *textfield3 = [tableview viewWithTag:EnReportAreaTextfieldTag];
			 UITextField *textfield4 = [tableview viewWithTag:EnReportUpJXSTextfieldTag];
			 UITextField *textfield5 = [tableview viewWithTag:EnReportProductTextfieldTag];
			 textfield3.text = [[dicreportinfo objectForKey:@"provincename"] stringByAppendingString:[dicreportinfo objectForKey:@"cityname"]];
			 textfield4.text = [dicreportinfo objectForKey:@"distributor"];
			 textfield5.text = self.strcommdityname;
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
	selectmodel = sender;  //1表示举报类型
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
	buttoncancel.titleLabel.font = FONTHelve(15.0f);
	[buttoncancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttoncancel addTarget:self action:@selector(cancelbt:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncancel setTitle:@"取消" forState:UIControlStateNormal];
	[viewsheet addSubview:buttoncancel];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
	buttondone.titleLabel.font = FONTHelve(15.0f);
	[buttondone addTarget:self action:@selector(ensurebt:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	[viewsheet addSubview:buttondone];
	
	return viewsheet;
}

- (void)showpickview:(int)sender
{
	[content1 removeAllObjects];
	
	if(sender == 1)  //选择举报类型
	{
		for(int i=0;i<[arrayreporttype count];i++)
		{
			NSDictionary *dictemp = [arrayreporttype objectAtIndex:i];
			[content1 addObject:[dictemp objectForKey:@"name"]];
			reportname = [[arrayreporttype objectAtIndex:0] objectForKey:@"name"];
		}
	}
	else if(sender == 2)   //选择生日
	{
		content1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
		content2 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",nil];
		result2 = [content2 objectAtIndex:0];
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
	
	
	if(selectmodel == 1) //选举举报类型
	{
		NSIndexPath *indexpath= [NSIndexPath indexPathForRow:0 inSection:0];
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
		UITextField *textfieldvalue = [cell viewWithTag:EnReportTypeTextfieldTag];
		textfieldvalue.text = result1;
		for(int i=0;i<[arrayreporttype count];i++)
		{
			NSDictionary *dictemp = [arrayreporttype objectAtIndex:i];
			if([[dictemp objectForKey:@"name"] isEqualToString:result1])
			{
				reportid = [dictemp objectForKey:@"id"];
				break;
			}
		}
	}
	else if(selectmodel == 2)//修改生日
	{
		NSIndexPath *indexpath= [NSIndexPath indexPathForRow:2 inSection:0];
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
		UILabel *labevalue = [cell viewWithTag:EnUserInfoCellLabelTag];
		labevalue.text = [NSString stringWithFormat:@"%@月%@日",result1,result2];
		
		
		//		[self modifyuserinfo:@"brith" ParaValue:[NSString stringWithFormat:@"%@,%@",result1,result2]];
	}
	
	
	
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	if(selectmodel == 1)
		return 1;
	return 2;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if(selectmodel == 1)
	{
		if(component == 0)
			return [content1 count];
	}
	else if(selectmodel == 2)
	{
		if(component == 0)
			return [content1 count];
		else if(component == 1)
			return [content2 count];
	}
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(selectmodel == 1)
	{
		if(component == 0)
			return [content1 objectAtIndex:row];
	}
	else if(selectmodel == 2)
	{
		if(component == 0)
			return [content1 objectAtIndex:row];
		else if(component == 1)
			return [content2 objectAtIndex:row];
	}
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(selectmodel == 1)
	{
		if(component == 0)
			result1 = [content1 objectAtIndex:row];
	}
	else if(selectmodel == 2)
	{
		if(component == 0)
			result1 = [content1 objectAtIndex:row];
		else if(component == 1)
			result1 = [content2 objectAtIndex:row];
		
	}
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
