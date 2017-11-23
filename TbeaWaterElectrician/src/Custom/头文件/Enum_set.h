//
//  Enum_set.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#ifndef Enum_set_h
#define Enum_set_h

typedef enum {
	//以下是枚举成员 TestA = 0,
	NewsNomalList,  // 首页新闻列表
	Person,   //我的收藏
	MyAddActivity,  //我的参与
	OtherNewsList,  //其它新闻列表
	NewsOtherList,   //其它应用
	ApplicationManger
}NewsType;


typedef enum{
	//各个tag表示的意思
	EnLoginViewTag=100,   //登录页面
	EnRegiestViewTag,  //注册页面
	EnRegiestNumber2, //注册切换tab的时候右边的数字
	EnRegiestLable2,		//注册切换tab的时候右边的实名认证汉字
	EnRegiestLine1,    //注册的时候切换tab 蓝色的线
	EnRegiestLeftView,  //注册左边的view
	EnRegiestRightView,   //注册右边的view
	EnRegiestTopView,      //注册上边的topview
	EnViewLookImage,     //示例view
	EnHpSMPageControl,     //首页SMpagetag
	EnNearImageDirect      //附近 商家 类型的标志
}TagMean;


typedef enum{
	EnNearByJXS=1,   //登录页面
	EnNearBySJ,  //注册页面
	EnNearByCG //注册切换tab的时候右边的数字
}NearByTag;

typedef enum   //所有单独是否选中项
{
	EnNotSelect,  //未选择
	EnSelectd   //已选择
	
}EnIsSelect;

typedef enum   //所有单独是否选中项
{
	EnGoods,  //选择商品
	EnDetail,   //选择详情
	EnPingjia   //选择评价
	
}EnGoodsItme;

typedef enum     //附近经销商选择项
{
	EnAllProduct,  //全部商品
	EnProjectTender, //工程招标
	EnTakeJob,     //招聘信息
	EnCompanyMSg    //公司动态
}EnNearByJXSItem;

typedef enum      //经销商有哪几种排序
{
	EnJSXOrderAuto,
	EnJSXOrderSaleCount,
	EnJSXOrderPrice
}EnJSXOrderItem;

typedef enum      //经销商排序方式
{
	EnJSXOrderDesc,
	EnJSXOrderAsc
}EnJSXOrder;

typedef enum     //附近经销商选择项
{
	EnSortTuiJian,  //全部商品
	EnSortXiaoLiang, //工程招标
	EnSortPrice     //招聘信息
}EnNearByJXSSort;

typedef enum
{
    EnButtonTextLeft,   //左对齐
    EnButtonTextCenter, //中间对齐
    EnButtonTextRight   //右对齐
}EnButtonTextAlignment;

typedef enum     //扫码是选择的溯源还是返利
{
	EnToOrgin,  //溯源
	EnToRebate //返利
}EnScanCodeType;

typedef enum     //我的钱包选择的是收还是支出
{
	EnMeIncome,  //收入
	EnMePay //支出
}EnMeIncomePay;

typedef enum
{
	EnSearchGoods=1,  //搜索商品
	EnSearchShop,//搜索店铺
    EnSearchdistru//搜索店铺
}EnSearchType;

typedef enum
{
	EnCollectionEditStart=1,  //我的收藏编辑开始
	EnCollectionEditDone//我的收藏编辑完成
}EnCollectionEdit;

#endif /* Enum_set_h */


