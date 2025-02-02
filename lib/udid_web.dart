import 'dart:async';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fingerprintjs/fingerprintjs.dart';

/// A web implementation of the Udid plugin.
class UdidWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'udid',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = UdidWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getUdid':
        return getUdid();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'udid for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getUdid() async {
    final id = await Fingerprint.getHash();
    return id;
  }
}
