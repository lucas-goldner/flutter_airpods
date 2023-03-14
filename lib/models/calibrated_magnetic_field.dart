import 'package:equatable/equatable.dart';
import 'package:flutter_airpods/models/magnetic_field.dart';

import 'calibrated_magnetic_field_accuracy.dart';

/// Returns the magnetic field vector with respect to the device for devices with a magnetometer.
/// Note that this is the total magnetic field in the device's vicinity without device
/// bias (Earth's magnetic field plus surrounding fields, without device bias).
class CalibratedMagneticField extends Equatable {
  /// The 3-axis calibrated magnetic field vector.
  final MagneticField field;

  /// An estimate of the calibration accuracy.
  final MagneticFieldCalibrationAccuracy accuracy;

  const CalibratedMagneticField(this.field, this.accuracy);

  @override
  List<Object?> get props => [field, accuracy];
}
