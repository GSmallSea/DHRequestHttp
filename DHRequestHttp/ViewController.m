//
//  ViewController.m
//  DHRequestHttp
//
//  Created by DD on 2020/4/30.
//  Copyright © 2020 DD. All rights reserved.
//

#import "ViewController.h"
#import "DDAPIManager+activity.h"
@interface ViewController ()

@property (nonatomic,strong) DDRequestID *request;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[DDAPIManager apiManagerActivityGetSubjectListWithTimeStamp:@""] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
        // 请求成功
        if (isSuccess) {
            
        }else{
            // 请求失败
        }
    }];
    // 模拟一个post 请求
    [[DDAPIManager apiManagerPost] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
        if (isSuccess) {
            
        }else{
            
        }
    }];
    
    // 模拟一个body 请求
    [[DDAPIManager apiManagerBody] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
        if (isSuccess) {
            
        }else{
            
        }
    }];
    
    

    // 创建一个请求
    self.request = [DDAPIManager apiManagerBody];
    [self.request setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
        if (isSuccess) {
            
        }else{
            
        }
    }];
    
    // 取消当前请求
    [[DDAPIManager sharedManager] cancelWithRequestID:self.request];
    
    
}


@end
