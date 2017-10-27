//
//  RequestInterface.m
//  CcwbNews
//
//  Created by xyy520 on 16/5/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "RequestInterface.h"

@implementation RequestInterface

//获取普通管理器
+(AFHTTPSessionManager *)getHTTPManager{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer.timeoutInterval = 10.0f;
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	return manager;
}

+(AppDelegate *)getAppdelegate
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	return app;
}

//特变测试
+(void)doGetJsonWithParametersNoAntbea:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	
	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
	animationView.delegate = self;
	[app.window addSubview:animationView];
	[animationView startAnimating];
	
	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"OrigDomain"];
	[manager.requestSerializer setValue:@"tbea_v1" forHTTPHeaderField:@"ProtocolVer"];
	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"AppVersion"];
	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"ActionCode"];
	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"ServiceCode"];
	[manager.requestSerializer setValue:@"jorhzs1435310383empeya" forHTTPHeaderField:@"UserId"];
	[manager.requestSerializer setValue:@"" forHTTPHeaderField:@"CityId"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.longitude] forHTTPHeaderField:@"longitude"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.latitude] forHTTPHeaderField:@"latitude"];
	
	
	[manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
		 DLog(@"result====%@",result);
		 
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];
		 
	 }
		  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	 {
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
		 
	 }];
}

//普通 接口没有请求动画效果的
+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	
	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
	animationView.delegate = self;
	[app.window addSubview:animationView];
	[animationView startAnimating];
	
	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
	[manager.requestSerializer setValue:@"tbeaeng_v1" forHTTPHeaderField:@"protocolver"];
	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
	[manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.longitude] forHTTPHeaderField:@"longitude"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.latitude] forHTTPHeaderField:@"latitude"];
	
	
	[manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];

	 }
		  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	 {
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];

	 }];
}


//普通 接口没有请求不带动画效果的
+(void)doGetJsonWithParametersNoAn1:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	

	
	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
	[manager.requestSerializer setValue:@"tbeaeng_v1" forHTTPHeaderField:@"protocolver"];
	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
	[manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.longitude] forHTTPHeaderField:@"longitude"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.latitude] forHTTPHeaderField:@"latitude"];
	
	
	[manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 
	 }
		  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	 {

		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
		 
	 }];
}

//普通接口请求
+(void)doGetJsonWithParameters:(NSDictionary * )parameters ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	AppDelegate *app =  [RequestInterface getAppdelegate];
	
	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
	animationView.delegate = self;
	[app.window addSubview:animationView];
	[animationView startAnimating];

	
	UIView *viewalpha = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	viewalpha.backgroundColor = [UIColor clearColor];
	viewalpha.tag = 30071;
	[app.window addSubview:viewalpha];
	
	[manager POST:[URLHeader stringByAppendingString:requrl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	{
	 
	}
	success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	{
		 if(always){
			 always();
		 }
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 [[app.window viewWithTag:30071] removeFromSuperview];
		[animationView stopAnimating:YES];
		[animationView removeFromSuperview];
	}
	failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	{
		[animationView stopAnimating:YES];
		[animationView removeFromSuperview];
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
		[[app.window viewWithTag:30071] removeFromSuperview];
	}];
}

//上传图片接口
+(void)doGetJsonWithArraypic:(NSArray * )arrayimage Parameters:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
	[manager.requestSerializer setValue:@"tbeaeng_v1" forHTTPHeaderField:@"protocolver"];
	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
	[manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.longitude] forHTTPHeaderField:@"longitude"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.latitude] forHTTPHeaderField:@"latitude"];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	
	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
	animationView.delegate = self;
	[app.window addSubview:animationView];
	[animationView startAnimating];
	
	[manager POST:requrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		
		for (int i=0;i<[arrayimage count];i++)
		{
			NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i];
			NSData *imageData;
			UIImage *image = [arrayimage objectAtIndex:i];//LOADIMAGE(@"testpic", @"jpg");
			imageData = UIImageJPEGRepresentation(image, 0.5f);
			if(i==0)
				[formData appendPartWithFileData:imageData name:@"personidcard1" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
			if(i==1)
				[formData appendPartWithFileData:imageData name:@"personidcard2" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
			if(i==2)
				[formData appendPartWithFileData:imageData name:@"personidcardwithperson" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
		}
	} progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		success(jsonvalue);
		NSLog(@"responseObject = %@, task = %@",responseObject,task);
		[animationView stopAnimating:YES];
		[animationView removeFromSuperview];

		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[animationView stopAnimating:YES];
		[animationView removeFromSuperview];
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	}];
	
	
	
	
	
