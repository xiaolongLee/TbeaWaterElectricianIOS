//
//  WebViewContent.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WebViewContent.h"

@implementation WebViewContent

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self)
	{
		[self initview];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

-(void)loadwebview:(NSString *)strurl
{
	NSURL *urlstr = [NSURL URLWithString:strurl];
	NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
	[webview loadRequest:request];
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		// code here
	webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	webview.backgroundColor = [UIColor clearColor];
	webview.delegate = self;
	webview.tag = EnWebViewContentTag;
	webview.scalesPageToFit = YES;
	[self addSubview:webview];
	
	for (UIView *_aView in [webview subviews])
	{
		if ([_aView isKindOfClass:[UIScrollView class]])
		{
			[(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
			
			for (UIView *_inScrollview in _aView.subviews)
			{
				if ([_inScrollview isKindOfClass:[UIImageView class]])
				{
					_inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
				}
			}
		}
	}
}

#pragma mark webviewdelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSString *requestString = [[request URL] absoluteString];
	if([requestString rangeOfString:@"http://distributorphone"].location != NSNotFound)
	{
		NSArray *array = [requestString componentsSeparatedByString:@"_"];
		if([array count]>1)
		{
			NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[array objectAtIndex:1]];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
		}
		return NO;
	}
	
	return YES;
	
}

@end
