//
//  NotificationManager.swift
//  NotificationManager
//
//  Created by Bruno Scheltzke on 16/10/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import Foundation
import UserNotifications
import WatchConnectivity

enum NotifiationResult {
    case error(Error)
    case granted(Bool)
}

struct NotificationCategoryIdentifier {
    static let medicineTaking = "TAKEMEDICINE"
}

struct NotificationActionIdentifier {
    static let yes = "YES"
    static let no = "NO"
    static let snooze = "SNOOZE"
}

class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    private override init() {
        super.init()
        
        center.delegate = self
        registerCategories()
    }
    
    let center = UNUserNotificationCenter.current()
    
    func requestAuthorization(completion: @escaping(NotifiationResult) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            guard error == nil else {
                completion(.error(error!))
                return
            }
            
            completion(.granted(granted))
        }
    }
    
    func registerCategories() {
        let yesAction = UNNotificationAction(identifier: NotificationActionIdentifier.yes, title: "Yes", options: .foreground)
        let snoozeAction = UNNotificationAction(identifier: NotificationActionIdentifier.snooze, title: "Snooze", options: .foreground)
        let noAction = UNNotificationAction(identifier: NotificationActionIdentifier.no, title: "No", options: .foreground)
        
        let medicineTakingCategory = UNNotificationCategory(identifier: NotificationCategoryIdentifier.medicineTaking, actions: [yesAction, snoozeAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([medicineTakingCategory])
    }
    
    func createLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test local notification"
        content.body = "This is just a test notification with a YES action"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4.0, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //if received by the iphone just save the info
        //if received by the watch send it to the iphone
        
        if WCSession.default.isReachable {
            let command = ["command": NotificationActionIdentifier.yes]
            do {
                try WCSession.default.updateApplicationContext(command)
            } catch {
                print("n deu :(")
            }
        }
        
        print(response.actionIdentifier)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}

