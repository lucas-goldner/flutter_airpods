import 'package:equatable/equatable.dart';

/// A quaternion representing the device's attitude
class Quaternion extends Equatable {
  /// x, y, z and w coordinates
  final num x;
  final num y;
  final num z;
  final num w;

  /// Constructor of the quaternion class.
  const Quaternion(this.x, this.y, this.z, this.w);

  /// Used for comparison of quaternion objects.
  @override
  List<Object?> get props => [x, y, z, w];
}
