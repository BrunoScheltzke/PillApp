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
    
    var reminder: Reminder? {
        didSet {
            guard let reminder = reminder else {return}
            medicineNameLabel.setText(reminder.medicine.name)
            quantityLabel.setText("Quant: \(reminder.quantity)")
            timeLabel.setText("At \(dateFormatter.string(from: reminder.date))")
            let now = Date()
            if now > reminder.date {
                timeLabel.setTextColor(.red)
            } else {
                timeLabel.setTextColor(.white)
            }
        }
    }
}
