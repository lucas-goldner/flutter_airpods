import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_airpods/models/device_motion_data.dart';

class FlutterAirpods {
  static const EventChannel _motionChannel =
      EventChannel("flutter_airpods.motion");

  static Stream<DeviceMotionData> get getAirPodsDeviceMotionUpdates {
    return _motionChannel.receiveBroadcastStream().map((event) {
      Map<String, dynamic> json = jsonDecode(event);

      DeviceMotionData deviceMotionData = DeviceMotionData.fromJson(json);

      return deviceMotionData;
    });
  }
}
