//
//  DDHttpHelper.m
//  DingDongFM
//
//  Created by DD on 2019/5/20.
//  Copyright © 2019 Pansoft. All rights reserved.
//

#import "DDHttpHelper.h"
#import <AFNetworking/AFNetworking.h>
#import "DDAPIContext.h"
#import "DDRequestID.h"

static const NSTimeInterval kRequestTimeout = 30.0f;

@interface DDHttpHelper ()
{
    /** 串行队列 */
    dispatch_queue_t    _requestQueue;
    NSLock              *_requestLock;
    NSMutableArray      *_dataTaskArray;

}
@property (nonatomic, strong, nonnull) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong, nonnull) NSCache *cache;
@end

@implementation DDHttpHelper
- (void)dealloc {
    [self cancelAllRequest];
    if (_requestQueue) {
        _requestQueue = nil;
    }
}

+ (instancetype)sharedManager{
    static DDHttpHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [[self new] initData];
    });
    return _instance;
}
- (NSCache *)cache{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 1;

    }
    return _cache;
}
- (void)initData {
    _dataTaskArray = [NSMutableArray array];
    _requestLock = [NSLock new];
}
+ (DDRequestID *)requestWithAPIContext:(DDAPIContext *)APIContext{
    return [[self sharedManager] requestWithAPIContext:APIContext];
}

- (DDRequestID *)requestWithAPIContext:(DDAPIContext *)APIContext{
    
    AFHTTPSessionManager *sessionManager = self.sessionManager;

    if (APIContext.methodType == HttpRequestMothodTypePost ||
        APIContext.methodType == HttpRequestMothodTypeGet){
     
        /// 设置请求加密
        [self setHeaderRequestConfigs:APIContext sessionManager:sessionManager];
    }
    
    DDRequestID *requestID = [[DDRequestID alloc] init];
    
    if (APIContext.methodType == HttpRequestMothodTypePost){
        return [self requestPOSTWithAPIContext:APIContext sessionManager:sessionManager requestID:requestID];
    }else if (APIContext.methodType == HttpRequestMothodTypeGet){
        return [self requestGETWithAPIContext:APIContext sessionManager:sessionManager requestID:requestID];
    }else if (APIContext.methodType == HttpRequestMothodTypeBody){
        return [self requestBodyWithAPIContext:APIContext requestID:requestID];
    }else{
        NSAssert(NO, @"类型不正确");
        return requestID;
    }
}

/// 设置请求ID->POST请求
/// @param APIContext 请求上下文
/// @param sessionManager 请求
/// @param requestID 请求ID
- (DDRequestID *)requestPOSTWithAPIContext:(DDAPIContext *)APIContext
                            sessionManager:(AFHTTPSessionManager *)sessionManager
                                 requestID:(DDRequestID *)requestID{
    weakify(self)
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [sessionManager POST:APIContext.URLString
                         parameters:APIContext.parameterDict
                           progress:^(NSProgress * _Nonnull uploadProgress) {
                               
                           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               strongify(self)
                               requestID.responeObject = responseObject;
                               [self requestFinished:responseObject requestID:requestID];
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               strongify(self)
                               [self requestFailedWithErrorObject:error requestID:requestID];
                           }];
    
    [self setRequestWithID:requestID DataTask:dataTask APIContext:APIContext];

    // 8、请求
    [sessionManager.operationQueue addOperationWithBlock:^{
        [dataTask resume];
    }];

    return requestID;
    
}

/// 设置请求ID->GET请求
/// @param APIContext 请求上下文
/// @param sessionManager 请求
/// @param requestID 请求ID
- (DDRequestID *)requestGETWithAPIContext:(DDAPIContext *)APIContext
                           sessionManager:(AFHTTPSessionManager *)sessionManager
                                requestID:(DDRequestID *)requestID{
    
    __block NSURLSessionDataTask *dataTask = nil;
    weakify(self)
    dataTask = [sessionManager GET:APIContext.URLString
                         parameters:APIContext.parameterDict
                           progress:^(NSProgress * _Nonnull uploadProgress) {
                               
                           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               strongify(self)
                               requestID.responeObject = responseObject;
                               [self requestFinished:responseObject requestID:requestID];
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               strongify(self)
                               [self requestFailedWithErrorObject:error requestID:requestID];
                           }];
    [self setRequestWithID:requestID DataTask:dataTask APIContext:APIContext];

    [sessionManager.operationQueue addOperationWithBlock:^{
        [dataTask resume];
    }];
    // 8、请求
    return requestID;
}