#define EnHpAdPicImageview  99000   //首页scrollview滚动图片
#define EnNearShopTypeBt    98000        //附近经销商  商家  采购
#define EnNearSearchViewBt 97000        //searchview tag
#define EnNearJXSDetailItemBt  96000    //经销商详细选项tag
#define EnNearJXSPromoteBt  96500    //经销商详细选项tag
#define EnNearJXSDetailSortItemBt  95000    //经销商详细选项tag
#define EnMyOrderStatusBt  94000    //我的订单状态按钮
#define EnMyOrderStatusLineBt  94500    //我的订单状态按钮下面蓝色的线
#define EnNearBySeViewTag  94800    //SegmentControl控件 
#define EnNearBySelectColorBt  93000  //购买商品选择颜色
#define EnNearBySelectSpecifiBt  93500  //购买商品选择规格
#define EnNearBySelectModelBt  93600  //购买商品选择规格
#define EnNearBySelectItemBttag1  93801  //附近 全部类型
#define EnNearBySelectItemBttag2  93802  //附近 全部类型
#define EnNearBySelectItemBttag3  93803  //附近 全部类型

#define EnLoginPhoneTextFieldTag          92000  // 登录电话输入框
#define EnLoginPwdTextFieldTag          92100  // 登录密码输入框

#define EnRegiestPhoneTextFieldTag          92200  // 注册电话输入框
#define EnRegiestPwdTextFieldTag          92300  // 注册密码输入框
#define EnRegiestPwdTextFieldTag1          92301  // 注册密码输入框
#define EnRegiestAreaTextFieldTag          92302  // 注册所在地区
#define EnRegiestLevelTextFieldTag          92304  // 注册所在上线经销商
#define EnRegiestCodeTextFieldTag          92400  // 注册验证码输入框
#define EnRegiestCarRealNameTextFieldTag          92500  // 注册真实姓名输入框
#define EnRegiestCardNumberTextFieldTag          92600  // 注册身份证号输入框
#define EnRegiestCardPersonPicTag1             92701//注册上传身份证的tag
#define EnRegiestCardPersonPicTag2             92702//注册上传身份证的tag
#define EnRegiestCardPersonPicTag3             92703//注册上传身份证的tag
#define EnMaskViewActionTag                      92800//选择的actiontag
#define EnViewSheetTag                      92811//viewsheettag
#define EnSearchTextfieldCityTag1                      92901//城市搜索框
#define EnSearchTextfieldCityTag2                      92902//几个一级页面搜索框
#define EnSearchTextfieldCityTag3                      92903//一级点击搜索进去后的页面
#define EnSelectCityLeftBtTag                      92950//每个首页选择城市的导航 栏左边的按钮

#define EnReceiveSelectItemBttag1      91001//接活选择任务类型
#define EnReceiveSelectItemBttag2      91002//接活选择区域类型
#define EnReceiveSelectItemBttag3      91003//接活选择时间类型

#define EnScanQRTextfieldTag      91020//二维码手工输入框

#define EnMeWalletImageTag      91025//我的钱包收支出imageview tag
#define EnMeWalletJiFenTag      91030//我的钱包积分

#define EnMeTiXianMoneyTextFieldTag   91050//填写提现金额的textfield

#define EnSearchHotWordBtTag      91080  //热词搜索 
#define EnCollectionSelectItemBtTag      90000  //收藏选择中按钮tag


#define EnCollectionRemoveViewTag      90100  //删除收藏view 

#define EnUserInfoCellLabelTag      90200  //个人信息的数据label 

#define EnModifyBindingOldTelTextfieldTag      90301  //修改绑定电话的原电话号码
#define EnModifyBindingOldCodeTextfieldTag      90302  //修改绑定电话的原电话验证码
#define EnModifyBindingOldGetCodeBtTag      90303  //修改绑定电话的原电话获取验证码
#define EnModifyBindingNewTelTextfieldTag      90304  //修改绑定电话的新电话号码
#define EnModifyBindingNewCodeTextfieldTag      90305  //修改绑定电话的新电话号码验证码
#define EnModifyBindingNewGetCodeBtTag      90306  //修改绑定电话的新电话获取验证码


#define EnReceiveAddrDefaultAddrBtTag      90400  //设置默认收货地址

#define EnModifyPersonInfoTextfieldTag      90500  //修改信息的textfield

