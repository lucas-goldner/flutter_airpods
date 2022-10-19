import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_airpods/flutter_airpods_method_channel.dart';

void main() {
  MethodChannelFlutterAirpods platform = MethodChannelFlutterAirpods();
  const MethodChannel channel = MethodChannel('flutter_airpods');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