/// 设置请求ID->body请求
/// @param APIContext 请求上下文
/// @param requestID 请求体
- (DDRequestID *)requestBodyWithAPIContext:(DDAPIContext *)APIContext
                                 requestID:(DDRequestID *)requestID{

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:APIContext.URLString parameters:APIContext.parameterDict error:nil];
    
    [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            
    // 1 isBasic、认证  isToken 认证
    if (APIContext.isBasic) {

    }else if (APIContext.isToken){

    }
     //2 加密参数
    if (APIContext.isEncryption) {

    }
    __block NSURLSessionDataTask *dataTask = nil;
    weakify(self)
    dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        strongify(self)
        DDLog(@"responseObject%@",responseObject);
        if (!error) { // 成功
            [self requestFinished:responseObject requestID:requestID];
        }else{ // 失败
            [self requestFailedWithErrorObject:error requestID:requestID];
        }
    }];
    
    [self setRequestWithID:requestID DataTask:dataTask APIContext:APIContext];
    
     [manager.operationQueue addOperationWithBlock:^{
         [dataTask resume];
     }];

     //8、将结果标识返回
     return requestID;
}

#pragma mark  请求完成执行的方法，包括成功或失败
- (void)requestFinished:(id)responseObject requestID:(DDRequestID *)requestID {
    if (_requestQueue == nil) {
        _requestQueue = dispatch_queue_create("httpQueue", nil);
    }
    __block __weak typeof(self) weakSelf = self;
    dispatch_async(_requestQueue, ^{
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            //检查网络请求是否成功
            id dict = [weakSelf checkIsSuccess:responseObject];
            if (nil == dict) { // 成功
                //进行数据解析
                id result =  [weakSelf analysisProtocol:responseObject requestID:requestID];
                //通知处理结果
                [weakSelf notitfySuccessWithResponseObject:result requestID:requestID];
            } else { // 失败
                [weakSelf notifyErrorObject:dict requestID:requestID];
            }
        }
        //取消请求操作
        [weakSelf cancelWithRequestID:requestID];
    });
}
#pragma mark 请求失败执行的方法
- (void)requestFailedWithErrorObject:(NSError *)errorObject requestID:(DDRequestID *)requestID{
    //将数据返回给block
    weakify(self)
    DD_dispatch_main_async_safe(^{
        strongify(self)
        if (requestID.resultBlock) {
            [self requestFailedRefrehsTokenWithErrorObject:errorObject requestID:requestID];
        }
        //取消请求操作
        [self cancelWithRequestID:requestID];
    });
}
#pragma mark - 请求失败、刷新token
- (void)requestFailedRefrehsTokenWithErrorObject:(NSError *)errorObject requestID:(DDRequestID *)requestID{
    
    //TODO 可以做
    requestID.resultBlock(NO,@"网络不好");
}
#pragma mark - 成功的回调
- (void)notitfySuccessWithResponseObject:(id)responseObject requestID:(DDRequestID *)requestID{
    DD_dispatch_main_async_safe(^{
        //将数据返回给block
        if (requestID.resultBlock) {
            requestID.resultBlock(YES,responseObject);
        }
    });
}
#pragma mark - 失败的回调
- (void)notifyErrorObject:(NSDictionary *)errorObject requestID:(DDRequestID *)requestID{
    
    DD_dispatch_main_async_safe(^{
        //将数据返回给block
        if (requestID.resultBlock) {
            requestID.resultBlock(NO,errorObject);
        }
    });
}
#pragma mark - 统一处理错误码
- (NSDictionary *) checkIsSuccess:(NSDictionary *)dict{
    @autoreleasepool {
        if ([[dict objectForKey:@"resultcode"] intValue] == 0) {
            return nil;
        }else{
            [self errorTipDict:dict];
            return dict;
        }
    }
}
#pragma mark - 业务接口请求成功之后resultcode != 0 的错误
- (void)errorTipDict:(NSDictionary *)dict{
    @autoreleasepool {
        DDLog(@"%@",dict);
    }
}
#pragma mark - 数据解析
- (id)analysisProtocol:(NSDictionary *)dict requestID:(DDRequestID *)requestID{
    @autoreleasepool {
        if ([[dict objectForKey:@"resultcode"] intValue] == 0) {
            return dict[@"data"];
        }else{
            return dict[@"message"];
        }
    }
}

