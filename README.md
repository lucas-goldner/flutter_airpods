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
    quaternionY: 0.21538676246259386,
    quaternionX: -0.47675120121765957,
    quaternionW: 0.8522420297864675,
    quaternionZ: -0.0005364311021727928
    pitch: -0.9490214392332175,
    roll: 0.6807802035216475,
    yaw: 0.3586524456166643,
    gravityX: 0.3666117787361145,
    gravityY: 0.8128458857536316,
    gravityZ: -0.45263373851776123,
    accelerationX: 0.005457472056150436,
    accelerationY: 0.01201944425702095,
    accelerationZ: -0.005634056404232979,
    rotationRateX: -0.0419556125998497,
    rotationRateY: -0.01837937720119953,
    rotationRateZ: 0.011555187404155731,
    magneticFieldAccuracy: -1,
    magneticFieldX: 0,
    magneticFieldY: 0,
    magneticFieldZ: 0,
    heading: 0
}
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
