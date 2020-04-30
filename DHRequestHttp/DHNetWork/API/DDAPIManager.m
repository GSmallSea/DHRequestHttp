//
//  DDAPIManager.m
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDAPIManager.h"

@implementation DDAPIManager


+ (NSString *)apiManagerParamsToUrl:(NSDictionary *)params{
    
    NSMutableString *bodyStr = [NSMutableString string];
    NSArray *bodyKeyArr = [params allKeys];
    for (int i = 0; i < bodyKeyArr.count; i++) {
        if (i == 0) {
            [bodyStr appendFormat:@"%@=%@",bodyKeyArr[i],params[bodyKeyArr[i]]];
        }else{
            [bodyStr appendFormat:@"&%@=%@",bodyKeyArr[i],params[bodyKeyArr[i]]];
        }
    }
    return bodyStr;
}


@end

