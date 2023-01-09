import 'package:flutter_airpods/models/quaternion.dart';

/// An object containing the attitude, yaw, pitch, roll
/// of the device. Yaw, pitch and roll are in radians.
class Attitude {
  final Quaternion quaternion;

  /// Pitch is the rotation of an object around its lateral (x) axis.
  final num pitch;

  /// Roll is the rotation of an object around its longitudinal (z) axis.
  final num roll;

  /// Yaw is the rotation of an object around its vertical (y) axis.
  final num yaw;

  Attitude(this.quaternion, this.pitch, this.roll, this.yaw);
}
