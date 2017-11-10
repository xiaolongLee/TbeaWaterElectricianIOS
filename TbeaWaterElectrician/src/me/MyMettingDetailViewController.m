//
//  MyMettingDetailViewController.m
//  TbeaWaterElectrician
//
//  Created by 谢毅 on 2017/11/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyMettingDetailViewController.h"

@interface MyMettingDetailViewController ()

@end

@implementation MyMettingDetailViewController

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
    self.title = @"会议详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self getmettingdetail];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:ColorBlue];
}

-(UIView *)viewcelljuban:(NSDictionary *)dicfrom FromFrame:(CGRect)fromframe
{
    UIView *view = [[UIView alloc] initWithFrame:fromframe];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"masterthumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"masterthumbpicture"] length]>0?[dicfrom objectForKey:@"masterthumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [view addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"mastername"] Fwidth:200 Fheight:20 Sfont:FONTB(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(16.0f);
    labelusername.text = [dicfrom objectForKey:@"mastername"];
    [view addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    NSString *strpic1 = [dicfrom objectForKey:@"companytypeicon"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"companytypeicon"] length]>0?[dicfrom objectForKey:@"companytypeicon"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [view addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername), SCREEN_WIDTH-100, 18)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"name"];
    [view addSubview:straddr];
    
    return view;
    
}

#pragma mark IBaction
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row ==2)
        {
            return [FCarrayjibandanwei count]==0?50:[FCarrayjibandanwei count]*50;;
        }
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 4;
    else if(section == 1)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    viewheader.backgroundColor = COLORNOW(235, 235, 235);
    
    return viewheader;
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
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-100, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"会议编号";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingcode"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                labelname.text = @"举办时间";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text =  [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingtime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"举办单位";
                [cell.contentView addSubview:labelname];
                
                for(int i=0;i<[FCarrayjibandanwei count];i++)
                {
                    [cell.contentView addSubview:[self viewcelljuban:[FCarrayjibandanwei objectAtIndex:i] FromFrame:CGRectMake(100, 50*i, SCREEN_WIDTH-130, 50)]];
                }
                //     [self viewcell1:[FCdicdata objectForKey:@"organizecompanylist"] FromCell:cell LabelName:@"举办单位"];
                break;
            case 3:
                labelname.text = @"举办地点";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingplace"];
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"签到时间";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCcheckininfo objectForKey:@"checkintime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                labelname.text = @"签到地点";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCcheckininfo objectForKey:@"checkinplace"];
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
-(void)getmettingdetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_FCmettingid forKey:@"meetingid"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG00500201002" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
      Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             FCarrayjibandanwei = [[dic objectForKey:@"data"] objectForKey:@"organizecompanylist"];
             FCmeetingbaseinfo = [[FCdicdata objectForKey:@"meetinginfo"] objectForKey:@"meetingbaseinfo"];
             FCcheckininfo = [[FCdicdata objectForKey:@"participantlist"] objectForKey:@"checkininfo"];
             FCdicdata = [dic objectForKey:@"data"];
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
