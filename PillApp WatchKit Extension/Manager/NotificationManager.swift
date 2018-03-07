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
//        let snoozeAction = UNNotificationAction(identifier: NotificationActionIdentifier.snooze, title: "Snooze", options: .foreground)
        let noAction = UNNotificationAction(identifier: NotificationActionIdentifier.no, title: "No", options: .foreground)
        
        let medicineTakingCategory = UNNotificationCategory(identifier: NotificationCategoryIdentifier.medicineTaking, actions: [yesAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([medicineTakingCategory])
    }
    
    func createLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take your medication"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4.0, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "PillAlarm", content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification response: \(response.actionIdentifier)")
        print(response.actionIdentifier)
        
        let actionIdentifier: String
        
        switch response.actionIdentifier {
        case NotificationActionIdentifier.yes:
            actionIdentifier = NotificationActionIdentifier.yes
        default:
            actionIdentifier = NotificationActionIdentifier.no
            break
        }
        
        let reminderDict = response.notification.request.content.userInfo
        let reminderId = reminderDict["reminderId"]
        
        iOSManager.shared.transferUserInfo(["actionIdentifier": actionIdentifier, "reminderId": reminderId as! Int, "date": Date()])
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}


