import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_airpods/models/device_motion_data.dart';

/// API for accessing information about the currently connected airpods.
class FlutterAirpods {
  static const EventChannel _motionChannel =
      EventChannel("flutter_airpods.motion");

  /// The getAirPodsDeviceMotionUpdates method allows to receive updates on the motion data of the currently connected airpods.
  static Stream<DeviceMotionData> get getAirPodsDeviceMotionUpdates {
    /// The data gets sent over the event channel.
    /// Every incoming event gets read as a JSON and then
    /// is mapped as [DeviceMotionData].
    return _motionChannel.receiveBroadcastStream().map((event) {
      Map<String, dynamic> json = jsonDecode(event);

      /// Creates a [DeviceMotionData] from a JSON.
      DeviceMotionData deviceMotionData = DeviceMotionData.fromJson(json);

      /// Returns transformed [DeviceMotionData]
      return deviceMotionData;
    });
  }
}
