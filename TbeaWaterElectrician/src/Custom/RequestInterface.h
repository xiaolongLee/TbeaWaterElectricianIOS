//
//  RequestInterface.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestInterface : NSObject

+(AFHTTPSessionManager *)getHTTPManager;
+(AppDelegate *)getAppdelegate;
+(void)doGetJsonWithParameters:(NSDictionary * )parameters ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;
+(void)doGetJsonWithArraypic:(NSArray * )arrayimage Parameters:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;
+(void)doGetJsonWithArrayvideo:(NSString * )videopath Parameter:(NSDictionary * )parameters ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;
+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;
+(void)doGetJsonWithParametersNoAn1:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;

+(void)doGetJsonWithParametersNoAntbea:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success;
@end
