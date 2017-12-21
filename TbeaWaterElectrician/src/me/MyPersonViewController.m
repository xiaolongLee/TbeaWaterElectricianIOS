//
//  MyPersonViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "MyPersonViewController.h"

@interface MyPersonViewController ()

@end

@implementation MyPersonViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
	[self getuserinfo:@"TBEAENG005001002000"];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	UIImage* img=LOADIMAGE(@"regiest_back", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	content1 = [[NSMutableArray alloc] init];
    content0 = [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = EnMaskViewActionTag;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"个人信息";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	
	
}

#pragma mark actiondelegate 


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
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
	viewbg.backgroundColor = [UIColor clearColor];
	
	
	return viewbg;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row==0)
		return 50;
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 11;
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 10, 150, 20)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.tag = EnUserInfoCellLabelTag;
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	UIImageView *imageheaderview ;
	NSURL *urlstr;
	
	switch (indexPath.row)
	{
		case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"头像";
			imageheaderview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 30, 30)];
			imageheaderview.layer.cornerRadius = 15.0f;
			imageheaderview.clipsToBounds = YES;
			imageheaderview.tag = EnUploadHeaderPicBtTag;
			urlstr = [NSURL URLWithString:[dicuserinfo objectForKey:@"picture"]];
			[imageheaderview setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic2", @"png")];
			[cell.contentView addSubview:imageheaderview];
			break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labeltitle.text = @"昵称";
            labelvalue.text = [dicuserinfo objectForKey:@"nickname"];
            [cell.contentView addSubview:labelvalue];
            break;
		case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"性别";
			labelvalue.text = [dicuserinfo objectForKey:@"sex"];
			[cell.contentView addSubview:labelvalue];
			break;
		case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"生日";
			labelvalue.text = [dicuserinfo objectForKey:@"birthday"];
			[cell.contentView addSubview:labelvalue];
			break;
        case 4:
            labeltitle.text = @"年龄";
            labelvalue.text = [dicuserinfo objectForKey:@"oldyears"];
            [cell.contentView addSubview:labelvalue];
            break;
		case 5:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"电子邮件";
			labelvalue.text = [dicuserinfo objectForKey:@"mailaddr"];
			[cell.contentView addSubview:labelvalue];
			break;
		case 6:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"收货地址管理";
			labelvalue.text = @"添加/修改";
			[cell.contentView addSubview:labelvalue];
			break;
        case 7:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labeltitle.text = @"所在地";
            [cell.contentView addSubview:labelvalue];
            break;
        case 8:
            labeltitle.text = @"隶属";
            labelvalue.text = [dicuserinfo objectForKey:@"companyname"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 9:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labeltitle.text = @"服务范围";
            [cell.contentView addSubview:labelvalue];
            break;
        case 10:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labeltitle.text = @"个人介绍";
            [cell.contentView addSubview:labelvalue];
            break;
			
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ModifyPersonInfoViewController *modifyperson;
	ReceiveAddrViewController *addaddr;
	switch (indexPath.row)
	{
		case 0:
			[self uploadheaderpic];
			break;
        case 1:
            modifyperson = [[ModifyPersonInfoViewController alloc] init];
            modifyperson.delegate1 = self;
            modifyperson.FCtitle = @"昵称";
            [self.navigationController pushViewController:modifyperson animated:YES];
            break;
		case 2:
			[self showaccession:(int)indexPath.row];
			break;
		case 3:
			[self showaccession:(int)indexPath.row];
			break;
		case 5:
			modifyperson = [[ModifyPersonInfoViewController alloc] init];
			modifyperson.delegate1 = self;
            modifyperson.FCtitle = @"电子邮件";
			[self.navigationController pushViewController:modifyperson animated:YES];
			break;
		case 6:
			addaddr = [[ReceiveAddrViewController alloc] init];
			addaddr.fromaddr = @"1";
			[self.navigationController pushViewController:addaddr animated:YES];
			break;
        case 7:
//            addaddr = [[ReceiveAddrViewController alloc] init];
//            addaddr.fromaddr = @"1";
//            [self.navigationController pushViewController:addaddr animated:YES];
            break;
	}
}

#pragma mark IBaction
-(void)uploadheaderpic
{
	[JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
		NSLog(@"%@",images);
		
		UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(1000, 1000)];
		imageheader = image;
		[self uploadUserHeader];
	} cancel:^{
		
	}];
}

