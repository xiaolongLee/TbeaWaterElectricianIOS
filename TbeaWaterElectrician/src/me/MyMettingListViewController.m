//
//  MyMettingListViewController.m
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyMettingListViewController.h"

@interface MyMettingListViewController ()

@end

@implementation MyMettingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initview];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"我的会议";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCorderitem = @"";
    FCorderid = @"desc";
    FCordercode = @"";
    FCorderdate = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getmymettinglist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getmymettinglist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    [self addtabviewheader];
    [self getmymettinglist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
    tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    tabviewheader.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabviewheader];
    sortitem = [self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [tabviewheader addSubview:sortitem];
}

//表头
-(UIView *)viewselectitem:(CGRect)frame
{
    UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
    viewselectitem.backgroundColor = [UIColor whiteColor];
    //两根灰线
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
    line1.backgroundColor = COLORNOW(220, 220, 220);
    [viewselectitem addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.3, SCREEN_WIDTH, 0.7)];
    line2.backgroundColor = COLORNOW(220, 220, 220);
    [viewselectitem addSubview:line2];
    
    float widthnow = (SCREEN_WIDTH-20)/5;
    
    //预约编号
    ButtonItemLayoutView *buttonitemcode = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow*2, 40)];
    [buttonitemcode.button addTarget:self action:@selector(ClickSelectcode:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemcode.tag = EnMettingListSelectItembt1;
    [buttonitemcode updatebuttonitem:EnButtonTextLeft TextStr:@"会议编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemcode];
    
    //状态
    ButtonItemLayoutView *buttonitemstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
//    [buttonitemstatus.button addTarget:self action:@selector(ClickSelectstatus:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemstatus.tag = EnMettingListSelectItembt2;
    [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"参会地点" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:nil];
    [viewselectitem addSubview:buttonitemstatus];
    
    //日期
    ButtonItemLayoutView *buttonitemdate = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, XYViewBottom(line1), widthnow*2, 40)];
    [buttonitemdate.button addTarget:self action:@selector(ClickSelectdate:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemdate.tag = EnMettingListSelectItembt3;
    [buttonitemdate updatebuttonitem:EnButtonTextRight TextStr:@"参加时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemdate];
    
    return viewselectitem;
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:ColorBlue];
}

#pragma mark ActionDelegate



#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectcode:(id)sender
{
    FCorderitem = @"meetingcode";
    FCorderdate = @"";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMettingListSelectItembt1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMettingListSelectItembt2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMettingListSelectItembt3];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    if([FCordercode isEqualToString:@""])
    {
        FCordercode = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordercode isEqualToString:@"desc"])
    {
        FCordercode = @"asc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCordercode isEqualToString:@"asc"])
    {
        FCordercode= @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCordercode;
    [self getmymettinglist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectdate:(id)sender
{
    FCorderitem = @"time";
    FCordercode = @"";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMettingListSelectItembt3];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMettingListSelectItembt2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMettingListSelectItembt1];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    if([FCorderdate isEqualToString:@""])
    {
        FCorderdate = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderdate isEqualToString:@"desc"])
    {
        FCorderdate = @"asc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderdate isEqualToString:@"asc"])
    {
        FCorderdate= @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCorderdate;
    [self getmymettinglist:@"1" Pagesize:@"10"];
    
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [FCarraydata count];
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
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
    float widthnow = (SCREEN_WIDTH-20)/5;
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, widthnow*2, 20)];
    labeltime.text = [dictemp objectForKey:@"meetingcode"];;
    labeltime.textColor = [UIColor blackColor];
    labeltime.font = FONTN(15.0f);
    labeltime.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:labeltime];
    
    UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*2, 10, widthnow,20)];
    lablearea.text = [dictemp objectForKey:@"zone"];
    lablearea.font = FONTN(15.0f);
    lablearea.textColor = [UIColor blackColor];
    lablearea.backgroundColor = [UIColor clearColor];
    lablearea.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lablearea];
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-widthnow*2, 10,widthnow*2, 20)];
    lablemoneyvalue.text =[dictemp objectForKey:@"checkintime"];
    lablemoneyvalue.font = FONTN(15.0f);
    lablemoneyvalue.textColor = [UIColor blackColor];
    lablemoneyvalue.textAlignment = NSTextAlignmentRight;
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:lablemoneyvalue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    MyMettingDetailViewController *mettingdetail = [[MyMettingDetailViewController alloc] init];
    mettingdetail.FCmettingid = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:mettingdetail animated:YES];
}


#pragma mark 接口

-(void)getmymettinglist:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:FCorderitem forKey:@"orderitem"];
    [params setObject:FCorderid forKey:@"order"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG00500201001" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
    Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"meetinglist"];
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
