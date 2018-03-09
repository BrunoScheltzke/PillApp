//
//  iOSManager.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation
import WatchConnectivity

class iOSManager: NSObject, WCSessionDelegate {
    
    static let shared = iOSManager()
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    func getDailyReminders(_ completion: @escaping (([Reminder], [Register])) -> Void, _ errorHandler: @escaping (Error) -> Void) {
        session?.sendMessage([Keys.communicationCommand: CommunicationProtocol.dailyReminders], replyHandler: { (response) in
            
            guard let command = response[Keys.communicationCommand] as? String, command == CommunicationProtocol.dailyReminders else {return}
            
            let remindersDict = response[Keys.reminders] as! [[String: Any]]
            var reminders: [Reminder] = []
            
            remindersDict.forEach({ (dict) in
                reminders.append(Reminder(dict))
            })
            
            let registersDict = response[Keys.registers] as! [[String: Any]]
            var registers: [Register] = []
            
            registersDict.forEach({ (dict) in
                registers.append(Register(dict))
            })
            
            completion((reminders, registers))
            
        }, errorHandler: errorHandler)
    }
    
    func set(reminderId: String, as checked: Bool, at date: Date) {
        transferUserInfo([Keys.communicationCommand: CommunicationProtocol.checkedReminder, Keys.medicineTaken: checked, Keys.reminderId: reminderId, Keys.date: date])
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received communication from iPhone")
        print(applicationContext)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    private func updateApplicationContext(_ context: [String: Any]) throws {
        do {
            print("Sent application context to iPhone")
            try session?.updateApplicationContext(context)
        } catch {
            print("Failed to send message to iPhone")
            throw error
        }
    }
    
    private func sendMessage(_ message: [String: Any], _ replyHandler: (([String: Any]) -> Void)?, _ errorHandler: ((Error) -> Void)?) {
        session?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
        print("Sent message to iPhone")
    }
    
    private func transferUserInfo(_ userInfo: [String: Any]) {
        print("Sent user info to iPhone")
        session?.transferUserInfo(userInfo)
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
    
    // MARK: Delegate unused methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
