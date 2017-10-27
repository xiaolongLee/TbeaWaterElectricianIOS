//
//  ScanOrginDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanOrginDetailViewController.h"

@interface ScanOrginDetailViewController ()

@end

@implementation ScanOrginDetailViewController

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
	[self.navigationController setNavigationBarHidden:YES];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	
	//扫码记录
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, 32, 90, 20)];
	labeltitle.text = @"溯源详情";
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
	
	NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",app.dili.diliprovince,app.dili.dilicity,app.dili.dililocality,app.dili.diliroad,app.dili.dilinumber];
	[self getproductorgin:self.scancode Address:address];
	
	
}

-(UIView *)viewproduct:(NSDictionary *)sender Frame:(CGRect)frame
{
	UIView *productview = [[UIView alloc] initWithFrame:frame];
	productview.backgroundColor = [UIColor whiteColor];
	productview.layer.cornerRadius = 3.0f;
	productview.clipsToBounds = YES;
	
	
	for(int i=0;i<4;i++)
	{
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40*i, frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(230, 230, 230);
		[productview addSubview:imageviewline];
		
		if(i==0)
		{
			UILabel *labelproduct = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 20)];
			labelproduct.font = FONTN(15.0f);
			labelproduct.text = @"产品信息";
			labelproduct.textColor = COLORNOW(0, 51, 153);
			[productview addSubview:labelproduct];
		}
		else if(i==1)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 70, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"产品名称:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, 100, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text = [sender objectForKey:@"name"];
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,labelname.frame.origin.y, 70, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"型号规格:";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
			
			UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelguige.frame.origin.x+labelguige.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelguigevalue.font = FONTN(13.0f);
			labelguigevalue.numberOfLines = 2;
			labelguigevalue.lineBreakMode = NSLineBreakByCharWrapping;
			labelguigevalue.text = [sender objectForKey:@"specifications"];
			labelguigevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelguigevalue];
		}
		else if(i==2)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 70, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"生产日期:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text = [sender objectForKey:@"deliverdate"];
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,labelname.frame.origin.y, 70, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"发货日期:";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
			
			UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelguige.frame.origin.x+labelguige.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelguigevalue.font = FONTN(13.0f);
			labelguigevalue.numberOfLines = 2;
			labelguigevalue.text = [sender objectForKey:@"manudate"];
			labelguigevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelguigevalue];
		}
		else if(i==3)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 70, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"发往客户:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH-80, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.text = [sender objectForKey:@"manufacture"];;
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
		}
	}
	
	return productview;
}


-(UIView *)viewparame:(NSArray *)sender Frame:(CGRect)frame
{
	UIView *productview = [[UIView alloc] initWithFrame:frame];
	productview.backgroundColor = [UIColor whiteColor];
	productview.layer.cornerRadius = 3.0f;
	productview.clipsToBounds = YES;
	
	
	for(int i=0;i<5;i++)
	{
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40*i, frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(230, 230, 230);
		[productview addSubview:imageviewline];
		
		if(i==0)
		{
			UILabel *labelproduct = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 20)];
			labelproduct.font = FONTN(15.0f);
			labelproduct.text = @"工艺参数";
			labelproduct.textColor = COLORNOW(0, 51, 153);
			[productview addSubview:labelproduct];
			
			
		}
		else if(i==1)
		{
			
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 60, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"工序:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, 100, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text =@"班组";
			labelnamevalue.textColor = COLORNOW(153,153,153);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,labelname.frame.origin.y, 65, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"日期";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
		}
		else if(i==2)
		{
			if([sender count]>0)
			{
				NSDictionary *dictemp = [sender objectAtIndex:0];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"processname"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"processdate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		else if(i==3)
		{
			if([sender count]>1)
			{
				NSDictionary *dictemp = [sender objectAtIndex:1];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"processname"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"processdate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		else if(i==4)
		{
			if([sender count]>2)
			{
				NSDictionary *dictemp = [sender objectAtIndex:2];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"processname"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"processdate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		
	}
	
	return productview;
}

-(void)initview:(id)sender
{
	
	NSDictionary *productinfo  = [sender objectForKey:@"productinfo"];
	NSArray *Manufac = [sender objectForKey:@"manufactureprocess"];
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
	scrollview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scrollview];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	imageview.tag = 1500;
	imageview.contentMode = UIViewContentModeScaleAspectFill;
	imageview.clipsToBounds = YES;
	[scrollview addSubview:imageview];
	
	view1 = [self viewproduct:productinfo Frame:CGRectMake(5, 5, SCREEN_WIDTH-10, 160)];
	[scrollview addSubview:view1];
	
	view2 = [self viewparame:Manufac Frame:CGRectMake(5, view1.frame.origin.y+view1.frame.size.height, SCREEN_WIDTH-10, 200)];
	[scrollview addSubview:view2];
	

}

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 接口
-(void)getproductorgin:(NSString *)scancode Address:(NSString *)address
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:scancode forKey:@"scancode"];
	[params setObject:address forKey:@"address"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG006001001000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 dicdata = [dic objectForKey:@"data"];
			 [self initview:dicdata];
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
