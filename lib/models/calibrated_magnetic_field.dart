import 'package:flutter_airpods/models/magnetic_field.dart';

import 'calibrated_magnetic_field_accuracy.dart';

class CalibratedMagneticField {
  final MagneticField field;
  final MagneticFieldCalibrationAccuracy accuracy;

  CalibratedMagneticField(this.field, this.accuracy);
}
