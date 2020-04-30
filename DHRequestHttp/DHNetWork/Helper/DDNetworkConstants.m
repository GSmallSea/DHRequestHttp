//
//  DDNetworkConstants.m
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//


NSString * const kNetworkAppStoreENVDomain = @"https://www.baidu.cn";
NSString * const kNetworkDevelopENVDomain = @"https://www.baidu.cn";

NSString *ServerBaseURL() {
    NSString *baseUrlString = kNetworkDevelopENVDomain;
#if (kIsAppStoreENV == 2)
    baseUrlString = kNetworkAppStoreENVDomain;
#endif
    return baseUrlString;
}




#define wc_force_inline __inline__ __attribute__((always_inline))


extern wc_force_inline void DD_dispatch_main_sync_safe(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

extern wc_force_inline void DD_dispatch_main_async_safe(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

extern wc_force_inline void DD_dispatch_global_async_if_need(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    } else {
        block();
    }
}

extern wc_force_inline void DD_dispatch_global_then_dispatch_main_queue(dispatch_block_t global_block, dispatch_block_t main_block) {
    DD_dispatch_global_async_if_need(^{
        global_block();
        DD_dispatch_main_async_safe(main_block);
    });
}
