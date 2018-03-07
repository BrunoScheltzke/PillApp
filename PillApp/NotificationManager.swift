//
//  NotificationManager.swift
//  NotificationManager
//
//  Created by Bruno Scheltzke on 16/10/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import UserNotifications
import UIKit
import CoreData

enum NotifiationResult {
    case error(Error)
    case granted(Bool)
}

struct NotificationCategoryIdentifier {
    static let medicineTaking = "TAKEMEDICINE"
}

struct NotificationActionIdentifier {
    static let yes = "Yes"
    static let no = "No"
    static let snooze = "Snooze"
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
//        let snoozeAction = UNNotificationAction(identifier: NotificationActionIdentifier.snooze, title: NotificationActionIdentifier.yes, options: .foreground)
        let noAction = UNNotificationAction(identifier: NotificationActionIdentifier.no, title: NotificationActionIdentifier.yes, options: .foreground)
        
        let medicineTakingCategory = UNNotificationCategory(identifier: NotificationCategoryIdentifier.medicineTaking, actions: [yesAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([medicineTakingCategory])
    }
    
    func setUpReminder(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take \(reminder.quantity, reminder.dosage) of \(String(describing: reminder.medicine?.name))"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        content.userInfo = ["medicineId": Int(reminder.medicine!.id)]
        
        var date = DateComponents()
        date.hour = Calendar.current.component(.hour, from: reminder.date!)
        date.minute = Calendar.current.component(.minute, from: reminder.date!)
        
        if reminder.frequency != Int32(Frequency.everyDay.rawValue) {
            date.weekday = Int(reminder.frequency)
        }
        
        let trigger: UNCalendarNotificationTrigger
        
        if reminder.frequency == Int32(Frequency.currentDayOnly.rawValue) {
            trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        } else {
            trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        }
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: NotificationCategoryIdentifier.medicineTaking, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
    
    func createLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take your medication"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4.0, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: NotificationCategoryIdentifier.medicineTaking, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification response: \(response.actionIdentifier)")
        
        let register = Register()
        
        switch response.actionIdentifier {
        case NotificationActionIdentifier.yes:
            register.taken = true
        default:
            register.taken = false
        }
        
        let reminderDict = response.notification.request.content.userInfo
        //TODO: Fetch reminder from reminderId
        //register.reminder = reminderDict["reminderId"]
        register.date = reminderDict["date"] as? Date ?? Date()
        
        //TODO: Save in hisorico
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
