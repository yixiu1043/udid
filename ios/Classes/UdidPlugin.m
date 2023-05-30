#import "UdidPlugin.h"
#if __has_include(<udid/udid-Swift.h>)
#import <udid/udid-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "udid-Swift.h"
#endif

@implementation UdidPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUdidPlugin registerWithRegistrar:registrar];
}
@end