//	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
//	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
//	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
//	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
//	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
//	animationView.delegate = self;
//	[app.window addSubview:animationView];
//	[animationView startAnimating];
//	
//	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
//	[manager.requestSerializer setValue:@"tbeaeng_v1" forHTTPHeaderField:@"protocolver"];
//	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
//	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
//	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
//	[manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
//	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.latitude] forHTTPHeaderField:@"longitude"];
//	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.dili.longitude] forHTTPHeaderField:@"latitude"];
//	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//	[manager POST:requrl parameters:parameters constructingBodyWithBlock:^(id  _Nonnull formData) {
//		//对于图片进行压缩
////		for(int i=0;i<[arrayimage count];i++)
////		{
//			UIImage *image = LOADIMAGE(@"testpic", @"jpg");//[arrayimage objectAtIndex:i];
//			NSData *data = UIImageJPEGRepresentation(image, 0.1);//压缩比例
////			if(i==0)
//				[formData appendPartWithFileData:data name:@"personidcard1" fileName:@"personidcard1" mimeType:@"image/jpg/png/jpeg"];
////			if(i==1)
////				[formData appendPartWithFileData:data name:@"personidcard2" fileName:@"personidcard2" mimeType:@"image/jpg/png/jpeg"];
////			if(i==2)
////				[formData appendPartWithFileData:data name:@"personidcardwithperson" fileName:@"personidcardwithperson" mimeType:@"image/jpg/png/jpeg"];
////		}
//	}
//	 progress:^(NSProgress * _Nonnull uploadProgress)
//	{
//		if(always)
//		{
//			always();
//		}
//
//	}
//	success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//	{
//		if(always){
//			always();
//		}
//		NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//		success(jsonvalue);
//		NSLog(@"responseObject = %@, task = %@",responseObject,task);
//		[animationView stopAnimating:YES];
//		[animationView removeFromSuperview];
//		
//	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//		if(always)
//		{
//			always();
//		}
//		NSLog(@"error = %@",error);
//		[animationView stopAnimating:YES];
//		[animationView removeFromSuperview];
//		[MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
//	}];
//	
	
}




//上传视频接口
+(void)doGetJsonWithArrayvideo:(NSString * )videopath Parameter:(NSDictionary * )parameters ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
//	AppDelegate *app =  [RequestInterface getAppdelegate];
	
	
	[manager POST:requrl parameters:parameters constructingBodyWithBlock:^(id  _Nonnull formData) {
		//对于图片进行压缩
		
		
		NSURL *url = [NSURL fileURLWithPath:videopath];
//		NSError *theErro = nil;
//		BOOL exportResult = [asset exportDataToURL:url error:&theErro];
//		NSLog(@"exportResult=%@", exportResult?@"YES":@"NO");
		
		NSData *videoData = [NSData dataWithContentsOfURL:url];
		[formData appendPartWithFileData:videoData name:@"file" fileName:@"video1.mp4" mimeType:@"video/quicktime"];
	}
		 progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 if(always)
		 {
			 always();
		 }
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 NSLog(@"responseObject = %@, task = %@",responseObject,task);
		 
	
		 
	 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		 if(always)
		 {
			 always();
		 }
		 NSLog(@"error = %@",error);
		
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	 }];
	
	
}


@end
