#import "CompanyWechatPlugin.h"
#import "WWKApi.h"

@interface CompanyWechatPlugin ()
{
    FlutterResult _result;
}
@end

@implementation CompanyWechatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel * channel = [FlutterMethodChannel methodChannelWithName:@"company_wechat" binaryMessenger:[registrar messenger]];
    CompanyWechatPlugin *instance = [[CompanyWechatPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"companyWechatLogin" isEqualToString:call.method]) {
        _result = result;
        NSDictionary *arguments = call.arguments;
        [self companyWechatLoginWithArguments:arguments];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)companyWechatLoginWithArguments:(NSDictionary *)arguments {
    
    NSString *agentId = [arguments objectForKey:@"agentId"]; //第三方App在企业内部的ID
    NSString *appId = [arguments objectForKey:@"appId"];    // 企业ID
    NSString *schema = [arguments objectForKey:@"schema"]; // app schema
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weworkOOSCallBack:) name:@"KNotificationWWKOOS" object:nil];
    
    BOOL isSuccess = [WWKApi registerApp:schema corpId:appId agentId:agentId];
    if (isSuccess) {
        WWKSSOReq *req = [[WWKSSOReq alloc] init];
        req.state = @"adfasdfasdf23412341fqw4df14t134rtflajssf8934haioefy";
        [WWKApi sendReq:req];
    }else{
        NSLog(@"companyWechatLogin Fail");
    }
}

- (void)weworkOOSCallBack:(NSNotification*) notification {
    NSDictionary *dict = notification.userInfo;
    _result(dict);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
