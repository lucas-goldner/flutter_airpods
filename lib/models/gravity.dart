import 'package:equatable/equatable.dart';

/// An object that represents the gravity vector expressed in the device's reference frame.
/// Note that the total acceleration of the device is equal to gravity plus
/// userAcceleration.
class Gravity extends Equatable {
  /// x,y and z coordinates
  final num x;
  final num y;
  final num z;

  /// Constructor of the gravity class.
  const Gravity(this.x, this.y, this.z);

  /// Used for comparison of gravity objects.
  @override
  List<Object?> get props => [x, y, z];
}
