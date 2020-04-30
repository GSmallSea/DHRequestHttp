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


+ (DDRequestID *)apiManagerPost
{
    NSString *url = @"";
    DDAPIContext *context = [DDAPIContext contextPostWithURLString:url parameterDict:nil];
    return [self requestWithAPIContext:context];
}

+ (DDRequestID *)apiManagerBody{
    
    NSString *url = @"";
    DDAPIContext *context = [DDAPIContext contextWithMethodType:HttpRequestMothodTypeBody URLString:url parameterDict:nil isEncryption:YES isBasic:YES isToken:YES];
    return [self requestWithAPIContext:context];
}
@end
