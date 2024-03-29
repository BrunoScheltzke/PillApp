//
//  CreateMedicineViewController.swift
//  PillApp
//
//  Created by Arthur Giachini on 06/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit
import CoreData

class CreateMedicineViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    var dosage: Dosage!
    var units: Int!
    
    @IBAction func unwindToCreateMedicine(segue: UIStoryboardSegue) {
        if let _ = self.dosage, let _ = self.units {
            self.nextButton.isEnabled = true
        }
    }

    @IBOutlet weak var medicineNameTxt: UITextField!
    @IBOutlet weak var colorsTableview: UITableView!
    @IBOutlet weak var bottomColorsTableviewConstraint: NSLayoutConstraint!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var container: NSPersistentContainer!
    

    var isOpen = false
    var indexColorsTableview = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = appDelegate.persistentContainer
        initTableView()
        initColorsTableview()
    }
    
    func saveMedicine(name: String) {
        let medicine = NSEntityDescription.insertNewObject(forEntityName: "Medicine",
                                                           into: container.viewContext) as! Medicine
        medicine.name = name
        try? container.viewContext.save()
    }
    
    @IBAction func save(_ sender: UIButton) {
        saveMedicine(name: medicineNameTxt.text!)
        performSegue(withIdentifier: "unwindToList", sender: nil)
    }
        
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToReminderFrequency", sender: nil)
    }

    // MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDosageSettings" {
            
        } else if segue.identifier == "goToReminderFrequency" {
            if let destination = segue.destination as? ReminderFrequencyViewController {
                destination.dosage = self.dosage
                destination.units = self.units
            }
        }
    }
}

extension CreateMedicineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func initColorsTableview() {
        colorsTableview.delegate = self
        colorsTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableview {
            return 2
        } else {
            return colors.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableview {
            if indexPath.row == 0 {
                let cell = self.tableview.dequeueReusableCell(withIdentifier: "DosageCell", for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorTableViewCell
//                cell.colorLabel.text = self.nameColors[indexColorsTableview]
//                cell.colorView.backgroundColor = self.colors[indexColorsTableview]
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorTableViewCell
            cell.colorLabel.text = colors[indexPath.row].0
            cell.colorView.backgroundColor = colors[indexPath.row].1
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableview {
            if indexPath.row == 0 {
                performSegue(withIdentifier: "showDosageSettings", sender: nil)
            } else if indexPath.row == 1 && isOpen == false {
                isOpen = true
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.3, delay: 0.11, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.bottomColorsTableviewConstraint.constant = 0
                    self.view.layoutIfNeeded()
                })
            } else if isOpen {
                isOpen = false
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.3, delay: 0.11, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.bottomColorsTableviewConstraint.constant = -352
                    self.view.layoutIfNeeded()
                })
                
            }
        } else {
            self.indexColorsTableview = indexPath.row
            self.tableview.reloadData()
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, delay: 0.11, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.bottomColorsTableviewConstraint.constant = -352
                self.view.layoutIfNeeded()
            })
            isOpen = false
        }
    }
}
