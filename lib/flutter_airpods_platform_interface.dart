import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_airpods_method_channel.dart';

abstract class FlutterAirpodsPlatform extends PlatformInterface {
  /// Constructs a FlutterAirpodsPlatform.
  FlutterAirpodsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAirpodsPlatform _instance = MethodChannelFlutterAirpods();

  /// The default instance of [FlutterAirpodsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAirpods].
  static FlutterAirpodsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAirpodsPlatform] when
  /// they register themselves.
  static set instance(FlutterAirpodsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
