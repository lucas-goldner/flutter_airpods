#import "FlutterAirpodsPlugin.h"
#if __has_include(<flutter_airpods/flutter_airpods-Swift.h>)
#import <flutter_airpods/flutter_airpods-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_airpods-Swift.h"
#endif

@implementation FlutterAirpodsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAirpodsPlugin registerWithRegistrar:registrar];
}
@end
