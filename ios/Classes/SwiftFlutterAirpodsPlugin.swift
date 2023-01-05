import Flutter
import UIKit
import CoreMotion

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
          timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomNumber), userInfo: nil, repeats: true)
          airpods.startDeviceMotionUpdates()
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
