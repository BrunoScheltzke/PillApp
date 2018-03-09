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
    var model = [Dosage.ml, Dosage.pill]
    
    var delegate: DosageCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.picker.delegate = self
        self.picker.dataSource = self
    }

}

extension DosagePickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.model.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.model[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let delegate = self.delegate {
            delegate.update(dosage: model[row])
        }
    }
}
