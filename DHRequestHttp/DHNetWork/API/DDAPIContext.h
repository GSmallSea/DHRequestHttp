//
//  DDAPIContext.h
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetworkConstants.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDAPIContext : NSObject
//! http请求的方法，如get post,是个枚举
@property (nonatomic, assign, readonly) HttpRequestMothodType methodType;
//! 除域名以外的请求ulr 如 /httpHeader/Webservice/authURL
@property (nonatomic, strong, readonly, nonnull) NSString *URLString;
//! 接口请求的参数
@property (nonatomic, strong, readonly, nullable) NSDictionary *parameterDict;
//! 加密选项
@property (nonatomic, assign, readonly,getter = isEncryption) BOOL Encryption;
//! basic 认证
@property (nonatomic, assign, readonly,getter = isBasic) BOOL Basic;
//! token 认证
@property (nonatomic, assign, readonly,getter = isToken) BOOL token;
//! refreshToken 是否是刷新token的接口、只调用一次、请求失败的话退出、重新登录
@property (nonatomic, assign, readonly,getter = isRefreshToken) BOOL refreshToken;
//! isDecodeUrl 是否需要解码
@property (nonatomic, assign, readonly,getter = isDecodeUrl) BOOL recodeUrl;

/**
 网络请求POST方法、不需要Basic、需要token验证、
 
 @auth                DH
 @date                2019-05-20
 @param URLString     请求ulr，
 @param parameterDict 除去token外的用户请求字典
 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextPostWithURLString:(nonnull NSString *)URLString
                                   parameterDict:(nullable NSDictionary *)parameterDict;

/**
  网络请求POST方法、需要Basic、不需要Token

 @auth                DH
 @date                2019-05-20
 @param URLString     请求ulr
 @param parameterDict 除去token外的用户请求字典
 @param isBasic       是否进行basic认证
 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextPostWithURLString:(nonnull NSString *)URLString
                                   parameterDict:(nullable NSDictionary *)parameterDict
                                         isBasic:(BOOL)isBasic;

/**
 网络请求Get方法、不需要Basic、需要token验证、

 @auth                DH
 @date                2019-05-20
 @param URLString     请求ulr
 @param parameterDict 除去token外的用户请求字典
 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextGetWithURLString:(nonnull NSString *)URLString
                                  parameterDict:(nullable NSDictionary *)parameterDict;


/**
 网络请求Get方法、需要Basic、不需要token验证、
 
 @auth                DH
 @date                2019-05-20
 @param URLString     请求ulr
 @param parameterDict 除去token外的用户请求字典
 @param isBasic       是否进行basic认证
 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextGetWithURLString:(nonnull NSString *)URLString
                                  parameterDict:(nullable NSDictionary *)parameterDict
                                        isBasic:(BOOL)isBasic;


/**
 网络请求Get方法、不需要Basic、需要token验证、
 
 @auth                DH
 @date                2019-09-06
 @param URLString     请求ulr
 @param parameterDict 除去token外的用户请求字典
 @param isDecodeUrl   是否需要解码

 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextGetWithURLString:(nonnull NSString *)URLString
                                  parameterDict:(nullable NSDictionary *)parameterDict
                                    isDecodeUrl:(BOOL)isDecodeUrl;


/**
 通过网络请求方法、参数的配置:
 
 @auth                DH
 @date                2019-05-20
 @param methodType    网络请求类型，是个枚举
 @param URLString     除域名以外的请求ulr，
 @param parameterDict 除去token外的用户请求字典
 @param isEncryption  是否加密
 @param isBasic       是否进行basic认证
 @param isToken       是否进行token认证
 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextWithMethodType:(HttpRequestMothodType)methodType
                                    URLString:(nonnull NSString *)URLString
                                parameterDict:(nullable NSDictionary *)parameterDict
                                 isEncryption:(BOOL)isEncryption
                                      isBasic:(BOOL)isBasic
                                      isToken:(BOOL)isToken;

/**
 通过网络请求方法、参数的配置:
 
 @auth                  DH
 @date                  2019-05-20
 @param methodType      网络请求类型，是个枚举
 @param URLString       除域名以外的请求ulr，
 @param parameterDict   除去token外的用户请求字典
 @param isEncryption    是否加密
 @param isBasic         是否进行basic认证
 @param isToken         是否进行token认证
 @param isRefreshToken  是否刷新token

 @return 返回一个DDAPIContext实例对象
 */
+ (nonnull instancetype)contextWithMethodType:(HttpRequestMothodType)methodType
                                    URLString:(nonnull NSString *)URLString
                                parameterDict:(nullable NSDictionary *)parameterDict
                                 isEncryption:(BOOL)isEncryption
                                      isBasic:(BOOL)isBasic
                                      isToken:(BOOL)isToken
                               isRefreshToken:(BOOL)isRefreshToken;

@end

NS_ASSUME_NONNULL_END
