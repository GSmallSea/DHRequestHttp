//
//  DDAPIManager.h
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDHttpHelper.h"
#import "DDRequestID.h"
#import "DDAPIContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAPIManager : DDHttpHelper


/**
 把字典转成字符串&拼接

 @param params 字典
 @return 返回字符串
 */
+ (NSString *)apiManagerParamsToUrl:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
