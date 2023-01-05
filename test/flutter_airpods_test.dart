import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const EventChannel motionChannel = EventChannel("flutter_airpods.motion");

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    motionChannel.receiveBroadcastStream((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    motionChannel.receiveBroadcastStream(null);
  });
}
