//
//  DDAPIManager+activity.m
//  DingDongFM
//
//  Created by DD on 2019/5/24.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDAPIManager+activity.h"

@implementation DDAPIManager (activity)

+ (DDRequestID *)apiManagerActivityGetSubjectListWithTimeStamp:(NSString *)createtimestamp{
    NSString *url = @"";
    DDAPIContext *context = [DDAPIContext contextGetWithURLString:url parameterDict:nil];
    return [self requestWithAPIContext:context];
}

@end
