//
//  AuthEndViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy on 2017/12/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AuthEndViewController.h"

@interface AuthEndViewController ()

@end

@implementation AuthEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIImage* img=LOADIMAGE(@"regiest_back", @"png");
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:img forState:UIControlStateNormal];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"重新认证" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTMEDIUM(14.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [buttonright addTarget:self action: @selector(clickauthagain:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    [self initview];
    
    [self getcertificationinfo];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.delegate = self;
    tableview.dataSource = self;
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickauthagain:(id)sender
{
    CertificationViewController *certification = [[CertificationViewController alloc] init];
    certification.fromflag = @"3";
    [self.navigationController pushViewController:certification animated:YES];
}

#pragma mark ActionDelegate


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
        return 40;
    }
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.001;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return nil;
    else
    {
        UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        viewheader.backgroundColor = COLORNOW(235, 235, 235);
        return viewheader;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 90, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(14.0f);
    [cell.contentView addSubview:labelname];
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-115, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(14.0f);
    labelvalue.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:labelvalue];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 10, 100, 60)];
    
    switch (indexPath.section)
    {
        case 0:
            switch (indexPath.row)
            {
                case 0:
                    labelname.text = @"真实姓名";
                    labelvalue.text = [FCcompanyidentifyinfo objectForKey:@"realname"];
                    break;
                case 1:
                    labelname.text = @"身份证号";
                    labelvalue.text = [FCcompanyidentifyinfo objectForKey:@"personcardid"];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                    labelname.frame = CGRectMake(20, 30, 90, 20);
                    labelname.text = @"身份证正面";
                    
                    [imageview setImageWithURL:[NSURL URLWithString:[FCcompanyidentifyinfo objectForKey:@"personidcard1"]] placeholderImage:nil];
                    [cell.contentView addSubview:imageview];
                    break;
                case 1:
                    labelname.frame = CGRectMake(20, 30, 90, 20);
                    labelname.text = @"身份证反面";
                    [imageview setImageWithURL:[NSURL URLWithString:[FCcompanyidentifyinfo objectForKey:@"personidcard2"]] placeholderImage:nil];
                    [cell.contentView addSubview:imageview];
                    break;
                case 2:
                    labelname.frame = CGRectMake(20, 30, 90, 20);
                    labelname.text = @"持证照";
                    [imageview setImageWithURL:[NSURL URLWithString:[FCcompanyidentifyinfo objectForKey:@"personidcardwithperson"]] placeholderImage:nil];
                    [cell.contentView addSubview:imageview];
                    break;
            }
            break;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
-(void)getcertificationinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001002004" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
      Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             FCcompanyidentifyinfo = [[dic objectForKey:@"data"] objectForKey:@"useridentifyinfo"];
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
