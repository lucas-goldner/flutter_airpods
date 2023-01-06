import 'package:flutter_airpods/models/quaternion.dart';

/// An object containing the attitude, yaw, pitch, roll
/// of the device. Yaw, pitch and roll are in radians.
class Attitude {
  final Quaternion quaternion;
  final num pitch;
  final num roll;
  final num yaw;

  Attitude(this.quaternion, this.pitch, this.roll, this.yaw);
}
