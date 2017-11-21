//
//  AppDelegate.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize dili;
@synthesize userinfo;

-(void)inituserdili
{
	self.dili = [[DiliWeiZhi alloc] init];
	self.dili.dilicity = @"德阳市";
	self.dili.diliprovince = @"四川省";
	self.dili.dililocality = @"旌阳区";
	self.dili.diliroad = @"东海路东段";
	self.dili.dilinumber = @"2号";
	self.dili.latitude = 31.132588;
	self.dili.longitude = 104.363965;
	self.userinfo = [[UserInfo alloc] init];
	if([AddInterface judgeislogin])
	{
		NSDictionary *dictemp = [NSDictionary dictionaryWithContentsOfFile:UserMessage];
		self.userinfo.userid = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"id"]];
	}
	else
	{
		self.userinfo.userid = @"";
	}
}

-(void)getnowlocation
{
    self.GBURLPreFix = @"";
	mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [mapManager start:@"WPiZu7vPXwXD0Qkk99oEgCSLlB4y5eF5" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
	locService = [[BMKLocationService alloc]init];
	geocodesearch = [[BMKGeoCodeSearch alloc]init];
	locService.delegate = self;
	geocodesearch.delegate = self;
	[locService startUserLocationService];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	[self inituserdili];  //初始化地user和地理位置
	[self getnowlocation];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	// 设置窗口的根控制器
//	CustomTabBarController *tabBar = [[CustomTabBarController alloc] init];
//	self.window.rootViewController = tabBar;
	self.window.rootViewController = [[BXTabBarController alloc] init];
	[self.window makeKeyAndVisible];
	
	[[UMSocialManager defaultManager] openLog:YES];
	
	/* 设置友盟appkey */
	[[UMSocialManager defaultManager] setUmSocialAppkey:@"58bbfc9982b63505bb000fec"];
	
	[self configUSharePlatforms];
	
//	[self confitUShareSettings];
	
	
	
	return YES;
}


#pragma mark 友盟
- (void)configUSharePlatforms
{
	/* 设置微信的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf0098beca31d85cc" appSecret:@"4767495ecded06e0fdc6e8b6a289d56f" redirectURL:@"http://mobile.umeng.com/social"];
//	/*
//	 * 移除相应平台的分享，如微信收藏
//	 */
//	//[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
//	
//	/* 设置分享到QQ互联的appID
//	 * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//	 */
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
	
	/* 设置新浪的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3525593155"  appSecret:@"ad55f2a5b4997936296ce052649c406e" redirectURL:@"http://www.u-shang.net/enginterface/index.php/callback"];
	
//	/* 钉钉的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//	
//	/* 支付宝的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//	
//	
//	/* 设置易信的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
	
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}


#pragma mark 地图
/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
	
	NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
	NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
	[locService stopUserLocationService];
	[self onClickReverseGeocode:userLocation.location.coordinate.latitude CoordinateX:userLocation.location.coordinate.longitude];
	
	self.dili.latitude = userLocation.location.coordinate.latitude;
	self.dili.longitude = userLocation.location.coordinate.longitude;
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
	NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
	NSLog(@"location error");
}

-(void)onClickReverseGeocode:(float)coordinatey CoordinateX:(float)coordinatex
{
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){coordinatey, coordinatex};
	BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
	reverseGeocodeSearchOption.reverseGeoPoint = pt;
	BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
	if(flag)
	{
		NSLog(@"反geo检索发送成功");
	}
	else
	{
		NSLog(@"反geo检索发送失败");
		[MBProgressHUD showError:@"你没有开启定位信息,将为你显示默认城市信息！" toView:self.window];
	}
	
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.location;
		item.title = result.address;
		NSString* titleStr;
		NSString* showmeg;
		titleStr = @"反向地理编码";
		showmeg = [NSString stringWithFormat:@"%@",item.title];
		

		
		self.dili.dilicity = result.addressDetail.city;
		self.dili.diliprovince = result.addressDetail.province;
		self.dili.dililocality =  result.addressDetail.district;
		self.dili.diliroad = result.addressDetail.streetName;
		self.dili.dilinumber = result.addressDetail.streetNumber;
		self.dili.latitude = result.location.latitude;
		self.dili.longitude = result.location.longitude;

		DLog(@"≈====%@,%@,%@,%@,%@,%f,%f",result.addressDetail.streetNumber,result.addressDetail.streetName,result.addressDetail.district,result.addressDetail.city,result.addressDetail.province,self.dili.latitude,self.dili.longitude);
		
	}
}

- (void)onGetNetworkState:(int)iError
{
	if (0 == iError) {
		NSLog(@"联网成功");
	}
	else{
		NSLog(@"onGetNetworkState %d",iError);
	}
	
}

- (void)onGetPermissionState:(int)iError
{
	if (0 == iError) {
		NSLog(@"授权成功");
	}
	else {
		NSLog(@"onGetPermissionState %d",iError);
	}
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
