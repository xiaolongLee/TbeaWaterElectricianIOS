//
//  SelectSpecificationView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/30.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SelectSpecificationView.h"

@implementation SelectSpecificationView

-(id)initWithFrame:(CGRect)frame DicData:(NSDictionary *)dicdata
{
	self = [super initWithFrame:frame];
	if(self)
	{
		diccommidifyinfo = dicdata;
		[self initview:dicdata];
	}
	return self;
}

-(void)initview:(NSDictionary *)dicdata
{
	self.backgroundColor = [UIColor clearColor];
	
	NSArray *arraycolorlist = [dicdata objectForKey:@"colorlist"];
	NSArray *arrayspecifilist = [dicdata objectForKey:@"commodityspeclist"]; //规格
    NSArray *arraymodellist = [dicdata objectForKey:@"commoditymodellist"]; //型号
	NSDictionary *diccommodityinfo = [dicdata objectForKey:@"commodityinfo"];
	
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	button.backgroundColor = [UIColor blackColor];
	[button addTarget:self action:@selector(removeselfview:) forControlEvents:UIControlEventTouchUpInside];
	button.alpha = 0.5;
	[self addSubview:button];
	
	int countspecifi = (int)[arrayspecifilist count];
    int countmodel = (int)[arraymodellist count];
	int countcolor = (int)[arraycolorlist count];
	int hspecifi = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
    int hmodel = (countmodel%4==0?countmodel/4:countmodel/4+1);
	int hcolor = (countcolor%4==0?countcolor/4:countcolor/4+1);
	
	float h = 420+(35*((hspecifi+hcolor+hmodel)-2))+IPhone_SafeBottomMargin;  //这2表示有几排  当都只有一排的时候是380
    
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-h, SCREEN_WIDTH, h)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageviewbg];
	
	
	UILabel *labelspecifi = [[UILabel alloc] initWithFrame:CGRectMake(10, imageviewbg.frame.origin.y+10, 150, 20)];
	labelspecifi.text = @"颜色、型号、规格";
	labelspecifi.font = FONTMEDIUM(13.0f);
	labelspecifi.textColor = ColorBlackdeep;
	[self addSubview:labelspecifi];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewbg.frame.origin.y+40, SCREEN_WIDTH, 1)];
	imageviewline.backgroundColor = Colorgray;
	[self addSubview:imageviewline];
	
	UIButton *buttonclose = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonclose.frame = CGRectMake(self.frame.size.width-45,imageviewbg.frame.origin.y,40,39);
	buttonclose.backgroundColor = [UIColor clearColor];
	[buttonclose setImage:LOADIMAGE(@"arrowbottom", @"png") forState:UIControlStateNormal];
	[buttonclose addTarget:self action:@selector(removeselfview:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonclose];
	
	
	//产品说明
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, imageviewline.frame.origin.y+10, 60, 60)];
	NSURL *urlstr = [NSURL URLWithString:[diccommodityinfo objectForKey:@"picture"]];
	[imageviewicon setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewicon];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(imageviewicon.frame.origin.x+imageviewicon.frame.size.width+10, imageviewicon.frame.origin.y, 100, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[diccommodityinfo objectForKey:@"price"]];
	labelprice.font = FONTN(14.0f);
	labelprice.textColor = Colorredcolor;
	[self addSubview:labelprice];
	
	UILabel *labelkucun = [[UILabel alloc] initWithFrame:CGRectMake(imageviewicon.frame.origin.x+imageviewicon.frame.size.width+10, labelprice.frame.origin.y+labelprice.frame.size.height+5, 180, 20)];
	labelkucun.text = [NSString stringWithFormat:@"库存%@件",[diccommodityinfo objectForKey:@"stock"]];
	labelkucun.font = FONTN(14.0f);
	labelkucun.textColor = ColorBlackdeep;
	[self addSubview:labelkucun];
	
	UIView *viewnumber =  [self addnumbercell:CGRectMake(SCREEN_WIDTH-100, labelkucun.frame.origin.y-2, 90, 25)];
	[self addSubview:viewnumber];
	
	//颜色
	UIView *viewcolor = [self addselectcolor:arraycolorlist Frame:CGRectMake(0, imageviewicon.frame.origin.y+imageviewicon.frame.size.height+10, SCREEN_WIDTH, 100)];
	[self addSubview:viewcolor];
	
	//规格
	UIView *viewspecifi = [self addselectspecifi:arrayspecifilist Frame:CGRectMake(0, viewcolor.frame.origin.y+viewcolor.frame.size.height+10, SCREEN_WIDTH, 100)];
	[self addSubview:viewspecifi];
	
    //型号
    UIView *viewmodel = [self addselectmodel:arraymodellist Frame:CGRectMake(0, viewcolor.frame.origin.y+viewcolor.frame.size.height+viewspecifi.frame.size.height+10, SCREEN_WIDTH, 100)];
    [self addSubview:viewmodel];
    
    

	UIButton *btdone = [UIButton buttonWithType:UIButtonTypeCustom];
	btdone.frame = CGRectMake(10, viewmodel.frame.origin.y+viewmodel.frame.size.height+10, SCREEN_WIDTH-20, 40);
	[btdone setTitle:@"确认" forState:UIControlStateNormal];
	btdone.layer.cornerRadius = 3.0f;
	btdone.backgroundColor = Colorredcolor;
	[btdone addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
	btdone.titleLabel.font = FONTN(14.0f);
	[btdone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self addSubview:btdone];

}

