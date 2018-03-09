//
//  ReminderPickerTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class ReminderPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picker: UIDatePicker!

    var delegate: ReminderCellDelegate!
    var reminderTime: Date! {
        didSet {
            self.picker.date = reminderTime
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func pickerValueChanged(_ sender: UIDatePicker) {
        if let delegate = self.delegate {
            delegate.setReminderTime(with: sender.date)
        }
    }
    
}
