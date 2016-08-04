//
//  ViewController.m
//  SecondAFNetworking
//
//  Created by ma c on 16/8/4.
//  Copyright © 2016年 shifei. All rights reserved.
//

#import "ViewController.h"
#import "SFHttpTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *params = @{
                             @"username" : @"haha",
                             @"password" : @"123"
                             };
        // get请求
//    [self get:params];
    
    // post请求
//    [self post:params];
    
    // 下载
//    [self download];
    
    // 上传
    [self upload];
    
}


// get请求
- (void)get:(NSDictionary *)params {

    [SFHttpTools getWithPath:@"login.php" params:params success:^(id json) {
        NSLog(@"%@", json);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)post:(NSDictionary *)params {

    [SFHttpTools postWithPath:@"login.php" params:params success:^(id json) {
        NSLog(@"%@", json);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

// 下载
- (void)download {

    [SFHttpTools downloadWithPath:@"babeishang.mp3" success:^(id json) {
        NSLog(@"%@", json);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } progress:^(CGFloat progress) {
        NSLog(@"%f", progress);
    }];
}

// 上传
- (void)upload {
    
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    
    [SFHttpTools uploadIamgeWithPath:@"post/upload.php" params:nil thumImage:@"userfile00" image:image success:^(id json) {
        NSLog(@"%@", json);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } progress:^(CGFloat progress) {
        NSLog(@"%f", progress);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
