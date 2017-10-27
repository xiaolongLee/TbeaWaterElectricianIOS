//
//  SearchPageView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SearchPageTopView.h"

@implementation SearchPageTopView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self)
	{
		fromflag = 1;
		[self initview];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame Whiter:(int)white
{
	self = [super initWithFrame:frame];
	if(self)
	{
		fromflag = 2;
		[self initviewwhite];
	}
	return self;
}

-(id)initWithgoods:(CGRect)frame  //进入搜索页面
{
	self = [super initWithFrame:frame];
	if(self)
	{
		fromflag = 3;
		[self initviewgoods];
	}
	return self;
}

-(void)initviewwhite
{
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = 2.0f;
	self.clipsToBounds = YES;
	
	
	UIImageView *searchicon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 15, 15)];
	searchicon.image = LOADIMAGE(@"hp_searchblue", @"png");
	[self addSubview:searchicon];
	
	UITextField *textfieldsearch = [[UITextField alloc] initWithFrame:CGRectMake(searchicon.frame.origin.x+searchicon.frame.size.width+5, 1, self.frame.size.width-30,28)];
	textfieldsearch.backgroundColor = [UIColor clearColor];
	textfieldsearch.placeholder = @"输入城市名字查询";
	textfieldsearch.delegate = self;
	textfieldsearch.tag = EnSearchTextfieldCityTag1;
	textfieldsearch.textColor = ColorBlackdeep;
	textfieldsearch.returnKeyType = UIReturnKeySearch;
	[textfieldsearch setValue:COLORNOW(220, 220, 220) forKeyPath:@"_placeholderLabel.textColor"];
	textfieldsearch.font = FONTN(14.0f);
	[self addSubview:textfieldsearch];
}

-(void)initviewgoods
{
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = 2.0f;
	self.clipsToBounds = YES;
	
	
	UIButton *buttontype = [UIButton buttonWithType:UIButtonTypeCustom];
	buttontype.titleLabel.font = FONTN(12.0f);
	[buttontype setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	[buttontype setTitle:@"商品" forState:UIControlStateNormal];
	[buttontype addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
	buttontype.frame = CGRectMake(3, 0, 40, 30);
	[buttontype setBackgroundColor:[UIColor clearColor]];
	[self addSubview:buttontype];
	
	UITextField *textfieldsearch = [[UITextField alloc] initWithFrame:CGRectMake(buttontype.frame.origin.x+buttontype.frame.size.width+5, 1, self.frame.size.width-30,28)];
	textfieldsearch.backgroundColor = [UIColor clearColor];
	textfieldsearch.placeholder = @"输入搜索的名称";
	textfieldsearch.delegate = self;
	textfieldsearch.tag = EnSearchTextfieldCityTag3;
	textfieldsearch.textColor = ColorBlackdeep;
	textfieldsearch.returnKeyType = UIReturnKeySearch;
	[textfieldsearch setValue:COLORNOW(220, 220, 220) forKeyPath:@"_placeholderLabel.textColor"];
	textfieldsearch.font = FONTN(14.0f);
	[self addSubview:textfieldsearch];
}

-(void)initview
{
	self.backgroundColor = COLORNOW(48, 141, 214);
	self.layer.cornerRadius = 2.0f;
	self.clipsToBounds = YES;
	
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIImageView *searchicon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 15, 15)];
	searchicon.image = LOADIMAGE(@"hp_searchicon", @"png");
	[self addSubview:searchicon];
	
	UITextField *textfieldsearch = [[UITextField alloc] initWithFrame:CGRectMake(searchicon.frame.origin.x+searchicon.frame.size.width+5, 1, self.frame.size.width-30,28)];
	textfieldsearch.backgroundColor = [UIColor clearColor];
	textfieldsearch.placeholder = @"搜索商品或店铺";
	textfieldsearch.delegate = self;
	textfieldsearch.tag = EnSearchTextfieldCityTag2;
	textfieldsearch.textColor = [UIColor whiteColor];
	textfieldsearch.tintColor = [UIColor whiteColor];
	[textfieldsearch setValue:COLORNOW(240, 240, 240) forKeyPath:@"_placeholderLabel.textColor"];
	textfieldsearch.font = FONTN(14.0f);
	[self addSubview:textfieldsearch];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	NSString *strUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
	if([textField.text length]<2)
	{
		[MBProgressHUD showError:@"搜索内容至少需要2个字符" toView:app.window];
	}
	else if([strUrl length]<2)
	{
		[MBProgressHUD showError:@"搜索内容至少需要2个字符" toView:app.window];
	}
	else
	{
		if(textField.tag == EnSearchTextfieldCityTag1)
		{	
			if([self.delgate1 respondsToSelector:@selector(DGClickSearchCityTextField:)])
			{
				[self.delgate1 DGClickSearchCityTextField:textField.text];
			}
			return YES;
		}
		else if(textField.tag == EnSearchTextfieldCityTag3)
		{
			if([self.delgate1 respondsToSelector:@selector(DGClickSearchResultTextField:)])
			{
				[self.delgate1 DGClickSearchResultTextField:textField.text];
			}
			return NO;
		}
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnSearchTextfieldCityTag2)
	{
		if([self.delgate1 respondsToSelector:@selector(DGClickSearchOneLevelTextField:)])
		{
			[self.delgate1 DGClickSearchOneLevelTextField:textField.text];
		}
		return NO;
	}
	return YES;
}

-(void)selecttype:(id)sender
{
	
}

@end
