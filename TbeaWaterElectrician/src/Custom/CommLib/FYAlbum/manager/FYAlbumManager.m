//
//  FYAlbumManager.m
//  FYAlbumDemo
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "FYAlbumManager.h"
#import "FYPhotoCollectionsViewController.h"
#import "FadeOutView.h"


@implementation FYAlbumManager

+ (instancetype)shareAlbumManager{
    static FYAlbumManager * albumManager ;
    if (albumManager) {
        return albumManager;
    }
    albumManager =[[FYAlbumManager alloc]init];
    return albumManager;
}
- (void)showInView:(UIViewController *)view Photo:(NSString *)photoflag{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
    UIAlertAction * action=[ UIAlertAction  actionWithTitle:@"拍照"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
														
															NSLog(@"相机");
															if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
																UIImagePickerController * picker=[[UIImagePickerController alloc]init];
																picker.sourceType = UIImagePickerControllerSourceTypeCamera;
																picker.allowsEditing = NO;
																picker .delegate = self;
																[view presentViewController:picker animated:YES completion:nil];
															} else {
																showFadeOutView(@"相机不可用哦", NO, 1);
															}
														
														
														
                                                    }];
	
    UIAlertAction * action2=[ UIAlertAction  actionWithTitle:@"相册"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
														

															NSLog(@"相机");
															FYPhotoCollectionsViewController * collection =[[FYPhotoCollectionsViewController alloc]init];
															collection.maxSelected = self.maxSelect;
															UINavigationController * na=[[UINavigationController alloc]initWithRootViewController:collection];
															collection.complate = ^(NSArray * array)
															{
																self.complate?self.complate(array):nil;
															};
															[view presentViewController:na animated:YES completion:nil];
														
														
                                                    }];
	
    UIAlertAction * action3=[ UIAlertAction  actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                          
                                                     }];

    [alert addAction:action];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [view presentViewController:alert animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
	viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

#pragma mark - pickdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIImage * image =info[@"UIImagePickerControllerOriginalImage"];
	NSLog(@"info====%@",info);
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	[dic setObject:[AddInterface returnnowdate] forKey:@"localid"];
	[dic setObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"] forKey:@"result"];

    self.complate?self.complate(@[dic]):nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
