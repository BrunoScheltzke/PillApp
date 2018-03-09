//
//  FrequenceTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class FrequencyTableViewCell: UITableViewCell {
    
    var frequence: Frequency! {
        didSet {
            self.dayUILabel.text = "\(self.frequence!)"
        }
    }

    @IBOutlet weak var tapView: UIView!

    @IBOutlet private weak var checkUIImageView: UIImageView!
    
    var check: Bool = false {
        didSet {
            self.checkUIImageView.isHidden = !check
        }
    }

    @IBOutlet weak var dayUILabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.tapView.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        if self.checkUIImageView.isHidden {
            self.checkUIImageView.isHidden = false
        } else {
            self.checkUIImageView.isHidden = true
        }
    }

}
