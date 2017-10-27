//
//  SelectAddressViewController.h
//  TeBian
//
//  Created by xyy520 on 16/12/2.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SelectAddressViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIActionSheetDelegate,ActionDelegate>
{
	AppDelegate *app;
	int selectmodel;
	NSMutableArray *content1;
	NSString *sproviceid;
	NSString *scityid;
	NSString *sareaid;
	NSString *sprovicename;
	NSString *scityname;
	NSString *sareaname;
	NSArray *arraycity;
	NSArray *arrayprove;
	NSArray *arrayarea;
	
	
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSDictionary *dicaddr;
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)NSString *result;
@end
