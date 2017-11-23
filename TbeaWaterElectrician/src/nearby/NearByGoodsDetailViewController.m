//
//  NearByGoodsDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "NearByGoodsDetailViewController.h"

@interface NearByGoodsDetailViewController ()

@end

@implementation NearByGoodsDetailViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self getgouwuchenumber:self.strproductid];
    
//	[[self.navigationController.navigationBar viewWithTag:EnNearBySeViewTag] setAlpha:1];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self initview];
	
	[self.navigationController setNavigationBarHidden:NO];
	
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
	[buttonright setImage:LOADIMAGE(@"分享", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[buttonright addTarget:self action: @selector(clickshare:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

-(void)clickshare:(id)sender
{
	[self getshareinfo:self.strproductid ObjectType:@"commodity"];
}

-(void)gotoshare:(NSDictionary *)sender
{
	DLog(@"sender====%@",sender);
	[UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
	 
		UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
		//创建网页内容对象
		UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[sender objectForKey:@"title"] descr:[sender objectForKey:@"description"] thumImage:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[sender objectForKey:@"picture"]]]]];
		//设置网页地址
		shareObject.webpageUrl =[sender objectForKey:@"url"];
	 
		//分享消息对象设置分享内容对象
		messageObject.shareObject = shareObject;
	 
	 // 根据获取的platformType确定所选平台进行下一步操作
	 if(platformType==UMSocialPlatformType_Sina)
	 {
		 
		 
		//调用分享接口
		[[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
			if (error) {
				NSLog(@"************Share fail with error %@*********",error);
			}else{
				NSLog(@"response data is %@",data);
			}
		}];
	 }
	 else if(platformType==UMSocialPlatformType_WechatSession)
	 {
		 //调用分享接口
		 [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
			 if (error) {
				 UMSocialLogInfo(@"************Share fail with error %@*********",error);
			 }else{
				 if ([data isKindOfClass:[UMSocialShareResponse class]]) {
					 UMSocialShareResponse *resp = data;
					 //分享结果消息
					 UMSocialLogInfo(@"response message is %@",resp.message);
					 //第三方原始返回的数据
					 UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
					 
				 }else{
					 UMSocialLogInfo(@"response data is %@",data);
				 }
			 }
		 }];
	 }
	 else if(platformType==UMSocialPlatformType_WechatTimeLine)
	 {
		 //调用分享接口
		 [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
			 if (error) {
				 NSLog(@"************Share fail with error %@*********",error);
			 }else{
				 NSLog(@"response data is %@",data);
			 }
		 }];
	 }
 }];
	
}

-(void)initview
{
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayheight = [[NSMutableArray alloc] init];
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
	[self addwebview];
	selectitem = EnGoods;
	
	NSMutableArray *titleSourcd = [NSMutableArray arrayWithObjects:@"商品", @"详情", @"评价", nil];
	HYSegmentControl *segmentControl = [HYSegmentControl segmentColor:CGRectMake(80, 4, SCREEN_WIDTH-160, 40) titleSource:titleSourcd titleColor:Colorgray selectTitleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:15] selectTiteFont:[UIFont systemFontOfSize:15] backgroundColor:[UIColor clearColor] bottomLingColor:[UIColor whiteColor]];
	
	
	segmentControl.tag = EnNearBySeViewTag;
	segmentControl.finished = ^(UIButton *btn) {
		NSLog(@"btn = %@", btn.currentTitle);
		if([btn.currentTitle isEqualToString:@"商品"])
		{
			[tableview removeFromSuperview];
			if((selectitem==EnGoods)||(selectitem==EnDetail))
			{
				

			}
			else
			{
				
				[self addwebview];
			}
			selectitem = EnGoods;
			NSString *str = [NSString stringWithFormat:@"%@/%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpProductDetail];
       //     @"http://www.u-shang.net/enginterface/index.php/Apph5/commoditysaleinfo?commodityid=";
			str = [NSString stringWithFormat:@"%@%@&userid=%@&longitude=%@&latitude=%@",str,self.strproductid,app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
			
			NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
			[webview loadRequest:request];
			
		}
		else if([btn.currentTitle isEqualToString:@"详情"])
		{
			[tableview removeFromSuperview];
			if((selectitem==EnGoods)||(selectitem==EnDetail))
			{
				
				
			}
			else
			{
				
				[self addwebview];
			}
			selectitem = EnDetail;
			NSString *str = [NSString stringWithFormat:@"%@/%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpProductDetail1];
            
     //       @"http://www.u-shang.net/enginterface/index.php/Apph5/commoditydetail?commodityid=";
			str = [NSString stringWithFormat:@"%@%@",str,self.strproductid];
			NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
			[webview loadRequest:request];
		}
		else
		{
			[webview removeFromSuperview];
			if(selectitem==EnPingjia)
			{
				
				
			}
			else
			{
				tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-47) style:UITableViewStylePlain];
				tableview.backgroundColor = [UIColor clearColor];
				[self.view addSubview:tableview];
			}
			selectitem = EnPingjia;
			
			
			[self setExtraCellLineHidden:tableview];
			[self getpingjianllist:self.strproductid Page:@"1" Pagesize:@"10"];
		}
	};

	[self.navigationController.navigationBar addSubview:segmentControl];

	
	goodview = [[GoodsDetailBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBarHeight-44-50-IPhone_SafeBottomMargin, SCREEN_WIDTH, 50)];


	goodview.delegate1 = self;
	[self.view addSubview:goodview];

	
}

