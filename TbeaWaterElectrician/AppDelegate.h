//
//  AppDelegate.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "DiliWeiZhi.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <UMSocialCore/UMSocialCore.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
	BMKLocationService* locService;
	BMKMapManager* mapManager;
	BMKGeoCodeSearch* geocodesearch;
}
@property(nonatomic,strong)NSString *GBURLPreFix;
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UserInfo *userinfo;
@property(strong,nonatomic)DiliWeiZhi *dili;

@end

