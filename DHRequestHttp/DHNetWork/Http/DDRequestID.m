//
//  DDRequestID.m
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDRequestID.h"

@implementation DDRequestID

- (void)setResultBlock:(void (^)(BOOL, id _Nonnull))resultBlock{
    _resultBlock = resultBlock;
}

- (void)dealloc{
    if (_resultBlock) {
        _resultBlock = nil;
    }
}
@end
