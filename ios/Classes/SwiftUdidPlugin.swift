import Flutter
import UIKit
import KeychainAccess

public class SwiftUdidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "udid", binaryMessenger: registrar.messenger())
    let instance = SwiftUdidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "getUdid" {
          result(getUUID())
      }else{
          result("iOS " + UIDevice.current.systemVersion)
      }
  }
    
  private func getUUID(key: String = "jav_uuid") -> String{
      let keychain = Keychain(service: "com.ob.jav.keychain")
      if let uuid = keychain[key] {
          return uuid
      }
      if let uuid = UIDevice.current.identifierForVendor?.uuidString {
          keychain[key] = uuid
          return uuid
      }
      return ""
  }
}
