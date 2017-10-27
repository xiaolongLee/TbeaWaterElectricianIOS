//
//  JiFenTiXianViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/22.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface JiFenTiXianViewController : UIViewController<BMKMapViewDelegate,UIPickerViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSDictionary *dicmymoney;
	
	UIView *maskView;
	NSString *result1;
	NSMutableArray *content1;
	NSArray *arrayjxsdata;
	NSDictionary *dicselectaddr;
	NSString *selectdistribuid;
}
@property(nonatomic,strong)BMKMapView *bmkmapview;
@end
