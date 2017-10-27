//
//  LCTabbar.m
//  LuoChang
//
//  Created by Rick on 15/4/29.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "LCTabbar.h"
#import "LCTabBarController.h"

@interface LCTabbar()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    LCTabBarButton *_selectedBarButton;
}
@end

@implementation LCTabbar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBarButtons];
    }
    return self;
}

-(void) addBarButtons{
    for (int i = 0 ; i<5 ; i++) {
        LCTabBarButton *btn = [[LCTabBarButton alloc] init];
        CGFloat btnW = self.frame.size.width/5;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        
        CGFloat btnH = self.frame.size.height;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
		NSString *imageName;
		NSString *selImageName;
        NSString *title;
        if (i==0) {
            title = @"首页";
			imageName = @"首页gray";
			selImageName =@"首页blue";

        }else if(i==1){
            title = @"附近";
			imageName = @"附近gray";
			selImageName =@"附近blue";
        }else if(i==2){
            imageName = @"扫码";
            selImageName =@"扫码";
        }else if(i==3){
            title = @"接活";
			imageName = @"接活gray";
			selImageName =@"接活blue";
        }else if(i==4){
            title = @"我";
			imageName = @"我的gray";
			selImageName =@"我的blue";
        }
		DLog(@"btn===%f,%f",btn.frame.size.width,btn.frame.size.height);
        [btn setImage:LOADIMAGE(imageName,@"png") forState:UIControlStateNormal];
        [btn setImage:LOADIMAGE(selImageName,@"png") forState:UIControlStateSelected];
		
		
        btn.tag = i;
        if (i!=2) {
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize: 11.0];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setTitleColor:RGB(29, 173, 248) forState:UIControlStateSelected];
            [btn setTitleColor:RGB(128, 128, 128) forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
			btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
			UIImage *imagenow = LOADIMAGE(imageName,@"png");
			CGSize sizenow = imagenow.size;
			DLog(@"sizenow=====%f,%f",sizenow.width,sizenow.height);
			[btn setImageEdgeInsets:UIEdgeInsetsMake((btn.frame.size.height*0.8-sizenow.height)/2,(btn.frame.size.width -sizenow.width)/2, 0, 0)];
			btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        }


        
        if(i == 0){
            [self btnClick:btn];
        }
    }
}


-(void) btnClick:(UIButton *)button{
    if (button.tag!=2) {
        [self.delegate changeNav:_selectedBarButton.tag to:button.tag];
        _selectedBarButton.selected = NO;
        button.selected = YES;
        _selectedBarButton = (LCTabBarButton *)button;
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击了 %ld",buttonIndex);
    if (buttonIndex != 2) {
        //        ImageViewController *imageVC = [[ImageViewController alloc]init];
        LCTabBarController *tabVC = (LCTabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        //        [tabVC.selectedViewController.childViewControllers.lastObject  presentViewController:imageVC animated:YES completion:^{}];
        
        UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if([UIImagePickerController isSourceTypeAvailable:type]){
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                type = UIImagePickerControllerSourceTypeCamera;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = NO;
            picker.delegate   = self;
            picker.sourceType = type;
            
            [tabVC.selectedViewController.childViewControllers.lastObject  presentViewController:picker animated:YES completion:^{
                
            }];
        }
        
        
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"image  %@",image);
    }];
    
}

@end
