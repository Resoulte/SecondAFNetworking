//
//  SFHttpTools.m
//  SecondAFNetworking
//
//  Created by ma c on 16/8/4.
//  Copyright © 2016年 shifei. All rights reserved.
//

#import "SFHttpTools.h"
#import <AFNetworking.h>

static NSString *kBaseUrl = @"http://192.168.1.54/";
@interface AFHTTPClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
static AFHTTPClient *client = nil;
@implementation AFHTTPClient

+ (instancetype)sharedClient {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        // 接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //  安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return client;
}


@end

@implementation SFHttpTools

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure {
    
    // 获取完整的路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHTTPClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure {
    
    // 获取完整的路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHTTPClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure progress:(HttpDownloadProgressBlock)progress {

    // 获取完整的路径
    NSString *url = [kBaseUrl stringByAppendingString:path];
    
    NSURL *URL = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHTTPClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 进度的分数
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * cachesDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [cachesDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
}

+ (void)uploadIamgeWithPath:(NSString *)path params:(NSDictionary *)params thumImage:(NSString *)imageKey image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailedBlock)failure progress:(HttpUploadProgressBlock)progress {

    // 获取完整路径
    NSString *url = [kBaseUrl stringByAppendingString:path];

    NSData *data = UIImagePNGRepresentation(image);
    
    [[AFHTTPClient sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
