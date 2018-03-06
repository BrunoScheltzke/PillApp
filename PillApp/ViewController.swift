//
//  ViewController.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noMedicineImage: UIImageView!
    
    var medicines = [Medicine]()
    var daysOfWeek = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //medicines.append(Medicine(name: "Paracetamol", quantity: 9, brand: "", unit: 9))
        initTableView()
        verifyTableViewContent()
    }
    
    func verifyTableViewContent() {
        if medicines.count == 0 {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callPerform(tapGestureRecognizer:)))
            noMedicineImage.isUserInteractionEnabled = true
            noMedicineImage.addGestureRecognizer(tapGestureRecognizer)
            
            noMedicineImage.isHidden = false
            tableView.isHidden = true
            
        } else {
            noMedicineImage.isHidden = true
            tableView.isHidden = false
        }
    }
    
    @objc func callPerform(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "createMedicine", sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicineCell", for: indexPath) as! MedicineTableViewCell
        
        cell.medicine = medicines[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            medicines.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

