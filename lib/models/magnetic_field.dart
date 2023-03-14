import 'package:equatable/equatable.dart';

/// A structure containing 3-axis magnetometer data.
class MagneticField extends Equatable {
  /// x,y and z coordinates
  final num x;
  final num y;
  final num z;

  /// Constructor of the magneticfield class.
  const MagneticField(this.x, this.y, this.z);

  /// Used for comparison of magneticfield objects.
  @override
  List<Object?> get props => [x, y, z];
}
