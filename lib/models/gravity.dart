/// An object that represents the gravity vector expressed in the device's reference frame.
/// Note that the total acceleration of the device is equal to gravity plus
/// userAcceleration.
class Gravity {
  final num x;
  final num y;
  final num z;

  Gravity(this.x, this.y, this.z);
}
