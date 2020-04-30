//
//  DDHttpHelper.h
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetworkConstants.h"

@class DDAPIContext;
@class DDRequestID;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

@interface DDHttpHelper : NSObject

+ (nullable instancetype)sharedManager;

+ (nonnull DDRequestID *)requestWithAPIContext:(nonnull DDAPIContext *)APIContext;

/// 取消当前的请求
/// @param requestID 标识
- (void)cancelWithRequestID:(DDRequestID *)requestID;


@end

NS_ASSUME_NONNULL_END