-(void)addwebview
{
	webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];

	webview.delegate = self;
	webview.backgroundColor = [UIColor clearColor];
//	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/commoditysaleinfo?commodityid=";
//	str = [NSString stringWithFormat:@"%@%@",str,self.strproductid];
	
	NSString *str = [NSString stringWithFormat:@"%@/%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpProductDetail];
//    @"http://www.u-shang.net/enginterface/index.php/Apph5/commoditysaleinfo?commodityid=";
	str = [NSString stringWithFormat:@"%@%@&userid=%@&longitude=%@&latitude=%@",str,self.strproductid,app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
    DLog(@"strurl=====%@",str);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
	[webview loadRequest:request];
	
	for (UIView *_aView in [webview subviews])
	{
		if ([_aView isKindOfClass:[UIScrollView class]])
		{
			[(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
			
			for (UIView *_inScrollview in _aView.subviews)
			{
				
				if ([_inScrollview isKindOfClass:[UIImageView class]])
				{
					_inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
				}
			}
		}
	}
	
	[self.view addSubview:webview];
}

-(void)addloginview
{
	LoginViewController *loginview = [[LoginViewController alloc] init];
	loginview.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:loginview];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
	
}

#pragma mark ActionDelegate


-(void)DGSelectCommdityAddr:(NSDictionary *)sid
{
//	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/commoditysaleinfo?commodityid=";
//	str = [NSString stringWithFormat:@"%@%@&recvaddressid=%@",str,self.strproductid,[sid objectForKey:@"id"]];

	if(![AddInterface judgeislogin])
	{
		[self addloginview];
	}
	else
	{
        FCrecvaddressid = [sid objectForKey:@"id"];
		NSString *str = [NSString stringWithFormat:@"%@/%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpProductDetail];
        //@"http://www.u-shang.net/enginterface/index.php/Apph5/commoditysaleinfo?commodityid=";
		str = [NSString stringWithFormat:@"%@%@&recvaddressid=%@&userid=%@&longitude=%@&latitude=%@",str,self.strproductid,FCrecvaddressid,app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
		[webview loadRequest:request];
	}
}

-(void)DGGoToJieSuanGoods:(NSString *)colorid Specifi:(NSString *)specifid Number:(NSString *)number Modelid:(NSString *)modelid
{
	if(![AddInterface judgeislogin])
	{
		[self addloginview];
	}
	else
	{
        [self addgoumaiorder:self.strproductid Distributorid:self.strdistrid Specifid:specifid Colorid:colorid Number:number Modelid:modelid];
	}
}

-(void)DGClickSelectModelSpecifi:(NSString *)colorid Specifi:(NSString *)specifid Number:(NSString *)number Modelid:(NSString *)modelid
{
    if(![AddInterface judgeislogin])
    {
        [self addloginview];
    }
    else
    {
        FCcolorid = colorid;
        FCmodelid = modelid;
        FCspecifiid = specifid;
        NSString *str = [NSString stringWithFormat:@"%@/%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpProductDetail];
        str = [NSString stringWithFormat:@"%@%@&recvaddressid=%@&userid=%@&longitude=%@&latitude=%@&colorid=%@&commodityspecid=%@&commoditymodelid=%@",str,self.strproductid,FCrecvaddressid,app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude],FCcolorid,FCspecifiid,FCmodelid];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        [webview loadRequest:request];
    }
}


-(void)DGAddOrderInfo:(NSString *)colorid Specifi:(NSString *)specifid Number:(NSString *)number Modelid:(NSString *)modelid
{
	if(![AddInterface judgeislogin])
	{
		[self addloginview];
	}
	else
	{
		[self requestaddorder:self.strproductid Distributorid:self.strdistrid Specifid:specifid Colorid:colorid Number:number Modelid:modelid];
	}
}

-(void)DeClictAddGWC:(NSString *)sender
{
	if(![AddInterface judgeislogin])
	{
		[self addloginview];
	}
	else
	{
		[self getgoodsInfo:self.strproductid FromFlag:sender];
	}
}

-(void)DGClickGoodsNextBt:(int)sender
{
	MyShoppingCarViewController *shoppingcar;
	switch (sender)
	{
		case EnGetGoodsThreeBtTag1: //店铺
			if([self.strdistributype isEqualToString:@"notdistributor"]) //不跳转
			{
			}
			else if([self.strdistributype isEqualToString:@"firstleveldistributor"])
			{
				NearByJXSDetailViewController *jxsdetail = [[NearByJXSDetailViewController alloc] init];
				jxsdetail.dicjsxfrom = nil;
				jxsdetail.strdistribuid = self.strdistrid;
				[self.navigationController pushViewController:jxsdetail animated:YES];
			}
			else if([self.strdistributype isEqualToString:@"distributor"])
			{
				WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
				webviewcontent.strtitle = @"经销商";//[dictemp objectForKey:@"tasktitle"];
				NSString *str = [NSString stringWithFormat:@"%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpDistribute];
				str = [NSString stringWithFormat:@"%@%@&userid=%@&longitude=%@&latitude=%@",str,self.strdistrid,app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
				webviewcontent.strnewsurl = str;
				[self.navigationController pushViewController:webviewcontent animated:YES];
			}
			break;
		case EnGetGoodsThreeBtTag2: //收藏
			if(![AddInterface judgeislogin])
			{
				[self addloginview];
			}
			else
			{
				[self getcolectiongoods:self.strproductid];
			}
			break;
		case EnGetGoodsThreeBtTag3:  //购物车
			if(![AddInterface judgeislogin])
			{
				[self addloginview];
			}
			else
			{
				shoppingcar = [[MyShoppingCarViewController alloc] init];
				[self.navigationController pushViewController:shoppingcar animated:YES];
			}
			break;

	}
}

#pragma mark webviewdelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSString *requestString = [[request URL] absoluteString];
	if([requestString rangeOfString:@"selectspecification.com"].location != NSNotFound)
	{
		//[goodview clickaddgwc:nil];
        [self DeClictAddGWC:@"3"]; //表示点击的页面的型号规格选择
		return NO;
	}
	else if([requestString rangeOfString:@"selectaddr.com"].location != NSNotFound)
	{
		if(![AddInterface judgeislogin])
		{
			[self addloginview];
		}
		else
		{
			ReceiveAddrViewController *addaddr = [[ReceiveAddrViewController alloc] init];
			addaddr.fromaddr = @"3";
			addaddr.delegate1 = self;
			[self.navigationController pushViewController:addaddr animated:YES];
		}
		return NO;
	}
	return YES;
	
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
//	[webview loadRequest:NULL];
//	[webview removeFromSuperview];
//	webview = nil;
//	webview.delegate = nil;
//	[webview stopLoading];
}

#pragma mark tableviewdelegate
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
	return [[arrayheight objectAtIndex:indexPath.row] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arrayheight count];
	
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
	GoodsPingJiaCellView *view = [[GoodsPingJiaCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[arrayheight objectAtIndex:indexPath.row] floatValue]) DicFrom:dictemp];
	[cell.contentView addSubview:view];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}




#pragma mark 接口
-(void)getpingjianllist:(NSString *)scommoid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scommoid forKey:@"commodityid"];
	[params setObject:page forKey:@"page"];
	[params setObject:pagesize forKey:@"pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001009004" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"appraiselist"];
			 [arrayheight removeAllObjects];
			 for(int i=0;i<[arraydata count];i++)
			 {
				 NSDictionary *dictemp = [arraydata objectAtIndex:i];
				 CGSize size = [AddInterface getlablesize:[dictemp objectForKey:@"appraise"] Fwidth:SCREEN_WIDTH-20 Fheight:300 Sfont:FONTN(14.0f)];
				 [arrayheight addObject:[NSString stringWithFormat:@"%f",size.height+60]];
			 }
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

-(void)getgoodsInfo:(NSString *)commodityid FromFlag:(NSString *)fromflag
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:commodityid forKey:@"commodityid"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001009003" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicgoodsinfo = [[dic objectForKey:@"data"] objectForKey:@"commodityinfo"];
			 SelectSpecificationView *specifi = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-IPhone_SafeBottomMargin-StatusBarHeight-44) DicData:[dic objectForKey:@"data"]];
			 specifi.delegate1 = self;
			 specifi.fromflag = fromflag;
			 [self.view addSubview:specifi];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}

