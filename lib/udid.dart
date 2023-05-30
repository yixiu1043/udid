import 'dart:async';

import 'package:flutter/services.dart';

class Udid {
  static const MethodChannel _channel = MethodChannel('udid');

  static Future<String?> get udid async {
    final String? version = await _channel.invokeMethod('getUdid');
    return version;
  }
}
