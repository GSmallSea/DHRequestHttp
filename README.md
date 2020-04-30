# DHRequestHttp
AFNetWorking3.0 封装              

        这不是框架、因为没有加密、或者basic等授权、需要根据自己的业务添加。只是想单纯分享一下这个 请求方式
        DHNetWork
        ----NetworkService:文件下可以添加各种业务对应的DDAPIManager分类
        ----Http          :请求
        ----API           :对应POST,GET,Body,请求。可以自己添加其他请求
        ----Helper        :帮助文件夹、可以在文件夹下面添加，加密等工具。

1--> 创建一个DDAPIManager分类来包装请求参数。

        如:DDAPIManager + activity
        这样做的目的是为了相对应地业务，如果其他的业务请求可以创建对应的 DDAPIManager + "name"。
        
2--> DDAPIContext :

        获取Api的上下文,可以自定义相关业务的参数。增加可拓展性。用于"DDHttpHelper"
        @property (nonatomic, assign, readonly) HttpRequestMothodType methodType;
        @property (nonatomic, strong, readonly, nonnull) NSString *URLString;
        @property (nonatomic, strong, readonly, nullable) NSDictionary *parameterDict;
        @property (nonatomic, assign, readonly,getter = isEncryption) BOOL Encryption;
        @property (nonatomic, assign, readonly,getter = isBasic) BOOL Basic;
        @property (nonatomic, assign, readonly,getter = isToken) BOOL token;
        @property (nonatomic, assign, readonly,getter = isRefreshToken) BOOL refreshToken;
        @property (nonatomic, assign, readonly,getter = isDecodeUrl) BOOL recodeUrl;

3--->  DDHttpHelper:

        sharedManager:单利对象
        requestWithAPIContext:发起请求
        cancelWithRequestID: 根据对应的标识取消请求

4--> DDRequestID:

        表示一个请求ID
        setResultBlock: 请求回调

5--> DDNetworkConstants:
        
        配置一些请求信息，网络环境等。


6---> 例子

        @property (nonatomic,strong) DDRequestID *request;

        [[DDAPIManager apiManagerActivityGetSubjectListWithTimeStamp:@""] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
            // 请求成功
            if (isSuccess) {
                
            }else{
                // 请求失败
            }
        }];
        // 模拟一个post 请求
        [[DDAPIManager apiManagerPost] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
            if (isSuccess) {
                
            }else{
                
            }
        }];
        
        // 模拟一个body 请求
        [[DDAPIManager apiManagerBody] setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
            if (isSuccess) {
                
            }else{
                
            }
        }];
                
        // 创建一个请求
        self.request = [DDAPIManager apiManagerBody];
        [self.request setResultBlock:^(BOOL isSuccess, id  _Nonnull object) {
            if (isSuccess) {
                
            }else{
                
            }
        }];
        
        // 取消当前请求
        [[DDAPIManager sharedManager] cancelWithRequestID:self.request];


7--> 如果请求中存在header加密,可以在以下地方修改
        
        DDHttpHelper/setHeaderRequestConfigs:sessionManager

8--> 集中处理错误信息的地方
                
        DDHttpHelper/requestFailedRefrehsTokenWithErrorObject:requestID
        目前只添加了回调，可以根据自己的业务进行简单修改
        
