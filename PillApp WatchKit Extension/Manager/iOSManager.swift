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

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received communication from iPhone")
        print(applicationContext)
    }
    
    func updateApplicationContext(_ context: [String: Any]) throws {
        do {
            print("Sent application context to iPhone")
            try session?.updateApplicationContext(context)
        } catch {
            print("Failed to send message to iPhone")
            throw error
        }
    }
    
    func sendMessage(_ message: [String: Any], _ replyHandler: (([String: Any]) -> Void)?, _ errorHandler: ((Error) -> Void)?) {
        print("Sent message to iPhone")
        session?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    func transferUserInfo(_ userInfo: [String: Any]) {
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
