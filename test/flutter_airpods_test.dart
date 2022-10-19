import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_airpods/flutter_airpods.dart';
import 'package:flutter_airpods/flutter_airpods_platform_interface.dart';
import 'package:flutter_airpods/flutter_airpods_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAirpodsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAirpodsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAirpodsPlatform initialPlatform = FlutterAirpodsPlatform.instance;

  test('$MethodChannelFlutterAirpods is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAirpods>());
  });

  test('getPlatformVersion', () async {
    FlutterAirpods flutterAirpodsPlugin = FlutterAirpods();
    MockFlutterAirpodsPlatform fakePlatform = MockFlutterAirpodsPlatform();
    FlutterAirpodsPlatform.instance = fakePlatform;

    expect(await flutterAirpodsPlugin.getPlatformVersion(), '42');
  });
}
