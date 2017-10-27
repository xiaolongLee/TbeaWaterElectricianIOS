//
//  MyReportDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyReportDetailViewController.h"

@interface MyReportDetailViewController ()

@end

@implementation MyReportDetailViewController

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
	
	self.title = @"举报详情";
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self initview];
	UserLocationObject *location = [[UserLocationObject alloc] init];
	location.delegate1 = self;
	[location getnowlocation];
	[self getmyreportinfo:self.strreportid];
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = [UIColor whiteColor];
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

	arraypic = [[NSMutableArray alloc] init];

	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"举报详情";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	
	
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
	int countpic = (int)[sender count]==8?8:(int)[sender count];
	counth = (countpic%4==0?countpic/4:countpic/4+1);
	
	UIButton *buttonphoto = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonphoto.frame = CGRectMake(20,20, widthnow, widthnow);
	[buttonphoto setBackgroundColor:[UIColor clearColor]];
	buttonphoto.tag = EnMyReportAddPicButtonTag;
	[buttonphoto setBackgroundImage:LOADIMAGE(@"addpic", @"png") forState:UIControlStateNormal];
//	[buttonphoto addTarget:self action:@selector(clickselectphoto:) forControlEvents:UIControlEventTouchUpInside];
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
			
			NSDictionary *dictemp = [sender objectAtIndex:i*4+j];
//			if(([sender count]!=8)&&(i== counth-1)&&(j==countv-1))
//			{
//				buttonphoto.frame = CGRectMake(orginx+(space+widthnow)*j, orginy, widthnow, widthnow);
//			}
//			else
//			{
				UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(orginx+(space+widthnow)*j, orginy, widthnow, widthnow)];
				NSURL *urlstr = [NSURL URLWithString:[dictemp objectForKey:@"picture"]];
				[imagepic setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic2", @"png")];
				imagepic.tag = EnMyReportPicImageViewTag+i*4+j;
				imagepic.contentMode = UIViewContentModeScaleAspectFill;
				imagepic.clipsToBounds = YES;
				[viewbg addSubview:imagepic];
				
//				UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
//				buttondelete.frame = CGRectMake(imagepic.frame.origin.x+imagepic.frame.size.width-20, imagepic.frame.origin.y+3, 15, 15);
//				[buttondelete setBackgroundColor:[UIColor clearColor]];
//				buttondelete.tag = EnMyReportDeletePicBtTag+i*4+j;
//				[buttondelete setBackgroundImage:LOADIMAGE(@"deleteicon", @"png") forState:UIControlStateNormal];
//				[buttondelete addTarget:self action:@selector(clickdeletephoto:) forControlEvents:UIControlEventTouchUpInside];
//				[viewbg addSubview:buttondelete];
//			}
			
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
	
//	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(10, viewcontent.frame.origin.y+viewcontent.frame.size.height+20,SCREEN_WIDTH-10, 70)];
//	labelins.textColor = ColorBlackVeryGray;
//	labelins.font = FONTN(12.0f);
//	labelins.numberOfLines = 4;
//	labelins.text = @"请尽量填写您购买产品的地点、时间和商家名称，最好拍照取证，\n以便我公司人员排查，谢谢你的合作。\n联系电话 0838-2801518";
//	[viewbg addSubview:labelins];
//	
//	UIButton *btdone = [UIButton buttonWithType:UIButtonTypeCustom];
//	btdone.backgroundColor = COLORNOW(27, 130, 210);
//	btdone.frame = CGRectMake(10, labelins.frame.origin.y+labelins.frame.size.height+10,SCREEN_WIDTH-20, 35);
//	[btdone setTitle:@"提交" forState:UIControlStateNormal];
//	[btdone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	btdone.titleLabel.font = FONTN(15.0f);
//	[btdone addTarget:self action:@selector(clickbtdone:) forControlEvents:UIControlEventTouchUpInside];
//	btdone.layer.cornerRadius= 2.0f;
//	btdone.clipsToBounds = YES;
//	[viewbg addSubview:btdone];
	
	viewbg.frame = CGRectMake(0, 0, SCREEN_WIDTH, viewcontent.frame.origin.y+viewcontent.frame.size.height+20);
	
	tableview.tableFooterView = viewbg;
	
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
	}
	
}

#pragma mark UitextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
				textfieldvalue.text  = [dicreportinfo objectForKey:@"appealcategory"];
				textfieldvalue.tag = EnReportTypeTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 1:
				labeltitle.text = @"举报时间";
				textfieldvalue.text = [dicreportinfo objectForKey:@"appealtime"];
				textfieldvalue.tag = EnReportTimeTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 2:
				labeltitle.text = @"扫码地点";
				textfieldvalue.placeholder = @"扫码地点";
				textfieldvalue.text = [dicreportinfo objectForKey:@"scanaddress"];
				textfieldvalue.tag = EnReportScanAddressTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 3:
				labeltitle.text = @"所属区域";
				textfieldvalue.placeholder =@"所属区域";
				textfieldvalue.text = [dicreportinfo objectForKey:@"provincecity"];
				textfieldvalue.tag = EnReportAreaTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 4:
				labeltitle.text = @"上级经销商";
				textfieldvalue.placeholder = @"上级经销商";
				textfieldvalue.text = [dicreportinfo objectForKey:@"distributor"];
				textfieldvalue.tag = EnReportUpJXSTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
			case 5:
				labeltitle.text = @"使用产品";
				textfieldvalue.placeholder = @"使用产品";
				textfieldvalue.text = [dicreportinfo objectForKey:@"commodity"];
				textfieldvalue.tag = EnReportProductTextfieldTag;
				[cell.contentView addSubview:textfieldvalue];
				break;
		}
	}
	else if(indexPath.section == 1)
	{
		UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 80)];
//		textview.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
//		textview.layer.borderWidth = 0.5f;
		textview.font = FONTN(14.0f);
		textview.delegate = self;
		textview.editable = NO;
		textview.text = [dicreportinfo objectForKey:@"appealcontent"];
		textview.tag = EnReportContentTextViewTag;
		[cell.contentView addSubview:textview];
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



#pragma mark 接口
-(void)getmyreportinfo:(NSString *)reportid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:reportid forKey:@"appealid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001025000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicreportinfo = [[dic objectForKey:@"data"] objectForKey:@"appealinfo"];
			 
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
			 if([(NSArray *)[dicreportinfo objectForKey:@"picturelist"] count]>0)
				 [self initfootview:[dicreportinfo objectForKey:@"picturelist"]];
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
