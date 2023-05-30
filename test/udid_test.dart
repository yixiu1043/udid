import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:udid/udid.dart';

void main() {
  const MethodChannel channel = MethodChannel('udid');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getUdid', () async {
    expect(await Udid.udid, '42');
  });
}
