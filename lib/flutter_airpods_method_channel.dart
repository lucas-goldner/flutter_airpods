import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_airpods_platform_interface.dart';

/// An implementation of [FlutterAirpodsPlatform] that uses method channels.
class MethodChannelFlutterAirpods extends FlutterAirpodsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_airpods');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getAirPodsConnectionUpdates() async {
    final version =
        await methodChannel.invokeMethod<String>('getAirPodsConnectionUpdates');
    return version;
  }
}
