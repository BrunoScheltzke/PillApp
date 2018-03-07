//
//  WatchManager.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchManager: NSObject, WCSessionDelegate {
    static let shared = WatchManager()
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received application context from watch")
        print(applicationContext)
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("Received User Info from watch")
        print(userInfo)
        
        //TODO: Save register after action from apple watch notification
        //register.taken = userInfo["actionIdentifier"]
        //register.reminderId = userInfo["reminderId"]
        //register.date = userInfo["date"]
        //saveRegister
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Received Message from watch")
        print(message)
    }
    
    func updateApplicationContext(context: [String: Any]) throws {
        do {
            try session?.updateApplicationContext(context)
        } catch {
            throw error
        }
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
    
    // MARK: Delegate unused methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
}
