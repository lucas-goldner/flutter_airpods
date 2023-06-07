# Flutter AirPods Plugin

[![pub package](https://img.shields.io/pub/v/flutter_airpods.svg)](https://pub.dev/packages/flutter_airpods)
[![pub points](https://img.shields.io/pub/points/flutter_airpods?color=2E8B57&label=pub%20points)](https://pub.dev/packages/flutter_airpods/score)

A Library for accessing AirPods data via CMHeadphoneMotionManager. Simplifies retrieval of information about currently connected AirPods.

It uses [CMHeadphoneMotionManager](https://developer.apple.com/documentation/coremotion/cmheadphonemotionmanager), and gathering information starts as soon as the user puts the AirPods into
the ear. Only iOS 14+ supports this functionality, so devices with a lower
version cannot use this package. Also, for Android currently, there are no comparable headphones
with that functionality, so there is no implementation for that platform.
Only AirPods (3. Generation), AirPods Pro, AirPods Max und Beats Fit Pro are supported!
Below is the complete JSON data that you can expect:

```
{
    // The attitude of the device.

    // Returns a quaternion representing the device's attitude.

    quaternionY: 0.21538676246259386,
    quaternionX: -0.47675120121765957,
    quaternionW: 0.8522420297864675,
    quaternionZ: -0.0005364311021727928

    pitch: -0.9490214392332175,           // The pitch of the device, in radians.
    roll: 0.6807802035216475,             // The roll of the device, in radians.
    yaw: 0.3586524456166643,              // The yaw of the device, in radians.

    // The gravity acceleration vector expressed in the device's reference frame.

    gravityX: 0.3666117787361145,         // Gravity vector along the x-axis in G's
    gravityY: 0.8128458857536316,         // Gravity vector along the y-axis in G's
    gravityZ: -0.45263373851776123,       // Gravity vector along the z-axis in G's

    // The acceleration that the user is giving to the device.

    accelerationX: 0.005457472056150436,  // Acceleration along the x-axis in G's
    accelerationY: 0.01201944425702095,   // Acceleration along the y-axis in G's
    accelerationZ: -0.005634056404232979, // Acceleration along the z-axis in G's

    // The rotation rate of the device.

    rotationRateX: -0.0419556125998497,   // Rotation rate around the x-axis in radians per second
    rotationRateY: -0.01837937720119953,  // Rotation rate around the y-axis in radians per second
    rotationRateZ: 0.011555187404155731,  // Rotation rate around the z-axis in radians per second

    // Returns the magnetic field vector with respect to the device.

    magneticFieldAccuracy: -1,            // Indicates the calibration accuracy of a magnetic field estimate
    magneticFieldX: 0,                    // Magnetic field vector along the x-axis in microteslas
    magneticFieldY: 0,                    // Magnetic field vector along the y-axis in microteslas
    magneticFieldZ: 0,                    // Magnetic field vector along the z-axis in microteslas
    heading: 0                            // This property contains a value in the range of 0.0 to 360.0 degrees.
                                          // A heading of 0.0 indicates that the attitude of the device matches the current reference frame.
}
```

## Before you start!

1. Set the iOS Version of your project to at least `iOS 14`.

2. Inside of the `ios/Runner/Info.plist` you need to add `NSMotionUsageDescription` with a reason on why you want to use it:

```
<key>NSMotionUsageDescription</key>
<string>Get AirPods movement</string>
```

## Usage

To use this plugin, add `flutter_airpods` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

### Example

Here is an example of how to use this package:

```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Airpods example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: StreamBuilder<DeviceMotionData>(
                stream: FlutterAirpods.getAirPodsDeviceMotionUpdates,
                builder: (BuildContext context,
                    AsyncSnapshot<DeviceMotionData> snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data?.toJson()}");
                  } else {
                    return const Text("Waiting for incoming data...");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
```
