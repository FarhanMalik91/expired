//
//  AppDelegate.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import UserNotifications
import GoogleMobileAds
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        notificationCenter.delegate = self
        registerLocalNotification()
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let _ = DataManager.shared.getUserData(){
        window?.rootViewController = UINavigationController(rootViewController: DashboardController())
        }else {
            window?.rootViewController = UINavigationController(rootViewController: LoginController())
        }
        
        
        
        window?.makeKeyAndVisible()
        return true
    }
}
extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func registerLocalNotification() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    //Handle Notification Center Delegate methods
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        completionHandler()
    }
}
