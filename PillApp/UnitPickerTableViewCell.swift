//
//  UnitPickerTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 09/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class UnitPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var picker: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
