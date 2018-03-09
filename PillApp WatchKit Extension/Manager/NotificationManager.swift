//
//  NotificationManager.swift
//  NotificationManager
//
//  Created by Bruno Scheltzke on 16/10/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import UserNotifications
import UIKit

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
    
    let center = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        center.delegate = self
        registerCategories()
    }
    
    func setup(completion: @escaping(NotifiationResult) -> Void) {
        center.delegate = self
        registerCategories()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                completion(.error(error!))
                return
            }
            
            completion(.granted(granted))
        }
    }
    
    func registerCategories() {
        let yesAction = UNNotificationAction(identifier: NotificationActionIdentifier.yes, title: NotificationActionIdentifier.yes, options: .foreground)
//        let snoozeAction = UNNotificationAction(identifier: NotificationActionIdentifier.snooze, title: "Snooze", options: .foreground)
        let noAction = UNNotificationAction(identifier: NotificationActionIdentifier.no, title: NotificationActionIdentifier.no, options: .foreground)
        
        let medicineTakingCategory = UNNotificationCategory(identifier: NotificationCategoryIdentifier.medicineTaking, actions: [yesAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([medicineTakingCategory])
    }
    
    func createLocalTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take your medication"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        content.userInfo = [Keys.reminderId: "x-coredata://8C1C55E8-70EA-4606-AF3C-8EEF5F1711C5/Reminder/p1"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4.0, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "PillAlarm", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print(error ?? "")
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification response: \(response.actionIdentifier)")
        print(response.actionIdentifier)
        
        if response.notification.request.content.categoryIdentifier == NotificationCategoryIdentifier.medicineTaking {
        
            let medicineTaken: Bool
            
            switch response.actionIdentifier {
            case NotificationActionIdentifier.yes:
                medicineTaken = true
            default:
                medicineTaken = false
                break
            }
            
            let reminderDict = response.notification.request.content.userInfo
            let reminderId = reminderDict[Keys.reminderId] as! String
            
            iOSManager.shared.set(reminderId: reminderId, as: medicineTaken, at: Date())
            completionHandler()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}


