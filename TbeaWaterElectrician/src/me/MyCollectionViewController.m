//
//  MyCollectionViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{

	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];

	
	//扫码记录
	self.title = @"我的收藏";

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setTitle:@"编辑" forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTMEDIUM(14.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[buttonright addTarget:self action: @selector(gotoedit:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;

	arrarselectitem = [[NSMutableArray alloc] init];
	collectionedit = EnCollectionEditStart;
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self getmycollection:@"1" Pagesize:@"10"];
	
	[self setExtraCellLineHidden:tableview];
	
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
//	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
//	tableview.mj_footer = footer;
}

-(void)addremoveview
{
	UIView *viewremove = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
	viewremove.backgroundColor = Colorgray;
	viewremove.tag = EnCollectionRemoveViewTag;
	[self.view addSubview:viewremove];
	
	UIButton *buttonremove = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonremove.titleLabel.font = FONTN(15.0f);
	buttonremove.layer.cornerRadius = 3.0f;
	buttonremove.clipsToBounds = YES;
	[buttonremove setTitle:@"取消收藏" forState:UIControlStateNormal];
	[buttonremove addTarget:self action:@selector(removeselectitem:) forControlEvents:UIControlEventTouchUpInside];
	buttonremove.frame = CGRectMake(50, 10, (SCREEN_WIDTH-100),30);
	[buttonremove setBackgroundColor:COLORNOW(233, 79, 79)];
	[viewremove addSubview:buttonremove];
}

#pragma mark Actiondegate
-(void)DGSelectCollectionItem:(NSDictionary *)selectitem SBt:(UIButton *)sbt
{
	int flag = 0;
	for(int i=0;i<[arrarselectitem count];i++)
	{
		NSDictionary *dictemp = [arrarselectitem objectAtIndex:i];
		if([[dictemp objectForKey:@"id"] isEqualToString:[selectitem objectForKey:@"id"]])
		{
			flag = 1;
			break;
		}
		
	}
	if(flag == 0)
	{
		[sbt setImage:LOADIMAGE(@"me_collectionselected", @"png") forState:UIControlStateNormal];
		[arrarselectitem addObject:selectitem];
	}
	else
	{
		[sbt setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
		[arrarselectitem removeObject:selectitem];
	}
}

#pragma mark IBAction
-(void)loadNewData:(id)sender
{
	[self getmycollection:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self getmycollection:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}


-(void)removeselectitem:(id)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除所选记录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		NSString *removeids = @"";
		for(int i=0;i<[arrarselectitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectitem objectAtIndex:i];
			if([removeids length]==0)
				removeids = [dictemp objectForKey:@"id"];
			else
			{
				removeids = [NSString stringWithFormat:@"%@,%@",removeids,[dictemp objectForKey:@"id"]];
			}
			
		}
		if([removeids length]>0)
		{
			[self removemycollection:removeids];
		}
		
		
	}];
	
	// Add the actions.
	[alertController addAction:cancelAction];
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

-(void)gotoedit:(id)sender
{
	UIButton *button  = (UIButton *)sender;
	
	if(collectionedit == EnCollectionEditStart)
	{
		[arrarselectitem removeAllObjects];
		collectionedit = EnCollectionEditDone;
		self.title = @"编辑收藏";
		[button setTitle:@"完成" forState:UIControlStateNormal];
		[self addremoveview];
	}
	else if(collectionedit == EnCollectionEditDone)
	{
		collectionedit = EnCollectionEditStart;
		self.title = @"我的收藏";
		[button setTitle:@"编辑" forState:UIControlStateNormal];
		[[self.view viewWithTag:EnCollectionRemoveViewTag] removeFromSuperview];
	}
	[tableview reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
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
	return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	//NSArray *arrayhp = [dichp objectForKey:@"companylist"];
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
	if(collectionedit == EnCollectionEditStart)
	{
		NearByProductPageCellView *productcell = [[NearByProductPageCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp];
		[cell.contentView addSubview:productcell];
	}
	else
	{
		ProductCellSelectItemView *productcell = [[ProductCellSelectItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp TagNow:(int)indexPath.row];
		productcell.delegate1 = self;
		[cell.contentView addSubview:productcell];
		
		UIButton *button = (UIButton *)[productcell viewWithTag:EnCollectionSelectItemBtTag];
		int flag = 0;
		for(int i=0;i<[arrarselectitem count];i++)
		{
			NSDictionary *dicselect = [arrarselectitem objectAtIndex:i];
			if([[dicselect objectForKey:@"id"] isEqualToString:[dictemp objectForKey:@"id"]])
			{
				flag = 1;
				break;
			}
			
		}
		if(flag == 1)
		{
			[button setImage:LOADIMAGE(@"me_collectionselected", @"png") forState:UIControlStateNormal];
		}

	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	NearByGoodsDetailViewController *goodsdetail = [[NearByGoodsDetailViewController alloc] init];
	goodsdetail.strproductid = [dictemp objectForKey:@"commodityid"];
	goodsdetail.strdistrid = [dictemp objectForKey:@"companyid"];
	goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
	[self.navigationController pushViewController:goodsdetail animated:YES];
}

#pragma mark 接口
-(void)getmycollection:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001012000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
     Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"mysavelist"]];
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 [tableview reloadData];
			 if([arraydata count]>9)
			 {
				 MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
				 tableview.mj_footer = footer;
			 }
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 
	 }];
	
	[tableview.mj_header endRefreshing];
	[tableview.mj_footer endRefreshing];
	
}

-(void)removemycollection:(NSString *)saveids
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:saveids forKey:@"saveids"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001012001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 for(int i=0;i<[arrarselectitem count];i++)
			 {
				 NSDictionary *dic = [arrarselectitem objectAtIndex:i];
				 [arraydata removeObject:dic];
			 }
			 
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
