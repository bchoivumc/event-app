import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool { 
    if let apiKey = ProcessInfo.processInfo.environment["GMS_API"] {
        print("The value is: \(apiKey)")
      } else {
        print("Environment variable not set.")
      }
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey(apiKey)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
