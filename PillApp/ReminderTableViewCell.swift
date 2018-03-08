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
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.tapView.addGestureRecognizer(tapGestureRecognizer)
//        self.stackView.translatesAutoresizingMaskIntoConstraints = false

//        self.layoutSubviews()
//        self.setNeedsUpdateConstraints()
//        self.updateFocusIfNeeded()
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
        
//        self.translatesAutoresizingMaskIntoConstraints = false

//        self.picker.isHidden = true
        
    }
    
    private func updatePickerHeightConstraint() {
        self.contentView.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            if self.picker.isHidden {
                self.picker.heightAnchor.constraint(equalToConstant: 0).isActive  = true
            } else {
                self.picker.heightAnchor.constraint(equalToConstant: 216).isActive = true
            }
            self.contentView.layoutIfNeeded()
        }
    }
    
    
    
    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        updatePickerHeightConstraint()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
