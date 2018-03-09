//
//  FrequenceTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class FrequencyTableViewCell: UITableViewCell {
    
    var dayOfWeek: Frequency! {
        didSet {
            self.dayUILabel.text = "\(self.dayOfWeek!)"
        }
    }
    
    var delegate: FrequencyTableViewCellDelegate?

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
    }

    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        self.check = !self.check
        if let delegate = self.delegate {
            delegate.update(day: self.dayOfWeek, check: self.check)
        }
    }

}
