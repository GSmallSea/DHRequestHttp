//
//  DHHeader.h
//  DHRequestHttp
//
//  Created by DD on 2020/4/30.
//  Copyright © 2020 DD. All rights reserved.
//

#ifndef DHHeader_h
#define DHHeader_h


#ifdef DEBUG
#   define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DDLog(...) (void)0;
#endif


#define weakify(var) __weak typeof(var) XYWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = XYWeak_##var; \
_Pragma("clang diagnostic pop")



// 自己配置
#define ClientId                            @"admin"
#define ClientSecret                        @"admin"


#define WEAKSELF typeof(self) __block weakSelf = self;

#define dKeyWindow         [[UIApplication sharedApplication] keyWindow]

#import "MBProgressHUD+Add.h"
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "AFNetworking.h"

#endif /* DHHeader_h */
