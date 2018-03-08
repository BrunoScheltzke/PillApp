//
//  MedicineRowController.swift
//  PillApp
//
//  Created by Raphael Braun on 06/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit

class MedicineRowController: NSObject {

    @IBOutlet var medicineNameLabel: WKInterfaceLabel!
    @IBOutlet var quantityLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var takedImageView: WKInterfaceImage!
    
    var medicine: Medicine? {
        didSet {
//            guard let medicine = medicine else { return }
//            medicineNameLabel.setText(medicine.name)
//            timeLabel.setText("20:49")
        }
    }
    
    var reminder: Reminder? {
        didSet {
            guard let reminder = reminder else {return}
            medicineNameLabel.setText(reminder.medicine.name)
            quantityLabel.setText(String(reminder.quantity))
            timeLabel.setText(String(describing: reminder.date))
        }
    }
}
