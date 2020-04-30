//
//  DDAPIContext.m
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDAPIContext.h"

@implementation DDAPIContext


+ (instancetype)contextGetWithURLString:(NSString *)URLString
                          parameterDict:(NSDictionary *)parameterDict
                                isBasic:(BOOL)isBasic{
    return [self contextWithMethodType:HttpRequestMothodTypeGet
                             URLString:URLString
                         parameterDict:parameterDict
                          isEncryption:YES
                               isBasic:YES
                               isToken:NO];
}

+ (instancetype)contextGetWithURLString:(NSString *)URLString
                          parameterDict:(NSDictionary *)parameterDict{
    return [self contextWithMethodType:HttpRequestMothodTypeGet
                              URLString:URLString
                          parameterDict:parameterDict
                           isEncryption:YES
                                isBasic:NO
                               isToken:YES];
}

+ (instancetype)contextGetWithURLString:(NSString *)URLString
                          parameterDict:(NSDictionary *)parameterDict
                            isDecodeUrl:(BOOL)isDecodeUrl{
    
    return [[self alloc] initContextWithMethodType:HttpRequestMothodTypeGet
                                         URLString:URLString
                                     parameterDict:parameterDict
                                      isEncryption:YES
                                           isBasic:NO
                                           isToken:YES
                                    isRefreshToken:NO
                                       isDecodeUrl:isDecodeUrl];
}

+ (instancetype)contextPostWithURLString:(NSString *)URLString
                           parameterDict:(NSDictionary *)parameterDict
                                 isBasic:(BOOL)isBasic{
    return [self contextWithMethodType:HttpRequestMothodTypePost
                             URLString:URLString
                         parameterDict:parameterDict
                          isEncryption:YES
                               isBasic:isBasic
                               isToken:NO];
}

+ (instancetype)contextPostWithURLString:(NSString *)URLString
                       parameterDict:(NSDictionary *)parameterDict{
    
    return [self contextWithMethodType:HttpRequestMothodTypePost
                             URLString:URLString
                         parameterDict:parameterDict
                          isEncryption:YES
                               isBasic:NO
                               isToken:YES];
}

+ (instancetype)contextWithMethodType:(HttpRequestMothodType)methodType
                            URLString:(NSString *)URLString
                        parameterDict:(NSDictionary *)parameterDict
                         isEncryption:(BOOL)isEncryption
                              isBasic:(BOOL)isBasic
                              isToken:(BOOL)isToken
{
    return [self contextWithMethodType:methodType
                             URLString:URLString
                         parameterDict:parameterDict
                          isEncryption:isEncryption
                               isBasic:isBasic
                               isToken:isToken
                        isRefreshToken:NO];
}


+ (instancetype)contextWithMethodType:(HttpRequestMothodType)methodType
                            URLString:(NSString *)URLString
                        parameterDict:(NSDictionary *)parameterDict
                         isEncryption:(BOOL)isEncryption
                              isBasic:(BOOL)isBasic
                              isToken:(BOOL)isToken
                       isRefreshToken:(BOOL)isRefreshToken
{
    
    return [[self alloc] initContextWithMethodType:methodType
                                         URLString:URLString
                                     parameterDict:parameterDict
                                      isEncryption:isEncryption
                                           isBasic:isBasic
                                           isToken:isToken
                                    isRefreshToken:isRefreshToken
                                       isDecodeUrl:NO];
    
}

- (instancetype)initContextWithMethodType:(HttpRequestMothodType)methodType
                                URLString:(NSString *)URLString
                            parameterDict:(NSDictionary *)parameterDict
                             isEncryption:(BOOL)isEncryption
                                  isBasic:(BOOL)isBasic
                                  isToken:(BOOL)isToken
                           isRefreshToken:(BOOL)isRefreshToken
                              isDecodeUrl:(BOOL)isDecodeUrl
{
    if (self = [super init]) {
        _methodType    = methodType;
        _URLString     = URLString;
        _parameterDict = parameterDict;
        _Encryption    = isEncryption;
        _Basic         = isBasic;
        _token         = isToken;
        _refreshToken  = isRefreshToken;
        _recodeUrl     = isDecodeUrl;
    }
    return self;
}
@end
