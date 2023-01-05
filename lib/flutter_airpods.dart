import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_airpods/models/device_motion_data.dart';

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

  static Stream<DeviceMotionData> get getAirPodsDeviceMotionUpdates {
    // final jsonString = _motionChannel.receiveBroadcastStream().cast();
    return _motionChannel.receiveBroadcastStream().map((event) {
      Map<String, dynamic> json = jsonDecode(event);

      DeviceMotionData deviceMotionData = DeviceMotionData.fromJson(json);

      return deviceMotionData;
    });

    // return _motionChannel.receiveBroadcastStream().cast();
  }
}
