//
//  DDRequestID.h
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetworkConstants.h"
@class DDAPIContext;

typedef void (^ResultBlock)(BOOL isSuccess, id _Nullable object);

NS_ASSUME_NONNULL_BEGIN

@interface DDRequestID : NSObject
//! 请求的结果集
@property (nonatomic, copy) ResultBlock resultBlock;
//! 请求消息体
@property (nonatomic, strong) id responeObject;
//! 请求的原始信息，可以用来取消息一条请求
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
//! 请求对象
@property (nonatomic, strong) DDAPIContext *apiContext;

- (void)setResultBlock:(void (^) (BOOL isSuccess, id object))resultBlock;


@end

NS_ASSUME_NONNULL_END
