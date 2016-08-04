//
//  SFHttpTools.h
//  SecondAFNetworking
//
//  Created by ma c on 16/8/4.
//  Copyright © 2016年 shifei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HttpSuccessBlock)(id json);
typedef void(^HttpFailedBlock)(NSError *error);
typedef void(^HttpDownloadProgressBlock)(CGFloat progress);
typedef void(^HttpUploadProgressBlock)(CGFloat progress);

@interface SFHttpTools : NSObject

/**
 *  get网络请求
 *
 *  @param path    请求路径
 *  @param params  url参数 NSDictinory类型
 *  @param success 请求成功 返回NSDictinory 或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure;

/**
 *  post网络请求
 *
 *  @param path    请求路径
 *  @param params  url参数 NSDictinory类型
 *  @param success 请求成功 返回NSDictinory 或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure;

/**
 *  下载文件
 *
 *  @param path     下载路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure progress:(HttpDownloadProgressBlock)progress;

/**
 *  上传图片
 *
 *  @param path     上传路径
 *  @param params   上传参数
 *  @param imageKey 关键字
 *  @param image    上传的图片
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadIamgeWithPath:(NSString *)path params:(NSDictionary *)params thumImage:(NSString *)imageKey image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure progress:(HttpUploadProgressBlock)progress;
@end
