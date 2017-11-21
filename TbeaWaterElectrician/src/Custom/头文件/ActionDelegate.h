//
//  ActionDelegate.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-6-18.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//
//所有的代理以DG开头
#import <Foundation/Foundation.h>

@protocol ActionDelegate<NSObject>
@optional

-(void)DGGotoEvaluationListView:(NSDictionary *)sender;//去评价列表
-(void)DGgotoEvaluationView:(NSDictionary *)sender;//去评价
-(void)gototakevideo:(id)sender;  //录制小视频
-(void)loginsuccess:(id)sender; //登录成功

-(void)DGAlertSendGoods:(NSDictionary *)sender; //提醒发货

-(void)DeClictAddGWC:(NSString *)sender;  //点击添加商品的时候确认按钮

-(void)DGClickSearchCityTextField:(NSString *)sender;//城市搜索输入框

-(void)DGClickSearchOneLevelTextField:(NSString *)sender;//一级页面搜索输入框

-(void)DGClickSearchResultTextField:(NSString *)sender;//一级页面搜索点击 进入搜索页面后的搜索框

-(void)DGSelectCollectionItem:(NSDictionary *)selectitem SBt:(UIButton *)sbt;   //选择

-(void)DGModifyPersonInfo:(NSString *)str;  //更新个人信息

-(void)DGAddOrderInfo:(NSString *)colorid Specifi:(NSString *)specifid Number:(NSString *)number;  //加入购物车的时候

-(void)DGGoToJieSuanGoods:(NSString *)colorid Specifi:(NSString *)specifid Number:(NSString *)number;  //下单的时候

-(void)DGClickJXSAddrGotoMap:(id)sender;   //点击经销商地址去地图



-(void)DGClickGoodsNextBt:(int)sender;//点击商品底部的几个按钮

-(void)DGClickAddNumberBtTag:(NSDictionary *)sender NowNumber:(NSString *)number;//点击购物车里面的添加数量

-(void)DGClickReduceNumberBtTag:(NSDictionary *)sender NowNumber:(NSString *)number;//点击购物车里面的减少数量

-(void)DGSelectOneAddr:(NSDictionary *)sid;    //下单的时候选择地址

-(void)DGGetUserLocatioObject:(id)sender;  //获取地址位置

-(void)ReceiveAddrselectAddr:(NSDictionary *)dicaddr;

-(void)DGSelectCityDone:(NSDictionary *)diccity;

-(void)DGSelectCommdityAddr:(NSDictionary *)sid;    //商品网页选择地址过来的

-(void)DGClickSearchType:(id)sender;//搜索类型


@end
