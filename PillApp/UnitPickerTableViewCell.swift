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
    var model = [Int]()
    var delegate: UnitCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for dosage in 1...500 {
            self.model.append(dosage)
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UnitPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
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
            delegate.update(unit: row + 1)
        }
    }
}
