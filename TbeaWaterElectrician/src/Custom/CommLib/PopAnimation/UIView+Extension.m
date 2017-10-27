//  UIView+Extension.m
//  LHRAlerView
//
//  Created by 李海瑞 on 15/10/23.
//  Copyright © 2015年 李海瑞. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)reboundEffectAnimationDuration:(CGFloat)duration Dele:(id)delegate1 Flag:(int)flag
{   //缩放的动画 效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration=duration;
    animation.values = [NSArray arrayWithObjects:
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.60, 0.60, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)],
                    nil];//x y z 放大缩小的倍数
	animation.delegate = delegate1;
    [self.layer addAnimation:animation forKey:nil];

}


@end
