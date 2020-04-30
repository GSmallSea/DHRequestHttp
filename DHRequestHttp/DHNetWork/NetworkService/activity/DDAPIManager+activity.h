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



/// 创建一个post请求
+ (DDRequestID *)apiManagerPost;


/// 创建一个body请求
+ (DDRequestID *)apiManagerBody;

@end

NS_ASSUME_NONNULL_END
