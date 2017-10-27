//
//  RegiestViewStartController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegiestViewStartController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIActionSheetDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSTimer * timerone;
	int selectmodel;
	int getyanzhengcodeflag;
	NSString *regiestphone;
	NSString *regiestcode;
	NSString *regiestpwd;
	NSString *strproviceid;
	NSString *strcityid;
	NSString *strareaid;
	NSString *strlevelid;
	NSArray *arraydistributor;
	NSDictionary *dicaddrselect;
	NSMutableArray *content1;
	NSDictionary *dictel;
}
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
