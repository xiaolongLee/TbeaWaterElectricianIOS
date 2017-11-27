//
//  MyShoppingCarViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyShoppingCarViewController.h"

@interface MyShoppingCarViewController ()

@end

@implementation MyShoppingCarViewController

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
	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] removeFromSuperview];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

-(void)initview
{
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	//扫码记录
	self.title = @"购物车";
	
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
	
	selectremoveall = EnNotSelect;
	selectsettlementall = EnNotSelect;
	arrayshopcarnumber = [[NSMutableArray alloc] init];
	arrarselectremoveitem = [[NSMutableArray alloc] init];
	arrarselectsettlementitem = [[NSMutableArray alloc] init];
	collectionedit = EnCollectionEditStart;
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-40-40-IPhone_SafeBottomMargin) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self requestmyshoppingcar:@"1" Pagesize:@"10"];
	[self addsettlementview];
}

-(void)addremoveview
{
	UIView *viewremove = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-40, SCREEN_WIDTH, 40)];
	viewremove.backgroundColor = ColorMoregray;
	viewremove.tag = EnShoppingCarRemoveViewTag;
	[self.view addSubview:viewremove];
	
	
	UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitem.titleLabel.font = FONTN(14.0f);
	[buttonitem setTitle:@" 全选" forState:UIControlStateNormal];
	[buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	buttonitem.tag = EnShoppingCarDeleteSelectAllBtTag;
	[buttonitem setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
	[buttonitem addTarget:self action:@selector(clickselectall:) forControlEvents:UIControlEventTouchUpInside];
	buttonitem.frame = CGRectMake(10, 0, 70,40 );
	[buttonitem setBackgroundColor:[UIColor clearColor]];
	[viewremove addSubview:buttonitem];
	
	UIButton *buttonremove = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonremove.titleLabel.font = FONTN(15.0f);
	[buttonremove setTitle:@"删除" forState:UIControlStateNormal];
	[buttonremove addTarget:self action:@selector(removeselectitem:) forControlEvents:UIControlEventTouchUpInside];
	buttonremove.frame = CGRectMake(SCREEN_WIDTH-120, 0, 120,40);
	[buttonremove setBackgroundColor:COLORNOW(233, 79, 79)];
	[viewremove addSubview:buttonremove];
}

-(void)addsettlementview
{
	UIView *viewsettlement = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBarHeight-40-40-IPhone_SafeBottomMargin, SCREEN_WIDTH, 40)];
	viewsettlement.backgroundColor = ColorMoregray;
	viewsettlement.tag = EnShoppingCarSettlementTag;
	[self.view addSubview:viewsettlement];
	
	UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitem.titleLabel.font = FONTN(14.0f);
	[buttonitem setTitle:@" 全选" forState:UIControlStateNormal];
	[buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	buttonitem.tag = EnShoppingCarSettlementSelectAllBtTag;
	[buttonitem setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
	[buttonitem addTarget:self action:@selector(clickselectall:) forControlEvents:UIControlEventTouchUpInside];
	buttonitem.frame = CGRectMake(10, 0, 70,40 );
	[buttonitem setBackgroundColor:[UIColor clearColor]];
	[viewsettlement addSubview:buttonitem];
	
	
	UIButton *buttonremove = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonremove.titleLabel.font = FONTN(15.0f);
	[buttonremove setTitle:@"结算" forState:UIControlStateNormal];
	[buttonremove addTarget:self action:@selector(clicksettlementitem:) forControlEvents:UIControlEventTouchUpInside];
	buttonremove.frame = CGRectMake(SCREEN_WIDTH-120, 0, 120,40);
	[buttonremove setBackgroundColor:Colorredcolor];
	[viewsettlement addSubview:buttonremove];
	
	UILabel *labelallprice = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, SCREEN_WIDTH-120-110, 40)];
	labelallprice.text = [NSString stringWithFormat:@"合计:￥%@",@"123"];
	labelallprice.textColor = Colorredcolor;
	labelallprice.font = FONTN(17.0f);
	labelallprice.tag = EnShoppingCarAllPriceLabelTag;
	labelallprice.textAlignment = NSTextAlignmentRight;
	[viewsettlement addSubview:labelallprice];
}

