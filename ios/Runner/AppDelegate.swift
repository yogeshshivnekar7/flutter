import UIKit
import Flutter
import Firebase
import GoogleMaps
import FBSDKCoreKit

//import GooglePlaces
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    Settings.isAutoInitEnabled = true
    GeneratedPluginRegistrant.register(with: self)
//    GMSPlacesClient.provideAPIKey("AIzaSyA4PK-TCd-uHNS5OWjpbaTgZuTB_dxVMWY")
    GMSServices.provideAPIKey("AIzaSyBj3avhHuFmdvR5TihGoQEfrnLhLDvactc")
    //GMSServices.provideAPIKey("YOUR_API_KEY")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)


    }
}
