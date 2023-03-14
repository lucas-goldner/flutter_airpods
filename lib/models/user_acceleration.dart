import 'package:equatable/equatable.dart';

/// An object representing the acceleration that the user is giving to the device. Note
/// that the total acceleration of the device is equal to gravity plus
/// userAcceleration.
class UserAcceleration extends Equatable {
  /// x,y and z coordinates
  final num x;
  final num y;
  final num z;

  /// Constructor of the user acceleration class.
  const UserAcceleration(this.x, this.y, this.z);

  /// Used for comparison of user acceleration objects.
  @override
  List<Object?> get props => [x, y, z];
}
