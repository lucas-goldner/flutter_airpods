import 'package:flutter/services.dart';

import 'flutter_airpods_platform_interface.dart';

class FlutterAirpods {
  static const EventChannel _motionChannel =
      EventChannel("flutter_airpods.motion");

  Future<String?> getPlatformVersion() {
    return FlutterAirpodsPlatform.instance.getPlatformVersion();
  }

  Future<String?> getAirPodsConnectionUpdates() {
    return FlutterAirpodsPlatform.instance.getAirPodsConnectionUpdates();
  }

  static Stream<int> get getRandomNumberStream {
    return _motionChannel.receiveBroadcastStream().cast();
  }
}
