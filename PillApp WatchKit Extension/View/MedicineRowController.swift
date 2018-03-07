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
    @IBOutlet var timeLabel: WKInterfaceLabel!
    
    var medicine: Medicine? {
        didSet {
            guard let medicine = medicine else { return }
            medicineNameLabel.setText(medicine.name)
            timeLabel.setText("20:49")
        }
    }
    
}
