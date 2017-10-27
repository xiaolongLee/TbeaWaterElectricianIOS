//
//  UserLocationObject.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "UserLocationObject.h"

@implementation UserLocationObject

-(void)getnowlocation
{
	dili = [[DiliWeiZhi alloc] init];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
	
	dili.latitude = userLocation.location.coordinate.latitude;
	dili.longitude = userLocation.location.coordinate.longitude;
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
		[MBProgressHUD showError:@"你没有开启定位信息,将为你显示默认城市信息！" toView:app.window];
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
		
		
		
		dili.dilicity = result.addressDetail.city;
		dili.diliprovince = result.addressDetail.province;
		dili.dililocality =  result.addressDetail.district;
		dili.diliroad = result.addressDetail.streetName;
		dili.dilinumber = result.addressDetail.streetNumber;
		dili.latitude = result.location.latitude;
		dili.longitude = result.location.longitude;
		
		
		app.dili.dilicity = dili.dilicity;
		app.dili.diliprovince = dili.diliprovince;
		app.dili.dililocality = dili.dililocality;
		app.dili.diliroad = dili.diliroad;
		app.dili.dilinumber = dili.dilinumber;
		app.dili.latitude = dili.latitude;
		app.dili.longitude = dili.longitude;
		
		
		DLog(@"≈====%@,%@,%@,%@,%@,%f,%f",result.addressDetail.streetNumber,result.addressDetail.streetName,result.addressDetail.district,result.addressDetail.city,result.addressDetail.province,dili.latitude,dili.longitude);
		if([self.delegate1 respondsToSelector:@selector(DGGetUserLocatioObject:)])
		{
			[self.delegate1 DGGetUserLocatioObject:nil];
		}
		
		
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



@end
