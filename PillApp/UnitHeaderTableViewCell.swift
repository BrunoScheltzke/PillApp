//
//  SetUnitTableViewCell.swift
//  PillApp
//
//  Created by Arthur Giachini on 08/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class UnitHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var unit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
//        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
//    @objc func actionTap(recognizer: UITapGestureRecognizer) {
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
