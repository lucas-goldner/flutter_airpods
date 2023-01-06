/// An object representing the acceleration that the user is giving to the device. Note
/// that the total acceleration of the device is equal to gravity plus
/// userAcceleration.
class UserAcceleration {
  final num x;
  final num y;
  final num z;

  UserAcceleration(this.x, this.y, this.z);
}
