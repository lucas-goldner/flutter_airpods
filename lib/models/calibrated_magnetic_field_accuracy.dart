mixin MagneticFieldCalibrationAccuracyMixin {
  int get value;
}

/// An object that indicates the calibration
/// accuracy of a magnetic field estimate.
enum MagneticFieldCalibrationAccuracy
    with MagneticFieldCalibrationAccuracyMixin {
  uncalibrated(-1),
  low(0),
  medium(1),
  high(2);

  const MagneticFieldCalibrationAccuracy(this.value);

  @override
  final int value;
}
