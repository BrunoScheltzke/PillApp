//
//  SetDosageTableViewCell.swift
//  PillApp
//
//  Created by Arthur Giachini on 08/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class SetDosageTableViewCell: UITableViewCell {

    @IBOutlet weak var dosageTxt: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dosageTxt.tintColor = UIColor.clear
        dosageTxt.keyboardType = .numberPad
        dosageTxt.textAlignment = .right
        //self.dosageTxt.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func becomeFirstResponder() -> Bool {
        return dosageTxt.becomeFirstResponder()
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
}

extension SetDosageTableViewCell: UITextFieldDelegate {
    
    
    
}
