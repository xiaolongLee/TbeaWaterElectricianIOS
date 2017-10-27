//
//  CustomTabBar.m
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar ()

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *lastButton; //记录上次被点击的button

@end

@implementation CustomTabBar

-(void)setButtonContentCenter:(UIButton *) btn

{
	
	CGSize imgViewSize,titleSize,btnSize;
	
	UIEdgeInsets imageViewEdge,titleEdge;
	
	CGFloat heightSpace = 10.0f;
	
	
	
	//设置按钮内边距
	
	imgViewSize = btn.imageView.bounds.size;
	
	titleSize = btn.titleLabel.bounds.size;
	
	btnSize = btn.bounds.size;
	
	
	
	imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
	
	[btn setImageEdgeInsets:imageViewEdge];
	
	titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
	
	[btn setTitleEdgeInsets:titleEdge];
	
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背景图
        [self addSubview:self.bgView];
        
        //加载tabBar
        for (int  i = 0; i < self.dataArray.count; i++) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemButton setImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
            [itemButton setImage:[UIImage imageNamed:[[self.dataArray[i] substringToIndex:2] stringByAppendingString:@"blue"]] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
			itemButton.tag = CustomTabBarTypehomepage+i;
			itemButton.titleLabel.font = FONTN(11.0f);
			
			
			[itemButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 20, 0, 0)];
			[itemButton setTitleEdgeInsets:UIEdgeInsetsMake(25, -15, 0, 0)];
			NSString *str;
			CGSize size1;
			UIImage *imagepic;
			switch (i)
			{
				case 0:
					[itemButton setTitle:@"首页" forState:UIControlStateNormal];
					[itemButton setTitleColor:ColorBlue forState:UIControlStateNormal];
					imagepic = [UIImage imageNamed:@"首页blue"];
					str = @"首页";
					size1 = [str sizeWithFont:FONTN(11.0f) constrainedToSize:CGSizeMake(MAXFLOAT, itemButton.titleLabel.frame.size.height)];
					itemButton.titleEdgeInsets =UIEdgeInsetsMake(0.5*imagepic.size.height+5, -0.5*imagepic.size.width, -0.5*imagepic.size.height, 0.5*imagepic.size.width);
					itemButton.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
					break;
				case 1:
					[itemButton setTitle:@"附近" forState:UIControlStateNormal];
					[itemButton setTitleColor:ColorBlackshallow forState:UIControlStateNormal];
					imagepic = [UIImage imageNamed:@"附近blue"];
					str = @"附近";
					size1 = [AddInterface getlablesize:str Fwidth:MAXFLOAT Fheight:itemButton.titleLabel.frame.size.height Sfont:FONTN(11.0f)];
					itemButton.titleEdgeInsets =UIEdgeInsetsMake(0.5*imagepic.size.height+5, -0.5*imagepic.size.width, -0.5*imagepic.size.height, 0.5*imagepic.size.width);
					itemButton.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
					break;
				case 2:
					[itemButton setTitle:@"接活" forState:UIControlStateNormal];
					[itemButton setTitleColor:ColorBlackshallow forState:UIControlStateNormal];
					imagepic = [UIImage imageNamed:@"接活blue"];
					str = @"接活";
					size1 = [str sizeWithFont:FONTN(11.0f) constrainedToSize:CGSizeMake(MAXFLOAT, itemButton.titleLabel.frame.size.height)];
					itemButton.titleEdgeInsets =UIEdgeInsetsMake(0.5*imagepic.size.height+5, -0.5*imagepic.size.width, -0.5*imagepic.size.height, 0.5*imagepic.size.width);
					itemButton.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
					break;
				case 3:
					[itemButton setTitle:@"我的" forState:UIControlStateNormal];
					[itemButton setTitleColor:ColorBlackshallow forState:UIControlStateNormal];
					imagepic = [UIImage imageNamed:@"我的blue"];
					str = @"我的";
					size1 = [str sizeWithFont:FONTN(11.0f) constrainedToSize:CGSizeMake(MAXFLOAT, itemButton.titleLabel.frame.size.height)];
					itemButton.titleEdgeInsets =UIEdgeInsetsMake(0.5*imagepic.size.height+5, -0.5*imagepic.size.width, -0.5*imagepic.size.height, 0.5*imagepic.size.width);
					itemButton.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
					break;
			}
			
            if (i==0) {
                itemButton.selected = YES;
                self.lastButton = itemButton;
            }
            
            [self addSubview:itemButton];
        }
        
        [self addSubview:self.cameraBtn];
        
    }
    return self;
}

//子视图布局
- (void)layoutSubviews{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/5;
    for (UIView *btn in self.subviews) {
		
		int tagnow = (int)btn.tag-CustomTabBarTypehomepage;
        if (tagnow == 0)
		{
            btn.frame = CGRectMake(0, 0, width, self.frame.size.height);
        }
		else if (tagnow == 1)
		{
			btn.frame = CGRectMake(width, 0, width, self.frame.size.height);
		}
		else if (tagnow == 2)
		{
			btn.frame = CGRectMake(width*3, 0, width, self.frame.size.height);
		}
		else if(tagnow == 3)
		{
			btn.frame = CGRectMake(width*4, 0, width, self.frame.size.height);
		}
		
    }
    self.cameraBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 22);
    
    self.bgView.frame = self.bounds;
}

#pragma mark - button click event -
- (void)clickAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(selectedBarItemWithType:)]) {
        
        [self.delegate selectedBarItemWithType:button.tag];
    }
    
    //点击中间按钮跳过下面
    if (button.tag==CustomTabBarTypeLaunch) {
        return;
    }
    
    //取消上次点击选中状态
    self.lastButton.selected = NO;
    
    //标记选中
    button.selected = YES;
    
    //赋值新的被点击按钮
    self.lastButton = button;
    
    
    //添加动态效果
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}



/**
 子视图超出父视图范围 需要重写该方法 来响应点击时间
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [self.cameraBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(self.cameraBtn.bounds, newPoint)) {
            view = self.cameraBtn;
        }
    }
    return view;
}

#pragma mark - getter and setter -
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"首页gray",@"附近gray",@"接活gray",@"我的gray"];
    }
    return _dataArray;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
        _bgView.frame = self.bounds;
        
    }
    return _bgView;
}

- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"扫码"] forState:UIControlStateNormal];
        [_cameraBtn sizeToFit];
        [_cameraBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.tag = CustomTabBarTypeLaunch;
    }
    return _cameraBtn;
}

@end
