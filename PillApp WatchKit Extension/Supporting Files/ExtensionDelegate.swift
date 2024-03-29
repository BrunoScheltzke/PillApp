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
        
        NotificationManager.shared.setup { (result) in}
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
//            switch task {
////            case let backgroundTask as WKApplicationRefreshBackgroundTask:
////                // Be sure to complete the background task once you’re done.
////                backgroundTask.setTaskCompletedWithSnapshot(false)
////            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
////                // Snapshot tasks have a unique completion call, make sure to set your expiration date
////                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
////            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
////                // Be sure to complete the connect  ivity task once you’re done.
////                connectivityTask.setTaskCompletedWithSnapshot(false)
////            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
////                // Be sure to complete the URL session task once you’re done.
////                urlSessionTask.setTaskCompletedWithSnapshot(false)
////            default:
////                // make sure to complete unhandled task types
////                task.setTaskCompletedWithSnapshot(false)
//            }
        }
    }
}
