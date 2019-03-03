#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    //methodChannelWithName:xxx xxx要和flutter平台定义的通道m名称一样
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"sample.flutter.io/data"
                                            binaryMessenger:controller];
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        //在这里处理逻辑
        if([@"data" isEqualToString:call.method]){
            int data = [self getData];
            result (@(data));
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

//返回时整形
- (int)getData{
    return 7;
}
@end
