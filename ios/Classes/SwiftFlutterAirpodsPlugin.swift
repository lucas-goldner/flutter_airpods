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
        case "getPlatformVersion":
            result(returnSystemVersion())
        case "getAirPodsConnectionUpdates":
            result(returnAirPodsConnectionUpdates())
        default:
            result("")
        }
    }
    
    public func returnSystemVersion() -> String {
        return "iOS " + UIDevice.current.systemVersion
    }
    
    public func returnAirPodsConnectionUpdates() -> String {
        if #available(iOS 14.0, *) {
            return "listenForAirPodsUpdates()"
        }
        
        return "Works only starting with iOS 14.0"
    }
}

class SwiftStreamHandler: NSObject, FlutterStreamHandler, CMHeadphoneMotionManagerDelegate {
    var sink: FlutterEventSink?
    var timer: Timer?
    let airpods = CMHeadphoneMotionManager()

    override init() {
        super.init()
        airpods.delegate = self
        print("INIT FUNCTION")
        guard airpods.isDeviceMotionAvailable else {
            return
        }
    }
      
      func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
          print("ON LISTEN CALLED")
          sink = events
          airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
              guard let motion = motion, error == nil else { return }
              // self?.printData(motion)
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
      
      @objc func sendNewRandomNumber() {
          guard let sink = sink else { return }
          if (airpods.deviceMotion?.attitude.quaternion.x == nil) {
              print("RANDOMNumber")
              let randomNumber = Int.random(in: 1..<10)
              sink(randomNumber)
          } else {
              print("DEVICEMOTION")
              printData(airpods.deviceMotion!)
              sink(Int((airpods.deviceMotion?.attitude.quaternion.x)!))
          }
          
      }
      
      func onCancel(withArguments arguments: Any?) -> FlutterError? {
          sink = nil
          airpods.stopDeviceMotionUpdates()
          return nil
      }
    
    func printData(_ data: CMDeviceMotion) {
        print("""
               Quaternion:
                   x: \(data.attitude.quaternion.x)
                   y: \(data.attitude.quaternion.y)
                   z: \(data.attitude.quaternion.z)
                   w: \(data.attitude.quaternion.w)
               Attitude:
                   pitch: \(data.attitude.pitch)
                   roll: \(data.attitude.roll)
                   yaw: \(data.attitude.yaw)
               Gravitational Acceleration:
                   x: \(data.gravity.x)
                   y: \(data.gravity.y)
                   z: \(data.gravity.z)
               Rotation Rate:
                   x: \(data.rotationRate.x)
                   y: \(data.rotationRate.y)
                   z: \(data.rotationRate.z)
               Acceleration:
                   x: \(data.userAcceleration.x)
                   y: \(data.userAcceleration.y)
                   z: \(data.userAcceleration.z)
               Magnetic Field:
                   field: \(data.magneticField.field)
                   accuracy: \(data.magneticField.accuracy)
               Heading:
                   \(data.heading)
               """)
    }
}

@available(iOS 14.0, *)
class MotionTracker: NSObject, ObservableObject {
    let airpods = CMHeadphoneMotionManager()
    var infos: String
    var isAvailable: Bool
    var errorMessage: String
    
    override init() {
        infos = ""
        errorMessage = ""
        isAvailable = false
        super.init()
        airpods.delegate = self
        
        guard airpods.isDeviceMotionAvailable else {
            errorMessage = "Sorry, Your device is not supported."
            return
        }
        
        airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            print(motion)
            self?.isAvailable = true
            self?.printData(motion)
        })
    }
    
    func printData(_ data: CMDeviceMotion) {
        infos = """
               Quaternion:
                   x: \(data.attitude.quaternion.x)
                   y: \(data.attitude.quaternion.y)
                   z: \(data.attitude.quaternion.z)
                   w: \(data.attitude.quaternion.w)
               Attitude:
                   pitch: \(data.attitude.pitch)
                   roll: \(data.attitude.roll)
                   yaw: \(data.attitude.yaw)
               Gravitational Acceleration:
                   x: \(data.gravity.x)
                   y: \(data.gravity.y)
                   z: \(data.gravity.z)
               Rotation Rate:
                   x: \(data.rotationRate.x)
                   y: \(data.rotationRate.y)
                   z: \(data.rotationRate.z)
               Acceleration:
                   x: \(data.userAcceleration.x)
                   y: \(data.userAcceleration.y)
                   z: \(data.userAcceleration.z)
               Magnetic Field:
                   field: \(data.magneticField.field)
                   accuracy: \(data.magneticField.accuracy)
               Heading:
                   \(data.heading)
               """
    }
}

@available(iOS 14.0, *)
extension MotionTracker: CMHeadphoneMotionManagerDelegate {
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        isAvailable = true
        print("connect")
    }
    
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        isAvailable = false
        print("disconnect")
    }
}
