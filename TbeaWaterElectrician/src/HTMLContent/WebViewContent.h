//
//  WebViewContent.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewContent : UIView<UIWebViewDelegate>
{
	UIWebView *webview;
	AppDelegate *app;
}
-(void)loadwebview:(NSString *)strurl;
@property(nonatomic,strong)NSString *strnewsurl;
@end
