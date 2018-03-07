//
//  ExtensionDelegate.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        iOSManager.shared.startSession()
        
        NotificationManager.shared.requestAuthorization { (result) in}
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        
    }
}