#define EnModifyOldPwdTextfieldTag     90600  //修改密码旧密码
#define EnModifyNewPwdTextfieldTag1     90601  //修改密码新密码
#define EnModifyNewPwdTextfieldTag2     90602  //修改密码新密码


#define EnAddNewAddrTFTag1    90801   //添加新地址
#define EnAddNewAddrTFTag2    90802   //添加新地址
#define EnAddNewAddrTFTag3    90803   //添加新地址
#define EnAddNewAddrTFTag4    90804   //添加新地址
#define EnAddNewAddrTFTag5    90805   //添加新地址

#define EnWebViewContentTag    90900   //webview tag

#define EnUploadHeaderPicBtTag    90950   //上传头像图片按钮

#define EnJXSDetailAdImageTag    90980   //经销商广告图片

#define EnGetGoodsThreeBtTag1   70001  //商品详细 点击 店铺
#define EnGetGoodsThreeBtTag2   70002  //商品详细 点击 收藏
#define EnGetGoodsThreeBtTag3   70003  //商品详细 点击 购物车

#define EnShoppingCarTextNumberTag1   70010  //输入修改数目

#define EnShoppingCarRemoveViewTag      70020  //购物车删除view

#define EnShoppingCarSettlementTag      70030  //购物车结算view

#define EnShoppingCarDeleteSelectAllBtTag      70040  //购物车删除上的全选按钮

#define EnShoppingCarSettlementSelectAllBtTag      70050  //购物车删除上的全选按钮

#define EnOrderSendTypeBtTag      70100  //订单配送方式

#define EnOrderPayTypeBtTag      70200  //订单支付方式

#define EnOrderTransFeeLabelTag      70300  //运费

#define EnOrderToBussMessageTag      70400  //生成订单给商家 留言

#define EnOrderAddrCellViewTag      70500  //生成订单地址cell

#define EnOrderActMoneyLableTag      70600  //生成订单实付款金额

#define EnMyReportAddPicButtonTag     70700  //我的举报 里点击添加 图片

#define EnMyReportPicImageViewTag     70800  //我的举报 里的举报 图片

#define EnMyReportDeletePicBtTag    70900   //我的举报里的删除举报 图片

#define EnReportTypeTextfieldTag    71000 //举报类型
#define EnReportTimeTextfieldTag    71010 //举报时间
#define EnReportAreaTextfieldTag    71020 //所属区域
#define EnReportScanAddressTextfieldTag    71030 //扫码地点
#define EnReportUpJXSTextfieldTag    71040 //上级经销商
#define EnReportProductTextfieldTag    71050 //使用产品
#define EnReportContentTextViewTag    71060 //举报 内容

#define EnHotPhoneBtTag    71070 //热线电话button
#define EnImageXingImageviewtag   71080   //星imageview
#define EnButtonXinTag       71090    //星button
#define EnEvaluationTextViewTag    72000 //评价内容

#define EnNctlMessageBt     72010  //消息button

#define EnSelectCityLocation   72020  //选择城市定位 信息button

#define EnShoppingCarAllPriceLabelTag  72030  //购物车里的总价价格

#define EnTiXianSlectJsxNameLabelTag   72051  //提现的时候选择经销商的名称
#define EnTiXianSlectJsxaddrLabelTag   72052  //提现的时候选择经销商的名称
#define EnTiXianSlectJsxtelLabelTag   72053  //提现的时候选择经销商的名称
#define EnTiXianSlectJsxdistanceLabelTag   72054  //提现的时候选择经销商的名称
#define EnTiXianNoLaLongImageviewTag   72100  //提现无经纬度时显示图片
#define EnTiXianDiTuWebViewTag    72200  //提现地图webview
#define EnTiXianAddrBgImageViewTag  72210 //提现地图的显示地址的白色背景

#define EnThreeLoginButtonTag   72300   //第三方登录

#define EnMettingListSelectItembt1  72400
#define EnMettingListSelectItembt2  72401
#define EnMettingListSelectItembt3  72402



