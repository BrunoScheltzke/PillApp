//
//  InterfaceController.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    @IBAction func localNotificationButtonTapped() {
        NotificationManager.shared.createLocalNotification()
    }
    
    @IBAction func wsConnectionButtonTapped() {
        iOSManager.shared.sendMessage(["Message": "Sent"], { (reply) in
            print("Received Reply")
            print(reply)
        }) { (error) in
            print("deu error")
            print(error)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
