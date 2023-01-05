import 'package:flutter_airpods/models/quaternion.dart';

class Attitude {
  final Quaternion quaternion;
  final num pitch;
  final num roll;
  final num yaw;

  Attitude(this.quaternion, this.pitch, this.roll, this.yaw);
}
