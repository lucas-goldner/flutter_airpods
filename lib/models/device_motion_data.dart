import 'package:equatable/equatable.dart';
import 'package:flutter_airpods/models/attitude.dart';
import 'package:flutter_airpods/models/calibrated_magnetic_field.dart';
import 'package:flutter_airpods/models/gravity.dart';
import 'package:flutter_airpods/models/magnetic_field.dart';
import 'package:flutter_airpods/models/quaternion.dart';
import 'package:flutter_airpods/models/rotation_rate.dart';
import 'package:flutter_airpods/models/user_acceleration.dart';

import 'calibrated_magnetic_field_accuracy.dart';

/// An object that contains all information about the airpods data.
class DeviceMotionData extends Equatable {
  final Attitude attitude;
  final Gravity gravity;
  final RotationRate rotationRate;
  final UserAcceleration userAcceleration;
  final CalibratedMagneticField calibratedMagneticField;
  final num heading;

  const DeviceMotionData(
    this.attitude,
    this.gravity,
    this.rotationRate,
    this.userAcceleration,
    this.calibratedMagneticField,
    this.heading,
  );

  /// Creates a new DeviceMotionData from a JSON
  factory DeviceMotionData.fromJson(Map<String, dynamic> json) {
    MagneticFieldCalibrationAccuracy accuracy =
        MagneticFieldCalibrationAccuracy.uncalibrated;
    if (json['magneticFieldAccuracy'] == -1) {
      accuracy = MagneticFieldCalibrationAccuracy.uncalibrated;
    } else if (json['magneticFieldAccuracy'] == 0) {
      accuracy = MagneticFieldCalibrationAccuracy.low;
    } else if (json['magneticFieldAccuracy'] == 1) {
      accuracy = MagneticFieldCalibrationAccuracy.medium;
    } else if (json['magneticFieldAccuracy'] == 2) {
      accuracy = MagneticFieldCalibrationAccuracy.high;
    }

    return DeviceMotionData(
      Attitude(
          Quaternion(json["quaternionX"], json["quaternionY"],
              json["quaternionZ"], json["quaternionW"]),
          json['pitch'],
          json['roll'],
          json['yaw']),
      Gravity(json['gravityX'], json['gravityY'], json['gravityZ']),
      RotationRate(
          json['rotationRateX'], json['rotationRateY'], json['rotationRateZ']),
      UserAcceleration(
          json['accelerationX'], json['accelerationY'], json['accelerationZ']),
      CalibratedMagneticField(
          MagneticField(json['magneticFieldX'], json['magneticFieldY'],
              json['magneticFieldZ']),
          accuracy),
      json['heading'],
    );
  }

  /// Creates a JSON from an existing DeviceMotionData
  Map<String, dynamic> toJson() => {
        "quaternionX": attitude.quaternion.x,
        "quaternionY": attitude.quaternion.y,
        "quaternionZ": attitude.quaternion.z,
        "quaternionW": attitude.quaternion.w,
        'pitch': attitude.pitch,
        'roll': attitude.roll,
        'yaw': attitude.yaw,
        'gravityX': gravity.x,
        'gravityY': gravity.y,
        'gravityZ': gravity.z,
        'rotationRateX': rotationRate.x,
        'rotationRateY': rotationRate.y,
        'rotationRateZ': rotationRate.z,
        'accelerationX': userAcceleration.x,
        'accelerationY': userAcceleration.y,
        'accelerationZ': userAcceleration.z,
        'magneticFieldX': calibratedMagneticField.field.x,
        'magneticFieldY': calibratedMagneticField.field.y,
        'magneticFieldZ': calibratedMagneticField.field.z,
        'magneticFieldAccuracy': calibratedMagneticField.accuracy.value,
        'heading': heading,
      };

  /// Used for comparison of device motion data objects.
  @override
  List<Object?> get props => [
        attitude,
        gravity,
        rotationRate,
        userAcceleration,
        calibratedMagneticField,
        heading
      ];
}
