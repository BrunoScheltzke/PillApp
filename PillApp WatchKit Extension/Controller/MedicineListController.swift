//
//  InterfaceController.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, dd"
    return formatter
}()

class MedicineListController: WKInterfaceController {
    @IBOutlet var notificationBtn: WKInterfaceButton!
    
    @IBOutlet var dayLabel: WKInterfaceLabel!
    var reminders: [Reminder] = []
    var regostersCount: Int = 0
    let scene = RingScene(size: CGSize(width: 45, height: 45))
    
    @IBOutlet var medicineTable: WKInterfaceTable!
    @IBOutlet var spriteScene: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        iOSManager.shared.getDailyReminders({ (result) in
            
            self.reminders = result.0
            let registers = result.1
            
            self.medicineTable.setNumberOfRows(self.reminders.count, withRowType: "MedicineRow")
            
            for index in 0..<self.medicineTable.numberOfRows {
                guard let controller = self.medicineTable.rowController(at: index) as? MedicineRowController else { continue }
                
                controller.reminder = self.reminders[index]
                let reminder = self.reminders[index]
                
                let register = registers.first(where: { $0.reminder?.id ?? "" == reminder.id })
                if register != nil {
                    controller.takedImageView.setImage(#imageLiteral(resourceName: "checked"))
                }
            }
            self.scene.ringCountLabel.text = "\(0)/\(self.reminders.count)"
            //            let fillRing =  CGFloat(registers.count) / CGFloat(self.reminders.count)
            //            self.scene.fillRing(to: fillRing)
            self.regostersCount = 0
        }) { (error) in
            print("Error fetching daily reminders: \(error)")
        }
        spriteScene.presentScene(scene)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        dayLabel.setText(dayFormatter.string(from: Date()))
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let reminderId = reminders[rowIndex].id
//        iOSManager.shared.set(reminderId: reminderId, as: true, at: Date())
        if let controller = self.medicineTable.rowController(at: rowIndex) as? MedicineRowController {
            controller.takedImageView.setImage(#imageLiteral(resourceName: "checked"))
        }
        regostersCount+=1
        scene.ringCountLabel.text = "\(regostersCount)/\(reminders.count)"
        let fill = CGFloat(regostersCount) / CGFloat(reminders.count)
        scene.fillRing(to: fill)
        
    }
    
}
