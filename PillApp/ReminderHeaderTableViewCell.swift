//
//  ReminderHeaderTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class ReminderHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var reminderTimeUILabel: UILabel!
    var reminderTime: Date! {
        didSet {
            self.setReminderTime(with: reminderTime)
        }
    }

    var hide: Bool!

    var delegate: ReminderCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.hide = true

        self.reminderTimeUILabel.text = ""
        
        let tapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.tapView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            delegate.setVisibilityPicker(with: !self.hide)
            self.hide = !self.hide
        }
    }
    
    private func setReminderTime(with time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let hour = dateFormatter.string(from: time)
        self.reminderTimeUILabel.text = "\(hour)"
    }

}