#pragma mark Actiondegate
-(void)DGClickAddNumberBtTag:(NSDictionary *)sender NowNumber:(NSString *)number
{
	int flag = 0;
	for(int j=0;j<[arrayshopcarnumber count];j++)
	{
		NSMutableDictionary *dicnumber = [arrayshopcarnumber objectAtIndex:j];
		if([[dicnumber objectForKey:@"orderdetailid"] isEqualToString:[sender objectForKey:@"orderdetailid"]])
		{
			flag =1;
			[dicnumber setObject:number forKey:@"ordernumber"];
			break;
		}
	}
	
	float nowallprice = 0;
	for(int i=0;i<[arrarselectsettlementitem count];i++)
	{
		NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
		
		NSString *snumber;
		for(int j=0;j<[arrayshopcarnumber count];j++)
		{
			NSDictionary *dicu = [arrayshopcarnumber objectAtIndex:j];
			if([[dicu objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
			{
				snumber = [dicu objectForKey:@"ordernumber"];
				break;
			}
		}
		
		int intnumber = [snumber intValue];
		float nowprice = [[dictemp objectForKey:@"orderprice"] floatValue];
		nowallprice = nowallprice+nowprice*intnumber;
	}
	
	UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
	labelprice.text = [NSString stringWithFormat:@"实付款:￥%.2f",nowallprice];

}

-(void)DGClickReduceNumberBtTag:(NSDictionary *)sender  NowNumber:(NSString *)number
{
	int flag = 0;
	for(int j=0;j<[arrayshopcarnumber count];j++)
	{
		NSMutableDictionary *dicnumber = [arrayshopcarnumber objectAtIndex:j];
		if([[dicnumber objectForKey:@"orderdetailid"] isEqualToString:[sender objectForKey:@"orderdetailid"]])
		{
			flag =1;
			[dicnumber setObject:number forKey:@"ordernumber"];
			break;
		}
	}
	
	float nowallprice = 0;
	for(int i=0;i<[arrarselectsettlementitem count];i++)
	{
		NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
		
		NSString *snumber;
		for(int j=0;j<[arrayshopcarnumber count];j++)
		{
			NSDictionary *dicu = [arrayshopcarnumber objectAtIndex:j];
			if([[dicu objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
			{
				snumber = [dicu objectForKey:@"ordernumber"];
				break;
			}
		}
		
		int intnumber = [snumber intValue];
		float nowprice = [[dictemp objectForKey:@"orderprice"] floatValue];
		nowallprice = nowallprice+nowprice*intnumber;
	}
	
	UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
	labelprice.text = [NSString stringWithFormat:@"实付款:￥%.2f",nowallprice];
}

-(void)DGSelectCollectionItem:(NSDictionary *)selectitem SBt:(UIButton *)sbt
{
	if(collectionedit == EnCollectionEditDone)
	{
		int flag = 0;
		for(int i=0;i<[arrarselectremoveitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectremoveitem objectAtIndex:i];
			if([[dictemp objectForKey:@"orderdetailid"] isEqualToString:[selectitem objectForKey:@"orderdetailid"]])
			{
				flag = 1;
				break;
			}
			
		}
		if(flag == 0)
		{
			[sbt setImage:LOADIMAGE(@"me_shopcarselected", @"png") forState:UIControlStateNormal];
			[arrarselectremoveitem addObject:selectitem];
		}
		else
		{
			[sbt setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			[arrarselectremoveitem removeObject:selectitem];
		}
	}
	else if(collectionedit == EnCollectionEditStart)
	{
		int flag = 0;
		for(int i=0;i<[arrarselectsettlementitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
			if([[dictemp objectForKey:@"orderdetailid"] isEqualToString:[selectitem objectForKey:@"orderdetailid"]])
			{
				flag = 1;
				break;
			}
		}
		if(flag == 0)
		{
			[sbt setImage:LOADIMAGE(@"me_collectionselected", @"png") forState:UIControlStateNormal];
			[arrarselectsettlementitem addObject:selectitem];
		}
		else
		{
			[sbt setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			[arrarselectsettlementitem removeObject:selectitem];
		}
		
		float nowallprice = 0;
		for(int i=0;i<[arrarselectsettlementitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
			
			NSString *snumber;
			for(int j=0;j<[arrayshopcarnumber count];j++)
			{
				NSDictionary *dicu = [arrayshopcarnumber objectAtIndex:j];
				if([[dicu objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
				{
					snumber = [dicu objectForKey:@"ordernumber"];
					break;
				}
			}
			
			int intnumber = [snumber intValue];
			float nowprice = [[dictemp objectForKey:@"orderprice"] floatValue];
			nowallprice = nowallprice+nowprice*intnumber;
		}
		
		UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
		labelprice.text = [NSString stringWithFormat:@"合计:￥%.2f",nowallprice];
	}
}

#pragma mark IBAction
-(void)clicksettlementitem:(id)sender
{
	if([arrarselectsettlementitem count]==0)
	{
		[MBProgressHUD showError:@"你至少需要选择一个产品" toView:app.window];
	}
	else
	{
		NSMutableArray *arrayparame = [[NSMutableArray alloc] init];
		NSMutableArray *arrayparamepic = [[NSMutableArray alloc] init];
//		float nowfee = 0;
		for(int i=0;i<[arrarselectsettlementitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
			
			NSString *snumber;
			for(int j=0;j<[arrayshopcarnumber count];j++)
			{
				NSDictionary *dicu = [arrayshopcarnumber objectAtIndex:j];
				if([[dicu objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
				{
					snumber = [dicu objectForKey:@"ordernumber"];
					break;
				}
			}
			NSDictionary *dicpara = [NSDictionary dictionaryWithObjectsAndKeys:[dictemp objectForKey:@"orderdetailid"],@"orderdetailid",snumber,@"ordernumber", nil];
			[arrayparame addObject:dicpara];
			
			NSDictionary *dicpara1 = [NSDictionary dictionaryWithObjectsAndKeys:[dictemp objectForKey:@"orderdetailid"],@"orderdetailid",[dictemp objectForKey:@"commoditypicture"],@"commoditypicture", nil];
			[arrayparamepic addObject:dicpara1];
		}
		
		MyInputOrderViewController *inputorder = [[MyInputOrderViewController alloc] init];
		inputorder.arraycommonditynumber = arrayparame;
		inputorder.arraycommonditypic = arrayparamepic;
		[self.navigationController pushViewController:inputorder animated:YES];

	}
	
}

-(void)clickselectall:(id)sender
{
	UIButton *button =(UIButton *)sender;
	int tagnow = (int)[button tag];
	if(tagnow == EnShoppingCarDeleteSelectAllBtTag)  //删除全选
	{
		selectsettlementall = EnNotSelect;
		[arrarselectsettlementitem removeAllObjects];
		UIButton *buttontemp = [self.view viewWithTag:EnShoppingCarSettlementSelectAllBtTag];
		[buttontemp setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
		if(selectremoveall == EnNotSelect)
		{
			selectremoveall = EnSelectd;
			arrarselectremoveitem = [[NSMutableArray alloc] initWithArray:arraydata];
			[button setImage:LOADIMAGE(@"me_shopcarselected", @"png") forState:UIControlStateNormal];
			for(int i=0;i<[arraydata count];i++)
			{
				NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
				UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
				UIButton *buttontemp = (UIButton *)[cell viewWithTag:EnCollectionSelectItemBtTag];
				[buttontemp setImage:LOADIMAGE(@"me_shopcarselected", @"png") forState:UIControlStateNormal];
			}
		}
		else
		{
			selectremoveall = EnNotSelect;
			[button setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			for(int i=0;i<[arraydata count];i++)
			{
				arrarselectremoveitem = [[NSMutableArray alloc] init];
				NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
				UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
				UIButton *buttontemp = (UIButton *)[cell viewWithTag:EnCollectionSelectItemBtTag];
				[buttontemp setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			}
		}
	}
	else if(tagnow == EnShoppingCarSettlementSelectAllBtTag)// 结算全选
	{
		[arrarselectremoveitem removeAllObjects];
		selectremoveall = EnNotSelect;
		UIButton *buttontemp = [self.view viewWithTag:EnShoppingCarDeleteSelectAllBtTag];
		[buttontemp setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
		if(selectsettlementall == EnNotSelect)  //未选中变选中
		{
			selectsettlementall = EnSelectd;
			arrarselectsettlementitem = [[NSMutableArray alloc] initWithArray:arraydata];
			[button setImage:LOADIMAGE(@"me_collectionselected", @"png") forState:UIControlStateNormal];
			for(int i=0;i<[arraydata count];i++)
			{
				NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
				UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
				UIButton *buttontemp = (UIButton *)[cell viewWithTag:EnCollectionSelectItemBtTag];
				[buttontemp setImage:LOADIMAGE(@"me_collectionselected", @"png") forState:UIControlStateNormal];
			}
			
			[arrayshopcarnumber removeAllObjects];
			
			for(int i=0;i<[arraydata count];i++)
			{
				int flag = 0;
				NSDictionary *diccommodity = [arraydata objectAtIndex:i];
				for(int j=0;j<[arrayshopcarnumber count];j++)
				{
					NSDictionary *dicnumber = [arrayshopcarnumber objectAtIndex:j];
					if([[dicnumber objectForKey:@"orderdetailid"] isEqualToString:[diccommodity objectForKey:@"orderdetailid"]])
					{
						flag =1;
						break;
					}
				}
				if(flag == 0)
				{
					NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];//
					[dictemp setObject:[diccommodity objectForKey:@"orderdetailid"] forKey:@"orderdetailid"];
					[dictemp setObject:[diccommodity objectForKey:@"ordernumber"] forKey:@"ordernumber"];
					[arrayshopcarnumber addObject:dictemp];
				}
			}
			
			float nowallprice = 0;
			for(int i=0;i<[arrarselectsettlementitem count];i++)
			{
				NSDictionary *dictemp = [arrarselectsettlementitem objectAtIndex:i];
				
				NSString *snumber;
				for(int j=0;j<[arrayshopcarnumber count];j++)
				{
					NSDictionary *dicu = [arrayshopcarnumber objectAtIndex:j];
					if([[dicu objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
					{
						snumber = [dicu objectForKey:@"ordernumber"];
						break;
					}
				}
				
				int intnumber = [snumber intValue];
				float nowprice = [[dictemp objectForKey:@"orderprice"] floatValue];
				nowallprice = nowallprice+nowprice*intnumber;
			}
			
			UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
			labelprice.text = [NSString stringWithFormat:@"合计:￥%.2f",nowallprice];
		}
		else    //选中变未选中
		{
			selectsettlementall = EnNotSelect;
			arrarselectsettlementitem = [[NSMutableArray alloc] init];
			[button setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			for(int i=0;i<[arraydata count];i++)
			{
				arrarselectremoveitem = [[NSMutableArray alloc] init];
				NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
				UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
				UIButton *buttontemp = (UIButton *)[cell viewWithTag:EnCollectionSelectItemBtTag];
				[buttontemp setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
			}
			UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
			labelprice.text = [NSString stringWithFormat:@"合计:￥%@",@"0.00"];
		}
	}
}


-(void)removeselectitem:(id)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除所选记录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		NSString *removeids = @"";
		for(int i=0;i<[arrarselectremoveitem count];i++)
		{
			NSDictionary *dictemp = [arrarselectremoveitem objectAtIndex:i];
			if([removeids length]==0)
				removeids = [dictemp objectForKey:@"orderdetailid"];
			else
			{
				removeids = [NSString stringWithFormat:@"%@,%@",removeids,[dictemp objectForKey:@"orderdetailid"]];
			}
			
		}
		if([removeids length]>0)
		{
			[self removemyshopcar:removeids];
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
	
	[arrarselectsettlementitem removeAllObjects];
	selectsettlementall = EnNotSelect;
	UIButton *buttontemp = [self.view viewWithTag:EnShoppingCarSettlementSelectAllBtTag];
	[buttontemp setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
	
	if(collectionedit == EnCollectionEditStart)
	{
		[arrarselectremoveitem removeAllObjects];
		collectionedit = EnCollectionEditDone;
		[button setTitle:@"完成" forState:UIControlStateNormal];
		[self addremoveview];
	}
	else if(collectionedit == EnCollectionEditDone)
	{
		collectionedit = EnCollectionEditStart;
		[button setTitle:@"编辑" forState:UIControlStateNormal];
		[[self.view viewWithTag:EnShoppingCarRemoveViewTag] removeFromSuperview];
		UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
		labelprice.text = [NSString stringWithFormat:@"合计:￥%@",@"0.00"];
	}
	[tableview reloadData];
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

	ShoppingCarCellView *productcell = [[ShoppingCarCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp TagNow:(int)indexPath.row ArrayNumber:arrayshopcarnumber];
	productcell.delegate1 = self;
	[cell.contentView addSubview:productcell];
	
	if(collectionedit == EnCollectionEditDone) //选择删除时间 删除
	{
		UIButton *button = (UIButton *)[productcell viewWithTag:EnCollectionSelectItemBtTag];
		int flag = 0;
		for(int i=0;i<[arrarselectremoveitem count];i++)
		{
			NSDictionary *dicselect = [arrarselectremoveitem objectAtIndex:i];
			if([[dicselect objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
			{
				flag = 1;
				break;
			}
			
		}
		if(flag == 1)
		{
			[button setImage:LOADIMAGE(@"me_shopcarselected", @"png") forState:UIControlStateNormal];
		}
	}
	else if(collectionedit == EnCollectionEditStart) // 选择结算 时间
	{
		UIButton *button = (UIButton *)[productcell viewWithTag:EnCollectionSelectItemBtTag];
		int flag = 0;
		for(int i=0;i<[arrarselectsettlementitem count];i++)
		{
			NSDictionary *dicselect = [arrarselectsettlementitem objectAtIndex:i];
			if([[dicselect objectForKey:@"orderdetailid"] isEqualToString:[dictemp objectForKey:@"orderdetailid"]])
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
	
}

#pragma mark 接口
-(void)requestmyshoppingcar:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001012000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 if([[dic objectForKey:@"data"] objectForKey:@"commoditylist"]==[NSNull null])
			 {
				 arraydata = [[NSMutableArray alloc] init];
			 }
			 else
			 {
				 arraydata = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"commoditylist"]];
			 }
			 for(int i=0;i<[arraydata count];i++)
			 {
				 int flag = 0;
				 NSDictionary *diccommodity = [arraydata objectAtIndex:i];
				 for(int j=0;j<[arrayshopcarnumber count];j++)
				 {
					 NSDictionary *dicnumber = [arrayshopcarnumber objectAtIndex:j];
					 if([[dicnumber objectForKey:@"orderdetailid"] isEqualToString:[diccommodity objectForKey:@"orderdetailid"]])
					 {
						 flag =1;
						 break;
					 }
				 }
				 if(flag == 0)
				 {
					 NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];//
					 [dictemp setObject:[diccommodity objectForKey:@"orderdetailid"] forKey:@"orderdetailid"];
					  [dictemp setObject:[diccommodity objectForKey:@"ordernumber"] forKey:@"ordernumber"];
					 [arrayshopcarnumber addObject:dictemp];
				 }
			 }
			 
			 UILabel *labelprice = [self.view viewWithTag:EnShoppingCarAllPriceLabelTag];
			 labelprice.text = [NSString stringWithFormat:@"合计:￥%@",@"0"];
			 [tableview setDelegate:self];
			 tableview.dataSource = self;
			 [tableview reloadData];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}



-(void)removemyshopcar:(NSString *)orderids
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:orderids forKey:@"orderdetailids"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001013000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 for(int i=0;i<[arrarselectremoveitem count];i++)
			 {
				 NSDictionary *dic = [arrarselectremoveitem objectAtIndex:i];
				 for(int j=0;j<[arrayshopcarnumber count];j++)
				 {
					 NSDictionary *dicnu = [arrayshopcarnumber objectAtIndex:j];
					 if([[dicnu objectForKey:@"orderdetailid"] isEqualToString:[dic objectForKey:@"orderdetailid"]])
					 {
						 [arrayshopcarnumber removeObject:dicnu];
						 break;
					 }
				 }
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
