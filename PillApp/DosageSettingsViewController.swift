//
//  DosageSettingsViewController.swift
//  PillApp
//
//  Created by Arthur Giachini on 08/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class DosageSettingsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var dosageHeaderCellIdentifier = "DosageHeaderCell"
    var unitHeaderCellIdentifier = "UnitHeaderCell"
    var dosagePickerCellIdentifier = "DosagePickerCell"
    var unitPickerCellIdentifier = "UnitPickerCell"
    
    var dosage: Dosage!
    var units: Int!
    
    var isDosagePickerViewCellHide = true
    var isUnitPickerViewCellHide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToCreateMedicine", sender: nil)
    }

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToCreateMedicine" {
            let destination = segue.destination as! CreateMedicineViewController
            destination.dosage = self.dosage
            destination.units = self.units
        }
    }

}

extension DosageSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableview() {
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.isDosagePickerViewCellHide && !self.isUnitPickerViewCellHide {
            return 4
        } else if !self.isDosagePickerViewCellHide {
            return 3
        } else if !self.isUnitPickerViewCellHide {
            return 3
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.dosageHeaderCellIdentifier, for: indexPath) as! DosageHeaderTableViewCell
            return cell
        } else if (self.isDosagePickerViewCellHide && indexPath.row == 1) || (!self.isDosagePickerViewCellHide && indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.unitHeaderCellIdentifier, for: indexPath) as! UnitHeaderTableViewCell
            return cell
        } else if !self.isDosagePickerViewCellHide && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.dosagePickerCellIdentifier, for: indexPath) as! DosagePickerTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.unitPickerCellIdentifier, for: indexPath) as! UnitPickerTableViewCell
            cell.delegate = self
            return cell
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        if cell?.reuseIdentifier == self.dosageHeaderCellIdentifier {
            if self.isDosagePickerViewCellHide {
                self.isDosagePickerViewCellHide = !self.isDosagePickerViewCellHide
                let newIndexPath = IndexPath(row: 1, section: 0)
                self.tableview.insertRows(at: [newIndexPath], with: .fade)
            } else {
                self.isDosagePickerViewCellHide = !self.isDosagePickerViewCellHide
                let newIndexPath = IndexPath(row: 1, section: 0)
                self.tableview.deleteRows(at: [newIndexPath], with: .fade)
            }
        } else if cell?.reuseIdentifier == self.unitHeaderCellIdentifier {
            if self.isUnitPickerViewCellHide {
                self.isUnitPickerViewCellHide = !self.isUnitPickerViewCellHide
                
                let newIndexPath: IndexPath!
                if self.isDosagePickerViewCellHide {
                    newIndexPath = IndexPath(row: 2, section: 0)
                } else {
                    newIndexPath = IndexPath(row: 3, section: 0)
                }
                self.tableview.insertRows(at: [newIndexPath], with: .fade)
            } else {
                self.isUnitPickerViewCellHide = !self.isUnitPickerViewCellHide
                
                let newIndexPath: IndexPath!
                if self.isDosagePickerViewCellHide {
                    newIndexPath = IndexPath(row: 2, section: 0)
                } else {
                    newIndexPath = IndexPath(row: 3, section: 0)
                }
                self.tableview.deleteRows(at: [newIndexPath], with: .fade)
            }
        }
    }
}

extension DosageSettingsViewController: DosageCellDelegate {
    func update(dosage: Dosage) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableview.cellForRow(at: indexPath) as? DosageHeaderTableViewCell {
            cell.dosage.text = "\(dosage)"
            self.dosage = dosage
        }
    }
}

extension DosageSettingsViewController: UnitCellDelegate {
    func update(unit: Int) {
        var indexPath: IndexPath!
        
        if self.isDosagePickerViewCellHide {
            indexPath = IndexPath(row: 1, section: 0)
        } else {
            indexPath = IndexPath(row: 2, section: 0)
        }
        
        if let cell = self.tableview.cellForRow(at: indexPath) as? UnitHeaderTableViewCell {
            cell.unit.text = "\(unit)"
            self.units = unit
        }
    }
    
}
