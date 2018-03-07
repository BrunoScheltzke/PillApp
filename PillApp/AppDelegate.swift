//
//  AppDelegate.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        WatchManager.shared.startSession()
        
        NotificationManager.shared.requestAuthorization { (result) in
        }
        return true
    }
}
