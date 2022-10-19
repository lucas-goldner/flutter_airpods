
import 'flutter_airpods_platform_interface.dart';

class FlutterAirpods {
  Future<String?> getPlatformVersion() {
    return FlutterAirpodsPlatform.instance.getPlatformVersion();
  }
}
