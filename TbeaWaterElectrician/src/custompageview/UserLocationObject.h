//
//  UserLocationObject.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiliWeiZhi.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface UserLocationObject : NSObject<BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
	BMKLocationService* locService;
	BMKMapManager* mapManager;
	BMKGeoCodeSearch* geocodesearch;
	DiliWeiZhi *dili;
	AppDelegate *app;
}
@property(strong,nonatomic)id<ActionDelegate>delegate1;
-(void)getnowlocation;
@end
