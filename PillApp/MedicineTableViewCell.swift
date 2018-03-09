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
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var medicine: Reminder! {
        didSet {
            nameLabel.text = medicine.medicine?.name
            quantityLabel.text = "Quant: \(medicine.medicine?.unit ?? 0)"
            let date = medicine.date ?? Date()
            hourLabel.text = "At \(dateFormatter.string(from: date))"
            colorView.backgroundColor = UIColor.red
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
