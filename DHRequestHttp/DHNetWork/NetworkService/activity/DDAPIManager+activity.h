//
//  DDAPIManager+activity.h
//  DingDongFM
//
//  Created by DD on 2019/5/24.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAPIManager (activity)

/**
 获取专题列表

 @param createtimestamp 创建时间戳
 @auth                DH
 @date                2019-05-20
 @return 返回一个DDRequestID对象
 */
+ (DDRequestID *)apiManagerActivityGetSubjectListWithTimeStamp:(NSString *)createtimestamp;

@end

NS_ASSUME_NONNULL_END
