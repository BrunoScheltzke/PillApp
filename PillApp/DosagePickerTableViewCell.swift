//
//  DosagePickerTableViewCell.swift
//  PillApp
//
//  Created by Eduardo Fornari on 09/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class DosagePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var picker: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.picker.delegate = self
        self.picker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DosagePickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
}