#pragma mark 接口
-(void)uploadUserHeader
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
	[arrayimage addObject:imageheader];
	[RequestInterface doGetJsonWithArraypic:arrayimage Parameters:params App:app RequestCode:@"TBEAENG005001002002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			UIImageView *imageviewheader = [tableview viewWithTag:EnUploadHeaderPicBtTag];
			imageviewheader.image = imageheader;
			[MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	}];
}
-(void)getuserinfo:(NSString *)rcode
{
	
	[RequestInterface doGetJsonWithParametersNoAn:nil App:app RequestCode:rcode ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"personinfo"];
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)modifyuserinfo:(NSString *)paratype ParaValue:(NSString *)paravalue
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	if([paratype isEqualToString:@"brith"])
	{
		NSArray  *array = [paravalue componentsSeparatedByString:@","];
		[params setObject:[array objectAtIndex:2] forKey:@"birthday"];
		[params setObject:[array objectAtIndex:1] forKey:@"birthmonth"];
        [params setObject:[array objectAtIndex:0] forKey:@"birthyear"];
        
	}
	else
		[params setObject:paravalue forKey:paratype];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001002001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
	 }];
	
}

#pragma mark - 滚轮选择
-(void)showaccession:(int)sender
{
	selectmodel = sender;
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

	if(sender == 2)  //选择性别
	{
		[content1 addObject:@"先生"];
		[content1 addObject:@"女士"];
	}
	else if(sender == 3)   //选择生日
	{

        for(int i=0;i<100;i++)
        {
            [content0 addObject:[NSString stringWithFormat:@"%d",1918+i]];
        }
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
    if(sender == 2)
    {
        result1 = [content1 objectAtIndex:0];
    }
    else if(sender == 3)
    {
        [picview selectRow:[content0 count]/2 inComponent:0 animated:NO];
        [picview selectRow:[content1 count]/2 inComponent:1 animated:NO];
        result0  = [content0 objectAtIndex:[content0 count]/2];
        result1  = [content1 objectAtIndex:[content1 count]/2];
    }
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
	

	if(selectmodel == 2) //修改性别
	{
		NSIndexPath *indexpath= [NSIndexPath indexPathForRow:2 inSection:0];
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
		UILabel *labevalue = [cell viewWithTag:EnUserInfoCellLabelTag];
		labevalue.text = result1;
		
		[self modifyuserinfo:@"sex" ParaValue:[result1 isEqualToString:@"先生"]?@"male":@"Female"];
		
	}
	else if(selectmodel == 3)//修改生日
	{
		NSIndexPath *indexpath= [NSIndexPath indexPathForRow:3 inSection:0];
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
		UILabel *labevalue = [cell viewWithTag:EnUserInfoCellLabelTag];
		labevalue.text = [NSString stringWithFormat:@"%@年%@月%@日",result0,result1,result2];
		
		
		[self modifyuserinfo:@"brith" ParaValue:[NSString stringWithFormat:@"%@,%@,%@",result0,result1,result2]];
	}
	
	
	
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	if(selectmodel == 2)
		return 1;
	return 3;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if(selectmodel == 2)
	{
		if(component == 0)
			return [content1 count];
	}
	else if(selectmodel == 3)
	{
		if(component == 0)
			return [content0 count];
		else if(component == 1)
			return [content1 count];
        else if(component == 2)
            return [content2 count];
	}
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(selectmodel == 2)
	{
		if(component == 0)
			return [content1 objectAtIndex:row];
	}
	else if(selectmodel == 3)
	{
		if(component == 0)
			return [content0 objectAtIndex:row];
		else if(component == 1)
			return [content1 objectAtIndex:row];
        else if(component == 2)
            return [content2 objectAtIndex:row];
	}
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(selectmodel == 2)
	{
		if(component == 0)
			result1 = [content1 objectAtIndex:row];
	}
	else if(selectmodel ==3)
	{
		if(component == 0)
			result0 = [content0 objectAtIndex:row];
		else if(component == 1)
			result1 = [content1 objectAtIndex:row];
        else if(component == 2)
            result2 = [content2 objectAtIndex:row];

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
