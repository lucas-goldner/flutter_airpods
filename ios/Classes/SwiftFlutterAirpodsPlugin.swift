import Flutter
import UIKit
import CoreMotion

struct DeviceMotionDataCodable: Codable {
    let quaternionX: Double
    let quaternionY: Double
    let quaternionZ: Double
    let quaternionW: Double
    let pitch: Double
    let roll: Double
    let yaw: Double
    let gravityX: Double
    let gravityY: Double
    let gravityZ: Double
    let rotationRateX: Double
    let rotationRateY: Double
    let rotationRateZ: Double
    let accelerationX: Double
    let accelerationY: Double
    let accelerationZ: Double
    let magneticFieldX: Double
    let magneticFieldY: Double
    let magneticFieldZ: Double
    let magneticFieldAccuracy: Int32
    let heading: Double

    init(deviceMotion: CMDeviceMotion) {
        quaternionX = deviceMotion.attitude.quaternion.x
        quaternionY = deviceMotion.attitude.quaternion.y
        quaternionZ = deviceMotion.attitude.quaternion.z
        quaternionW = deviceMotion.attitude.quaternion.w
        pitch = deviceMotion.attitude.pitch
        roll = deviceMotion.attitude.roll
        yaw = deviceMotion.attitude.yaw
        gravityX = deviceMotion.gravity.x
        gravityY = deviceMotion.gravity.y
        gravityZ = deviceMotion.gravity.z
        rotationRateX = deviceMotion.rotationRate.x
        rotationRateY = deviceMotion.rotationRate.y
        rotationRateZ = deviceMotion.rotationRate.z
        accelerationX = deviceMotion.userAcceleration.x
        accelerationY = deviceMotion.userAcceleration.y
        accelerationZ = deviceMotion.userAcceleration.z
        magneticFieldX = deviceMotion.magneticField.field.x
        magneticFieldY = deviceMotion.magneticField.field.y
        magneticFieldZ = deviceMotion.magneticField.field.z
        magneticFieldAccuracy = deviceMotion.magneticField.accuracy.rawValue
        heading = deviceMotion.heading
    }
}

public class SwiftFlutterAirpodsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_airpods", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "flutter_airpods.motion", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(SwiftStreamHandler())
        let instance = SwiftFlutterAirpodsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getAirPodsConnectionUpdates":
            result(returnAirPodsConnectionUpdates())
        default:
            result("")
        }
    }
    
    public func returnAirPodsConnectionUpdates() -> String {
        if #available(iOS 14.0, *) {
            return "listenForAirPodsUpdates()"
        }
        
        return "Works only starting with iOS 14.0"
    }
}

class SwiftStreamHandler: NSObject, FlutterStreamHandler, CMHeadphoneMotionManagerDelegate {
    var timer: Timer?
    let airpods = CMHeadphoneMotionManager()

    override init() {
        super.init()
        airpods.delegate = self
        guard airpods.isDeviceMotionAvailable else {
            return
        }
    }
      
      func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
          airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {motion, error  in
              guard let motion = motion, error == nil else { return }
              let encoder = JSONEncoder()
              let deviceMotionData = DeviceMotionDataCodable(deviceMotion: motion)
              if let jsonData = try? encoder.encode(deviceMotionData) {
                  if let jsonString = String(data: jsonData, encoding: .utf8) {
                      events(jsonString)
                  }
              }
          })
          
          return nil
      }
      
      func onCancel(withArguments arguments: Any?) -> FlutterError? {
          airpods.stopDeviceMotionUpdates()
          return nil
      }
}
