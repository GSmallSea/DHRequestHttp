//
//  DDNetworkConstants.h
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//
typedef NS_ENUM(NSInteger,HttpRequestMothodType) {
    HttpRequestMothodTypeGet,
    HttpRequestMothodTypePost,
    HttpRequestMothodTypePut,
    /** body 请求 */
    HttpRequestMothodTypeBody,
    
};
typedef NSURLSessionDataTask DDURLSessionDataTask;


#define DD_API_URL(_URL) [NSString stringWithFormat:@"%@%@",ServerBaseURL(),_URL];

/** 正式环境 */
extern NSString * const kNetworkAppStoreENVDomain;
/** 测试环境 */
extern NSString * const kNetworkDevelopENVDomain;
/** 获取请求地址 */
extern NSString *ServerBaseURL(void);


#pragma mark - 全局内联函数 --by dh
extern void DD_dispatch_main_sync_safe(dispatch_block_t block);
extern void DD_dispatch_main_async_safe(dispatch_block_t block);
extern void DD_dispatch_global_async_if_need(dispatch_block_t block);
extern void DD_dispatch_global_then_dispatch_main_queue(dispatch_block_t global_block, dispatch_block_t main_block);
