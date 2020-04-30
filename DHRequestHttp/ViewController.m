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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[DDAPIManager  apiManagerActivityGetSubjectListWithTimeStamp:@""] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
        // 请求成功
        if (isSuccess) {
            
        }else{
            // 请求失败
        }
    }];
}


@end