//规格
-(UIView *)addselectspecifi:(NSArray *)arrayspecifi Frame:(CGRect)frame
{
	UIView *viewcolor = [[UIView alloc] initWithFrame:frame];
	viewcolor.backgroundColor = [UIColor clearColor];
	
	UILabel *labelkucun = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
	labelkucun.text = @"规格";
	labelkucun.font = FONTN(13.0f);
	labelkucun.textColor = ColorBlackshallow;
	[viewcolor addSubview:labelkucun];
	
	float nowwidth = (SCREEN_WIDTH-20-30)/4;
	float heightnow = labelkucun.frame.size.height+5;
	int counth = 0;
	int countv = 0;
	int countspecifi = (int)[arrayspecifi count];
	counth = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
	
	
	for(int i=0;i<counth;i++)
	{
		DLog(@"heightnow===%f",heightnow);
		if(i<counth-1)
		{
			countv = 4;
		}
		else
		{
			countv = countspecifi%4;
		}
		
		for(int j=0;j<countv;j++)
		{
			NSDictionary *dictemp = [arrayspecifi objectAtIndex:i*4+j];
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.frame = CGRectMake(10+(nowwidth+10)*j,heightnow,nowwidth,30);
			button.titleLabel.font = FONTN(13.0f);
			button.layer.cornerRadius = 3.0f;
			button.clipsToBounds = YES;
			[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
			[button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
			if(i==0&&j==0)
			{
				specifiid = [dictemp objectForKey:@"id"];
				button.backgroundColor = ColorBlue;
				[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			}
			else
			{
				button.backgroundColor = [UIColor whiteColor];
				button.layer.borderColor = ColorBlackdeep.CGColor;
				button.layer.borderWidth = 0.5;
				[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
			}
			button.tag = EnNearBySelectSpecifiBt+i*4+j;
			[button addTarget:self action:@selector(clickspecifi:) forControlEvents:UIControlEventTouchUpInside];
			[viewcolor addSubview:button];
		}
		heightnow = heightnow+(30+5);
		
	}
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightnow, SCREEN_WIDTH, 1)];
	imageviewline.backgroundColor = Colorgray;
	[viewcolor addSubview:imageviewline];
	
	viewcolor.frame = CGRectMake(viewcolor.frame.origin.x, viewcolor.frame.origin.y, viewcolor.frame.size.width,imageviewline.frame.origin.y+1);
	
	return viewcolor;
}

//型号
-(UIView *)addselectmodel:(NSArray *)arraymodel Frame:(CGRect)frame
{
    UIView *viewcolor = [[UIView alloc] initWithFrame:frame];
    viewcolor.backgroundColor = [UIColor clearColor];
    
    UILabel *labelkucun = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    labelkucun.text = @"型号";
    labelkucun.font = FONTN(13.0f);
    labelkucun.textColor = ColorBlackshallow;
    [viewcolor addSubview:labelkucun];
    
    float nowwidth = (SCREEN_WIDTH-20-30)/4;
    float heightnow = labelkucun.frame.size.height+5;
    int counth = 0;
    int countv = 0;
    int countmodel = (int)[arraymodel count];
    counth = (countmodel%4==0?countmodel/4:countmodel/4+1);
    
    
    for(int i=0;i<counth;i++)
    {
        DLog(@"heightnow===%f",heightnow);
        if(i<counth-1)
        {
            countv = 4;
        }
        else
        {
            countv = countmodel%4;
        }
        
        for(int j=0;j<countv;j++)
        {
            NSDictionary *dictemp = [arraymodel objectAtIndex:i*4+j];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+(nowwidth+10)*j,heightnow,nowwidth,30);
            button.titleLabel.font = FONTN(13.0f);
            button.layer.cornerRadius = 3.0f;
            button.clipsToBounds = YES;
            [button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
            [button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
            if(i==0&&j==0)
            {
                modelid = [dictemp objectForKey:@"id"];
                button.backgroundColor = ColorBlue;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else
            {
                button.backgroundColor = [UIColor whiteColor];
                button.layer.borderColor = ColorBlackdeep.CGColor;
                button.layer.borderWidth = 0.5;
                [button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
            }
            button.tag = EnNearBySelectModelBt+i*4+j;
            [button addTarget:self action:@selector(clickmodel:) forControlEvents:UIControlEventTouchUpInside];
            [viewcolor addSubview:button];
        }
        heightnow = heightnow+(30+5);
        
    }
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightnow, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = Colorgray;
    [viewcolor addSubview:imageviewline];
    
    viewcolor.frame = CGRectMake(viewcolor.frame.origin.x, viewcolor.frame.origin.y, viewcolor.frame.size.width,imageviewline.frame.origin.y+1);
    
    return viewcolor;
}

//颜色
-(UIView *)addselectcolor:(NSArray *)arraycolor Frame:(CGRect)frame
{
	UIView *viewcolor = [[UIView alloc] initWithFrame:frame];
	viewcolor.backgroundColor = [UIColor clearColor];
	
	UILabel *labelkucun = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
	labelkucun.text = @"颜色";
	labelkucun.font = FONTN(13.0f);
	labelkucun.textColor = ColorBlackshallow;
	[viewcolor addSubview:labelkucun];
	
	float nowwidth = (SCREEN_WIDTH-20-30)/4;
	float heightnow = labelkucun.frame.size.height+5;
	
	int counth = 0;
	int countv = 0;
	int countcolor = (int)[arraycolor count];
	counth = (countcolor%4==0?countcolor/4:countcolor/4+1);
	
	
	for(int i=0;i<counth;i++)
	{
		DLog(@"heightnow===%f",heightnow);
		if(i<counth-1)
		{
			countv = 4;
		}
		else
		{
			countv = countcolor%4;
		}
		
		for(int j=0;j<countv;j++)
		{
			NSDictionary *dictemp = [arraycolor objectAtIndex:i*4+j];
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.frame = CGRectMake(10+(nowwidth+10)*j,heightnow,nowwidth,30);
			button.titleLabel.font = FONTN(13.0f);
			button.layer.cornerRadius = 3.0f;
			button.clipsToBounds = YES;
			[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
			[button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
			if(i==0&&j==0)
			{
				colorid = [dictemp objectForKey:@"id"];
				button.backgroundColor = ColorBlue;
				[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			}
			else
			{
				button.backgroundColor = [UIColor whiteColor];
				button.layer.borderColor = ColorBlackdeep.CGColor;
				button.layer.borderWidth = 0.5;
				[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
			}
			button.tag = EnNearBySelectColorBt+i*4+j;
			[button addTarget:self action:@selector(clickcolor:) forControlEvents:UIControlEventTouchUpInside];
			[viewcolor addSubview:button];
		}
		heightnow = heightnow+(30+5);
	}
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, heightnow, SCREEN_WIDTH, 1)];
	imageviewline.backgroundColor = Colorgray;
	[viewcolor addSubview:imageviewline];
	
	viewcolor.frame = CGRectMake(viewcolor.frame.origin.x, viewcolor.frame.origin.y, viewcolor.frame.size.width,imageviewline.frame.origin.y+1);
	
	return viewcolor;
}

-(void)clickspecifi:(id)sender
{
	
	NSArray *arrayspecifilist = [diccommidifyinfo objectForKey:@"commodityspeclist"];
	for(int i=0;i<20;i++)
	{
		UIButton *button = [self viewWithTag:EnNearBySelectSpecifiBt+i];
		if(button.isEnabled == YES)
		{
			button.backgroundColor = [UIColor whiteColor];
			button.layer.borderColor = ColorBlackdeep.CGColor;
			button.layer.borderWidth = 0.5;
			[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		}
	}
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnNearBySelectSpecifiBt;
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.layer.borderWidth = 0;
	button.backgroundColor = ColorBlue;
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	NSDictionary *dictemp = [arrayspecifilist objectAtIndex:tagnow];
	specifiid = [dictemp objectForKey:@"id"];
}

-(void)clickmodel:(id)sender
{
    
    NSArray *arraymodellist = [diccommidifyinfo objectForKey:@"commoditymodellist"];
    for(int i=0;i<20;i++)
    {
        UIButton *button = [self viewWithTag:EnNearBySelectModelBt+i];
        if(button.isEnabled == YES)
        {
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderColor = ColorBlackdeep.CGColor;
            button.layer.borderWidth = 0.5;
            [button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
        }
    }
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnNearBySelectModelBt;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 0;
    button.backgroundColor = ColorBlue;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSDictionary *dictemp = [arraymodellist objectAtIndex:tagnow];
    modelid = [dictemp objectForKey:@"id"];
}

-(void)clickcolor:(id)sender
{
	NSArray *arraycolorlist = [diccommidifyinfo objectForKey:@"colorlist"];
	for(int i=0;i<20;i++)
	{
		UIButton *button = [self viewWithTag:EnNearBySelectColorBt+i];
		if(button.isEnabled == YES)
		{
			button.backgroundColor = [UIColor whiteColor];
			button.layer.borderColor = ColorBlackdeep.CGColor;
			button.layer.borderWidth = 0.5;
			[button setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
		}
	}
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnNearBySelectColorBt;
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.layer.borderWidth = 0;
	button.backgroundColor = ColorBlue;
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	NSDictionary *dictemp = [arraycolorlist objectAtIndex:tagnow];
	colorid = [dictemp objectForKey:@"id"];
	
}

-(UIView *)addnumbercell:(CGRect)numframe
{
	UIView *viewremove = [[UIView alloc] initWithFrame:numframe];
	[self addSubview:viewremove];
	
	UIButton *buttonremove = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonremove.titleLabel.font = FONTN(15.0f);
	[buttonremove setTitle:@"-" forState:UIControlStateNormal];
	[buttonremove addTarget:self action:@selector(removenumber:) forControlEvents:UIControlEventTouchUpInside];
	buttonremove.layer.borderColor = Colorgray.CGColor;
	buttonremove.layer.borderWidth = 0.5f;
	[buttonremove setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	buttonremove.frame = CGRectMake(0, 0, 25,numframe.size.height);
	[buttonremove setBackgroundColor:[UIColor clearColor]];
	[viewremove addSubview:buttonremove];
	
	UITextField *textfieldnumber = [[UITextField alloc] init];
	textfieldnumber.frame = CGRectMake(buttonremove.frame.origin.x+buttonremove.frame.size.width-0.5, 0, 40, numframe.size.height);
	textfieldnumber.backgroundColor = [UIColor clearColor];
	textfieldnumber.layer.borderColor = Colorgray.CGColor;
	textfieldnumber.layer.borderWidth = 0.5f;
	textfieldnumber.text = @"1";
	textfieldnumber.font = FONTN(14.0f);
	textfieldnumber.delegate = self;
	textfieldnumber.enabled = NO;
	textfieldnumber.textAlignment = NSTextAlignmentCenter;
	textfieldnumber.tag = EnShoppingCarTextNumberTag1;
	[viewremove addSubview:textfieldnumber];
	
	
	UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonadd.titleLabel.font = FONTN(15.0f);
	[buttonadd setTitle:@"+" forState:UIControlStateNormal];
	[buttonadd addTarget:self action:@selector(addumber:) forControlEvents:UIControlEventTouchUpInside];
	buttonadd.layer.borderColor = Colorgray.CGColor;
	buttonadd.layer.borderWidth = 0.5f;
	buttonadd.frame = CGRectMake(textfieldnumber.frame.origin.x+textfieldnumber.frame.size.width-0.5, 0, 25,numframe.size.height);
	[buttonadd setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
	[buttonadd setBackgroundColor:[UIColor clearColor]];
	[viewremove addSubview:buttonadd];
	
	return viewremove;
}

-(void)removenumber:(id)sender
{
	UITextField *textfield = [self viewWithTag:EnShoppingCarTextNumberTag1];
	int number = [[textfield text] intValue];
	if(number<2)
	{
		
	}
	else
	{
		textfield.text = [NSString stringWithFormat:@"%d",number-1];
	}
}

-(void)addumber:(id)sender
{
	UITextField *textfield = [self viewWithTag:EnShoppingCarTextNumberTag1];
	int number = [[textfield text] intValue];
	if(number>98)
	{
		
	}
	else
	{
		textfield.text = [NSString stringWithFormat:@"%d",number+1];
	}
}



-(void)clickdone:(id)sender
{
	UITextField *textfield = [self viewWithTag:EnShoppingCarTextNumberTag1];
	if([self.fromflag isEqualToString:@"1"])  //表示来自购物车
	{
		if([self.delegate1 respondsToSelector:@selector(DGAddOrderInfo:Specifi:Number:Modelid:)])
		{
            [self.delegate1 DGAddOrderInfo:colorid Specifi:specifiid Number:textfield.text Modelid:modelid];
		}
	}
	else if([self.fromflag isEqualToString:@"2"])
	{
		if([self.delegate1 respondsToSelector:@selector(DGGoToJieSuanGoods:Specifi:Number:Modelid:)])
		{
			[self.delegate1 DGGoToJieSuanGoods:colorid Specifi:specifiid Number:textfield.text Modelid:modelid];
		}
		
	}
    else
    {
        if([self.delegate1 respondsToSelector:@selector(DGClickSelectModelSpecifi:Specifi:Number:Modelid:)])
        {
            [self.delegate1 DGClickSelectModelSpecifi:colorid Specifi:specifiid Number:textfield.text Modelid:modelid];
        }
    }
	[self removeFromSuperview];
	
	
}

-(void)removeselfview:(id)sender
{
	[self removeFromSuperview];
}

@end
