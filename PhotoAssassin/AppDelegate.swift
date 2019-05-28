//   
//  AppDelegate.swift
//  Photo Assassin
//
//  Copyright © Michigan Hackers. All rights reserved.
//

import Firebase
import UIKit
import FBSDKCoreKit
import FacebookCore

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy private var router = RootRouter()
    lazy private var deeplinkHandler = DeeplinkHandler()
    lazy private var notificationsHandler = NotificationsHandler()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        // Notifications
        notificationsHandler.configure()

        // App structure
        router.loadMainAppStructure()

        // Firebase configuration
        FirebaseApp.configure()
        
        //Facebook Login configuration
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // To enable full universal link functionality add and configure the associated domain capability
        // https://developer.apple.com/library/content/documentation/General/Conceptual/AppSearch/UniversalLinks.html
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            deeplinkHandler.handleDeeplink(with: url)
        }
        return true
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // To enable full remote notifications functionality you should first register the device with your api service
        //https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/
        notificationsHandler.handleRemoteNotification(with: userInfo)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
