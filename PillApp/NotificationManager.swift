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
//        let snoozeAction = UNNotificationAction(identifier: NotificationActionIdentifier.snooze, title: NotificationActionIdentifier.yes, options: .foreground)
        let noAction = UNNotificationAction(identifier: NotificationActionIdentifier.no, title: NotificationActionIdentifier.no, options: .foreground)
        
        let medicineTakingCategory = UNNotificationCategory(identifier: NotificationCategoryIdentifier.medicineTaking, actions: [yesAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([medicineTakingCategory])
    }
    
    func setUpReminder(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take \(reminder.quantity, reminder.dosage) of \(reminder.medicine!.name!)"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        content.userInfo = [Keys.reminderId: reminder.objectID.uriRepresentation().absoluteString]
        
        var date = DateComponents()
        //TODO: FIX THIS DISGUSTING THING WITH UTC
        date.hour = Calendar.current.component(.hour, from: reminder.date!)
        date.minute = Calendar.current.component(.minute, from: reminder.date!)
        
        if reminder.frequency != Int32(Frequency.everyDay.rawValue) && reminder.frequency != Int32(Frequency.currentDayOnly.rawValue) {
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
        
        center.add(request) { (error) in
            print(error ?? "Setup notification for medication: \(reminder.medicine!.name!), reminderID: \(reminder.objectID.uriRepresentation().absoluteString)")
        }
    }
    
    func createTestLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take your medication"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        content.userInfo = [Keys.reminderId: "x-coredata://8C1C55E8-70EA-4606-AF3C-8EEF5F1711C5/Reminder/p1"]
        
        var date = DateComponents()
        date.timeZone = TimeZone(abbreviation: "UTC")
        
        date.hour = 12
        date.minute = 18
        date.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "PillAlarm", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print(error ?? "")
        }
    }
    
    func createLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Remember to take your medication"
        content.categoryIdentifier = NotificationCategoryIdentifier.medicineTaking
        content.userInfo = [Keys.reminderId: "x-coredata://8C1C55E8-70EA-4606-AF3C-8EEF5F1711C5/Reminder/p1"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 11.0, repeats: false)
        
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
        
        if response.notification.request.content.categoryIdentifier == NotificationCategoryIdentifier.medicineTaking {
            var taken: Bool
            
            switch response.actionIdentifier {
            case NotificationActionIdentifier.yes:
                taken = true
            default:
                taken = false
            }
            
            let reminderDict = response.notification.request.content.userInfo
            let idStr = reminderDict[Keys.reminderId] as! String
            
            guard let idUrl = URL(string: idStr) else {
                print("Error with reminder id: \(idStr)")
                return
            }
            guard let reminder = CoreDataManager.shared.fetchReminder(by: idUrl) else {
                print("No reminder found for reminder id: \(idStr)")
                return
            }
            let date = reminderDict[Keys.date] as? Date ?? Date()
            
            CoreDataManager.shared.createRegister(date: date, reminder: reminder, taken: taken)

            completionHandler()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