#pragma mark - -------------- LAZY
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        
        //0、判断业务环境是正式，还是测试
        
        // 1.创建http请求对象
        _sessionManager = [AFHTTPSessionManager manager];
                
        //1.0设置请求和返回格式
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //1.1设置超时时间
        _sessionManager.requestSerializer.timeoutInterval = kRequestTimeout;
        
        //1.2设置可接受的JSON类型
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                                     @"application/json",
                                                                     @"text/json",
                                                                     @"text/javascript", nil];
        //1.3 去调验证
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        policy.allowInvalidCertificates = YES;//客户端是否信任非法证书
//        policy.validatesDomainName = NO;//是否在证书域字段中验证域名
//        _sessionManager.securityPolicy = policy;
    }
    return _sessionManager;
}

/// 设置加密方式、以及token 、Authorization
/// @param APIContext 请求上下文
/// @param sessionManager 请求
- (AFHTTPSessionManager *)setHeaderRequestConfigs:(DDAPIContext *)APIContext
                                   sessionManager:(AFHTTPSessionManager *)sessionManager{

    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    //1 basic 认证
    if (APIContext.isBasic) { // 需要进行 basic 认证
        [sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:ClientId password:ClientSecret];
    }
    //2 需要进行Token 认证
    if (APIContext.isToken) {
        [headers setObject:@"" forKey:@""];
    }
    //3 加密 head请求中添加3个请求参数 自己的加密算法
    if (APIContext.isEncryption) {
        [headers setObject:@"" forKey:@""];
    }
    
    for (NSString *headerField in headers.keyEnumerator) {
           [sessionManager.requestSerializer setValue:headers[headerField] forHTTPHeaderField:headerField];
    }
    return sessionManager;
}


/// 把请求体放在数组中，用于取消单个请求
/// @param requestID 某一个请求
/// @param task 任务
/// @param APIContext 请求上下文
- (void)setRequestWithID:(DDRequestID *)requestID
                DataTask:(NSURLSessionDataTask *)task
              APIContext:(DDAPIContext *)APIContext{
    
    //0 请求任务
    requestID.dataTask = task;
    //1 请求对象
    requestID.apiContext = APIContext;
    //2 添加到队列中,准备执行
    [self addRequestID:requestID];
}

- (void)cancelWithRequestID:(DDRequestID *)requestID {
    if (!_requestQueue) {
        return;
    }
    [_requestLock lock];
    [requestID.dataTask cancel];
    [_dataTaskArray removeObject:requestID.dataTask];
    [_requestLock unlock];
}

- (DDRequestID *)currentRequest {
    DDRequestID *requestID = nil;
    [_requestLock lock];
    if (_dataTaskArray.count > 0) {
        requestID = [_dataTaskArray lastObject];
    }
    [_requestLock unlock];
    return requestID;
}

- (void)addRequestID:(DDRequestID *)requestID {
    [_requestLock lock];
    [_dataTaskArray addObject:requestID];
    [_requestLock unlock];
}
- (void)cancelAllRequest {
    [_requestLock lock];
    [_dataTaskArray enumerateObjectsUsingBlock:^(NSURLSessionDataTask  * _Nonnull dataTask,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
        [dataTask cancel];
    }];

    [_dataTaskArray removeAllObjects];
    [_requestLock unlock];
}


@end
