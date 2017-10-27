//
//  ShoppingCarCellView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ShoppingCarCellView.h"

@implementation ShoppingCarCellView

-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)dic TagNow:(int)tagnow ArrayNumber:(NSMutableArray *)arraynumber
{
	self = [super initWithFrame:frame];
	if(self)
	{
		dicfrom = dic;
		[self initview:tagnow ArrayNumber:arraynumber];
	}
	return self;
}

-(void)initview:(int)tagnow ArrayNumber:(NSMutableArray *)arraynumber

{
	UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitem.titleLabel.font = FONTN(14.0f);
	buttonitem.layer.cornerRadius = 3.0f;
	buttonitem.clipsToBounds = YES;
	buttonitem.tag = EnCollectionSelectItemBtTag;
	[buttonitem setImage:LOADIMAGE(@"me_collectionselect", @"png") forState:UIControlStateNormal];
	[buttonitem addTarget:self action:@selector(clickitem:) forControlEvents:UIControlEventTouchUpInside];
	buttonitem.frame = CGRectMake(10, (self.frame.size.height-40)/2, 40,40 );
	[buttonitem setBackgroundColor:[UIColor clearColor]];
	[self addSubview:buttonitem];
	
	
	UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(buttonitem.frame.origin.x+buttonitem.frame.size.width+10, 15, 80, 80)];
	NSURL *urlstr = [NSURL URLWithString:[dicfrom objectForKey:@"commoditypicture"]];
	[imageviewleft setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[self addSubview:imageviewleft];
	
	NSString *str = [dicfrom objectForKey:@"commodityname"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-160 Fheight:38 Sfont:FONTN(14.0f)];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewleft.frame.origin.x+imageviewleft.frame.size.width+5, imageviewleft.frame.origin.y,size.width, size.height)];
	labelname.text = str;
	labelname.font = FONTN(14.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = ColorBlackdeep;
	[self addSubview:labelname];
	
	UILabel *labelspecolor = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height, SCREEN_WIDTH-160, 33)];
	labelspecolor.text = [NSString stringWithFormat:@"颜色:%@  规格:%@",[dicfrom objectForKey:@"ordercolor"],[dicfrom objectForKey:@"orderspecification"]];
	labelspecolor.font = FONTN(13.0f);
	labelspecolor.textColor = ColorBlackGray;
	[self addSubview:labelspecolor];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelspecolor.frame.origin.x, imageviewleft.frame.origin.y+imageviewleft.frame.size.height-20, 150, 20)];
	labelprice.text = [NSString stringWithFormat:@"￥%@",[dicfrom objectForKey:@"orderprice"]];
	labelprice.font = FONTN(16.0f);
	labelprice.textColor = Colorredcolor;
	[self addSubview:labelprice];
	
	UIView *viewnumber = [self addnumbercell:CGRectMake(SCREEN_WIDTH-100, labelprice.frame.origin.y-5, 90, 25) ArrayNumber:arraynumber];
	[self addSubview:viewnumber];
	
}

-(UIView *)addnumbercell:(CGRect)numframe  ArrayNumber:(NSMutableArray *)arraynumber
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
	
	int flag = 0;
	for(int i=0;i<[arraynumber count];i++)
	{
		NSDictionary *dictemp = [arraynumber objectAtIndex:i];
		if([[dictemp objectForKey:@"orderdetailid"] isEqualToString:[dicfrom objectForKey:@"orderdetailid"]])
		{
			flag = 1;
			textfieldnumber.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"ordernumber"]];
			break;
		}
	}
	if(flag == 0)
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
		if([self.delegate1 respondsToSelector:@selector(DGClickReduceNumberBtTag:NowNumber:)])
		{
			[self.delegate1 DGClickReduceNumberBtTag:dicfrom NowNumber:textfield.text];
		}

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
		if([self.delegate1 respondsToSelector:@selector(DGClickAddNumberBtTag:NowNumber:)])
		{
			[self.delegate1 DGClickAddNumberBtTag:dicfrom NowNumber:textfield.text];
		}
	}
}

-(void)clickitem:(id)sender
{
	UIButton *button = (UIButton *)sender;
	//	int tagnow = (int)[button tag]-EnCollectionSelectItemBtTag;
	if([self.delegate1 respondsToSelector:@selector(DGSelectCollectionItem:SBt:)])
	{
		[self.delegate1 DGSelectCollectionItem:dicfrom SBt:button];
	}
}

@end
