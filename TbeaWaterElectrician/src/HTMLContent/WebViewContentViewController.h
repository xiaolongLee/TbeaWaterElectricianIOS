//
//  WebViewContentViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewContentViewController : UIViewController<UIWebViewDelegate>
{
	
	AppDelegate *app;
}
@property(nonatomic,strong)NSString *strnewsurl;
@property(nonatomic,strong)NSString *strtitle;
@end
