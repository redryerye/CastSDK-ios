//
//  AppDelegate.swift
//  CastSDK-ios-demo
//
//  Created by Yuki Yamamoto on 2019/01/26.
//  Copyright © 2019 Yuki Yamamoto. All rights reserved.
//

import UIKit
import GoogleCast

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GCKLoggerDelegate {

    var window: UIWindow?
    let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
    let kDebugLoggingEnabled = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let criteria = GCKDiscoveryCriteria(applicationID: kReceiverAppID)
        let options = GCKCastOptions(discoveryCriteria: criteria)
        GCKCastContext.setSharedInstanceWith(options)
        
        // Enable logger
        GCKLogger.sharedInstance().delegate = self
        
        let castStyle = GCKUIStyle.sharedInstance()
        
        // Style for device chooser
        castStyle.castViews.deviceControl.iconTintColor = UIColor.gray
        castStyle.castViews.deviceControl.backgroundColor = UIColor.init(hex: "40BBBD")
        castStyle.castViews.deviceControl.buttonTextColor = UIColor.init(hex: "E6EEBD")
        castStyle.castViews.deviceControl.headingTextColor = UIColor.init(hex: "E6EEBD")
        castStyle.castViews.deviceControl.captionTextColor = UIColor.white
        
        // Style for mini media control
        castStyle.castViews.mediaControl.miniController.backgroundColor = UIColor.init(hex: "E6EEBD")
        castStyle.castViews.mediaControl.miniController.buttonTextColor = UIColor.init(hex: "E6EEBD")
        castStyle.castViews.mediaControl.miniController.headingTextColor = UIColor.black
        castStyle.castViews.mediaControl.miniController.captionTextColor = UIColor.gray
        castStyle.castViews.mediaControl.miniController.iconTintColor = UIColor.gray
        
        let appStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = appStoryboard.instantiateViewController(withIdentifier: "MainNavigationController")
        let castContainerVC = GCKCastContext.sharedInstance().createCastContainerController(for: navigationController)
        castContainerVC.miniMediaControlsItemEnabled = true
        
        // Style for miniMediaVC
        castContainerVC.view.backgroundColor = UIColor.init(hex: "E6EEBD")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = castContainerVC
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - GCKLoggerDelegate
    func logMessage(_ message: String, at level: GCKLoggerLevel, fromFunction function: String, location: String) {
        if(kDebugLoggingEnabled) {
            print(function + " - " + message)
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
