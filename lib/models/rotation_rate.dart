import 'package:equatable/equatable.dart';

/// Rotation rate of the device for devices with a gyro.
class RotationRate extends Equatable {
  /// x,y and z coordinates
  final num x;
  final num y;
  final num z;

  /// Constructor of the rotation rate class.
  const RotationRate(this.x, this.y, this.z);

  /// Used for comparison of rotation rate objects.
  @override
  List<Object?> get props => [x, y, z];
}
