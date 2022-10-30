import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_airpods/flutter_airpods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _connectionState = 'Unknown';
  final _flutterAirpodsPlugin = FlutterAirpods();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String airpodConnectionUpdate;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterAirpodsPlugin.getPlatformVersion() ??
          'Unknown platform version';
      airpodConnectionUpdate =
          await _flutterAirpodsPlugin.getAirPodsConnectionUpdates() ??
              'Unknown connection state';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      airpodConnectionUpdate = "Failed to get airpods connection state";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _connectionState = airpodConnectionUpdate;
    });
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
              child: StreamBuilder<int>(
                stream: FlutterAirpods.getRandomNumberStream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData) {
                    return Text("Current Random Number: ${snapshot.data}");
                  } else {
                    return const Text("Waiting for new random number...");
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
