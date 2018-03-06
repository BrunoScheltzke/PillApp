//
//  MedicineTableViewCell.swift
//  PillApp
//
//  Created by Arthur Giachini on 06/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    var medicine: MedicineCD! {
        didSet {
            nameLabel.text = medicine.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
