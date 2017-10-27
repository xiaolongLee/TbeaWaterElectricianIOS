//
//  SearchPageViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SearchPageViewController.h"

@interface SearchPageViewController ()

@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
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
	btreturn.frame = CGRectMake(SCREEN_WIDTH-70, 22, 70, 40);
	[btreturn setTitle:@"取消" forState:UIControlStateNormal];
	btreturn.titleLabel.font = FONTN(15.0f);
	[btreturn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btreturn];
	searchtype = EnSearchGoods;
	NSFileManager *filemanger= [NSFileManager defaultManager];
	if([filemanger fileExistsAtPath:SearchhotList])
	{
		arraydata = [[NSMutableArray alloc] initWithContentsOfFile:SearchhotList];
		
	}
	else
	{
		arraydata = [[NSMutableArray alloc] init];
	}
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self gethotword];
	[self searchinpuview];
	
	if([arraydata count]>0)
	{
		[self tablefootview:nil];
	}


}

-(void)tablefootview:(id)sender
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,49)];
	viewfoot.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = COLORNOW(200, 200, 200);
	[viewfoot addSubview:imageline];
	
	UIButton *buttonremove = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonremove.titleLabel.font = FONTN(14.0f);
	buttonremove.layer.cornerRadius = 2.0f;
	buttonremove.clipsToBounds = YES;
	[buttonremove setImage:LOADIMAGE(@"hp_rubbishicon", @"png") forState:UIControlStateNormal];
	[buttonremove setTitleColor:ColorBlackGray forState:UIControlStateNormal];
	[buttonremove setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
	[buttonremove setTitle:@"清空历史记录" forState:UIControlStateNormal];
	[buttonremove addTarget:self action:@selector(clickremovehistory:) forControlEvents:UIControlEventTouchUpInside];
	buttonremove.frame = CGRectMake((SCREEN_WIDTH-200)/2, 7, 200, 36);
	[buttonremove setBackgroundColor:[UIColor clearColor]];
	[viewfoot addSubview:buttonremove];
	
	tableview.tableFooterView = viewfoot;
}

-(void)tabviewheader:(NSArray *)array
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelhotword = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
	labelhotword.text = @"热搜";
	labelhotword.font = FONTMEDIUM(15.0f);
	labelhotword.textColor = ColorBlackdeep;
	[viewheader addSubview:labelhotword];
	
	float nowsitew = 50;
	for(int i=0;i<[array count];i++)
	{
		
		NSDictionary *dictemp  = [array objectAtIndex:i];
		NSString *str = [dictemp objectForKey:@"name"];
		
		CGSize size = [AddInterface getlablesize:str Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
		
		UIButton *buttonhot = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonhot.titleLabel.font = FONTN(14.0f);
		buttonhot.layer.cornerRadius = 3.0f;
		buttonhot.clipsToBounds = YES;
		buttonhot.tag = EnSearchHotWordBtTag+i;
		[buttonhot setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		[buttonhot setTitle:str forState:UIControlStateNormal];
		[buttonhot addTarget:self action:@selector(clickhotword:) forControlEvents:UIControlEventTouchUpInside];
		buttonhot.frame = CGRectMake(nowsitew, 10, size.width+10, 30);
		[buttonhot setBackgroundColor:Colorgray];
		[viewheader addSubview:buttonhot];
		nowsitew = nowsitew+buttonhot.frame.size.width+10;
	}
	tableview.tableHeaderView = viewheader;
}

//搜索框
-(void)searchinpuview
{
	SearchPageTopView *searchview = [[SearchPageTopView alloc] initWithgoods:CGRectMake(10, 27, SCREEN_WIDTH-70, 30)];
	searchview.tag = EnNearSearchViewBt;
	searchview.delgate1 = self;
	[self.view addSubview:searchview];
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	SearchPageTopView *searchview = [self.view viewWithTag:EnNearSearchViewBt];
	UITextField *textfield = [searchview viewWithTag:EnSearchTextfieldCityTag3];
	[textfield resignFirstResponder];
}

#pragma mark tabbleview代理
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
	viewbg.backgroundColor = COLORNOW(240, 240, 240);
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
	labelmoney.text = @"  历史搜索";
	labelmoney.font = FONTMEDIUM(14.0f);
	labelmoney.textColor = ColorBlackdeep;
	labelmoney.backgroundColor = [UIColor whiteColor];
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
	
	NSString *strname = [arraydata objectAtIndex:indexPath.row];
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-30, 20)];
	labeltitle.text = strname;
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *str = [arraydata objectAtIndex:indexPath.row];
	SearchResultViewController *searresult = [[SearchResultViewController alloc] init];
	searresult.searchtext = str;
	searresult.searchtype = searchtype;
	[self.navigationController pushViewController:searresult animated:YES];
	
}


#pragma mark Actiondelegate
-(void)DGClickSearchResultTextField:(NSString *)sender
{
	int flag = 0;
	for(int i=0;i<[arraydata count];i++)
	{
		NSString *str = [arraydata objectAtIndex:i];
		if([str isEqualToString:sender])
		{
			flag =1;
			break;
		}
	}
	
	if(flag == 0)
	{
		if([arraydata count]>19)
		{
			[arraydata removeLastObject];
		}
		[arraydata addObject:sender];
		
		[arraydata writeToFile:SearchhotList atomically:NO];
	}
	
	SearchResultViewController *searresult = [[SearchResultViewController alloc] init];
	searresult.searchtext = sender;
	searresult.searchtype = searchtype;
	[self.navigationController pushViewController:searresult animated:YES];
	
	
}

#pragma mark IBAction
-(void)clickremovehistory:(id)sender
{
	NSFileManager *filemanger = [NSFileManager defaultManager];
	if([filemanger fileExistsAtPath:SearchhotList])
	{
		[filemanger removeItemAtPath:SearchhotList error:nil];
		arraydata = [[NSMutableArray alloc] init];
		[tableview reloadData];
	}
}

-(void)clickhotword:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnSearchHotWordBtTag;
	NSDictionary *dictemp = [arrayhot objectAtIndex:tagnow];
	SearchResultViewController *searresult = [[SearchResultViewController alloc] init];
	searresult.searchtext = [dictemp objectForKey:@"name"];
	searresult.searchtype = searchtype;
	[self.navigationController pushViewController:searresult animated:YES];
	
}

-(void)returnback:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 接口
-(void)gethotword
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:[NSString stringWithFormat:@"%d",searchtype] forKey:@"searchtype"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001003000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arrayhot = [[dic objectForKey:@"data"] objectForKey:@"hotwordlist"];
			 [self tabviewheader:arrayhot];
			 
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
