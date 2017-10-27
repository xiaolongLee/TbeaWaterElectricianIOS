//
//  SelectCityViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SelectCityViewController.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(243, 243, 243);
	[self initview];

    // Do any additional setup after loading the view.
}

-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];

	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"hp_colse", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];

	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self getcitylist:@""];
	[self searchinpuview];
	[self tabviewheader];
}

-(void)tabviewheader
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageviewlocation = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
	imageviewlocation.image = LOADIMAGE(@"hp_locationicon", @"png");
	[viewheader addSubview:imageviewlocation];
	
	UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(imageviewlocation.frame.origin.x+imageviewlocation.frame.size.width+10, 15, 200, 20)];
	labeladdr.font = FONTN(14.0f);
	labeladdr.textColor = ColorBlackGray;
	labeladdr.text = [NSString stringWithFormat:@"%@ %@ %@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality];
	labeladdr.tag = EnSelectCityLocation;
	[viewheader addSubview:labeladdr];
	
	UIButton *buttonGPS = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonGPS.titleLabel.font = FONTN(12.0f);
	[buttonGPS setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	[buttonGPS setTitle:@"GPS定位" forState:UIControlStateNormal];
	[buttonGPS addTarget:self action:@selector(GPSLocation:) forControlEvents:UIControlEventTouchUpInside];
	buttonGPS.frame = CGRectMake(SCREEN_WIDTH-90, 10, 80, 30);
	[buttonGPS setBackgroundColor:Colorgray];
	[viewheader addSubview:buttonGPS];
	
	tableview.tableHeaderView = viewheader;
}

//搜索框
-(void)searchinpuview
{
	SearchPageTopView *searchview = [[SearchPageTopView alloc] initWithFrame:CGRectMake(60, 27, SCREEN_WIDTH-70, 30) Whiter:1];
	searchview.tag = EnNearSearchViewBt;
	searchview.delgate1 = self;
	[self.view addSubview:searchview];
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	SearchPageTopView *searchview = [self.view viewWithTag:EnNearSearchViewBt];
	UITextField *textfield = [searchview viewWithTag:EnSearchTextfieldCityTag1];
	[textfield resignFirstResponder];
}

#pragma mark tabbleview代理
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewbg.backgroundColor = COLORNOW(240, 240, 240);
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 160, 20)];
	labelmoney.text = @"选择城市";
	labelmoney.font = FONTMEDIUM(14.0f);
	labelmoney.textColor = ColorBlackdeep;
	[viewbg addSubview:labelmoney];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewbg.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = ColorBlackGray;
	[viewbg addSubview:imageline];
	
	return viewbg;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arraydata count];
	
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
	
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-30, 20)];
	labeltitle.text = [dictemp objectForKey:@"name"];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	SearchPageTopView *searchview = [self.view viewWithTag:EnNearSearchViewBt];
	UITextField *textfield = [searchview viewWithTag:EnSearchTextfieldCityTag1];
	[textfield resignFirstResponder];
	
	NSDictionary *diccity = [arraydata objectAtIndex:indexPath.row];
	if([self.delegate1 respondsToSelector:@selector(DGSelectCityDone:)])
	{
		[self.delegate1 DGSelectCityDone:diccity];
	}
	
	[self returnback:nil];
	
}


#pragma mark Actiondelegate
-(void)DGGetUserLocatioObject:(id)sender
{
	UILabel *labeladdr = [tableview.tableHeaderView viewWithTag:EnSelectCityLocation];
	labeladdr.text = [NSString stringWithFormat:@"%@ %@ %@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality];
}

-(void)DGClickSearchCityTextField:(NSString *)sender
{
	[self getcitylist:sender];
}

#pragma mark IBAction
-(void)GPSLocation:(id)sender
{
	UserLocationObject *location = [[UserLocationObject alloc] init];
	location.delegate1 = self;
	[location getnowlocation];
	
}

-(void)returnback:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 接口
-(void)getcitylist:(NSString *)cityname
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:cityname forKey:@"cityname"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001002000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"citylist"];
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
