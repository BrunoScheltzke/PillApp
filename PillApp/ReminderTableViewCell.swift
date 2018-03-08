//
//  ReminderTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var picker: UIDatePicker!

    @IBOutlet weak var tapView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.tapView.addGestureRecognizer(tapGestureRecognizer)

//        self.layoutSubviews()
//        self.setNeedsUpdateConstraints()
//        self.updateFocusIfNeeded()
//        self.setNeedsLayout()
//        self.layoutIfNeeded()

        self.picker.isHidden = true
        self.updatePickerHeightConstraint()
        
    }
    
    private func updatePickerHeightConstraint() {
        self.picker.translatesAutoresizingMaskIntoConstraints = false
        if self.picker.isHidden {
            self.picker.heightAnchor.constraint(equalToConstant: 0).isActive  = true
        } else {
            self.picker.heightAnchor.constraint(equalToConstant: 216).isActive = true
        }
    }
    
    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        if self.picker.isHidden {
            self.picker.isHidden = false
            self.updatePickerHeightConstraint()
        } else {
            self.picker.isHidden = true
            self.updatePickerHeightConstraint()
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