-(void)getcolectiongoods:(NSString *)commodityid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:commodityid forKey:@"commodityid"];
	[params setObject:self.strdistrid forKey:@"distributorid"];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001011000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			[goodview setproductcollection:@"1"];
			 [self getgouwuchenumber:self.strproductid];
			[MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}

//获取购物车数量
-(void)getgouwuchenumber:(NSString *)commodityid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:commodityid forKey:@"commodityid"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001012001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [goodview addgouwuchenumber:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"commoditynumber"]]];
			 [goodview setproductcollection:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"commoditysavestatus"]]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}




-(void)requestaddorder:(NSString *)commodityid Distributorid:(NSString *)distributorid Specifid:(NSString *)specificationid Colorid:(NSString *)colorid Number:(NSString *)number Modelid:(NSString *)modelid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:distributorid forKey:@"distributorid"];
	[params setObject:commodityid forKey:@"commodityid"];
	[params setObject:specificationid forKey:@"specificationid"];
	[params setObject:colorid forKey:@"colorid"];
	[params setObject:number forKey:@"number"];
    [params setObject:modelid forKey:@"commoditymodelid"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001010000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [self getgouwuchenumber:self.strproductid];
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}


-(void)addgoumaiorder:(NSString *)commodityid Distributorid:(NSString *)distributorid Specifid:(NSString *)specificationid Colorid:(NSString *)colorid Number:(NSString *)number Modelid:(NSString *)modelid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:distributorid forKey:@"distributorid"];
	[params setObject:commodityid forKey:@"commodityid"];
	[params setObject:specificationid forKey:@"specificationid"];
	[params setObject:colorid forKey:@"colorid"];
	[params setObject:number forKey:@"number"];
	[params setObject:modelid forKey:@"commoditymodelid"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG003001011000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dicorderinfo = [[dic objectForKey:@"data"] objectForKey:@"orderdetailinfo"];
			 NSMutableArray *arrayparame = [[NSMutableArray alloc] init];
			 NSMutableArray *arrayparamepic = [[NSMutableArray alloc] init];
			 
			 
			 NSDictionary *dicpara = [NSDictionary dictionaryWithObjectsAndKeys:[dicorderinfo objectForKey:@"orderdetailid"],@"orderdetailid",number,@"ordernumber", nil];
			 [arrayparame addObject:dicpara];
			 
			 NSDictionary *dicpara1 = [NSDictionary dictionaryWithObjectsAndKeys:[dicorderinfo objectForKey:@"orderdetailid"],@"orderdetailid",[dicgoodsinfo objectForKey:@"picture"],@"commoditypicture", nil];
			 [arrayparamepic addObject:dicpara1];
			 
			 MyInputOrderViewController *inputorder = [[MyInputOrderViewController alloc] init];
			 inputorder.arraycommonditynumber = arrayparame;
			 inputorder.arraycommonditypic = arrayparamepic;
			 [self.navigationController pushViewController:inputorder animated:YES];
			 
//			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }];
	
}


-(void)getshareinfo:(NSString *)objectid ObjectType:(NSString *)objecttype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:objectid forKey:@"objectid"];
	[params setObject:objecttype forKey:@"objecttype"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002002001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [self gotoshare:[[dic objectForKey:@"data"] objectForKey:@"shareinfo"]];
			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
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
