import 'package:flutter/material.dart';

import 'package:flutter_airpods/flutter_airpods.dart';
import 'package:flutter_airpods/models/device_motion_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
              child:

                  /// Streambuilder that continuingly reads data from [CMHeadphoneMotionManager]
                  StreamBuilder<DeviceMotionData>(
                stream: FlutterAirpods.getAirPodsDeviceMotionUpdates,
                builder: (BuildContext context,
                    AsyncSnapshot<DeviceMotionData> snapshot) {
                  /// If AirPods are connected and in ear hasData will be true.
                  /// When AirPods are connected, but removed from ear, it will
                  /// stop receiving data.
                  if (snapshot.hasData) {
                    return Text("${snapshot.data?.toJson()}");
                  } else {
                    /// AirPods are not connected yet
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
}
