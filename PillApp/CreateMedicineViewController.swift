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
    
    @IBOutlet weak var medicineNameTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var brandTxt: UITextField!
    @IBOutlet weak var unitTxt: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = appDelegate.persistentContainer
    }
    
    func saveMedicine(name: String, brand: String, unit: String, quantity: String) {
        let medicine = NSEntityDescription.insertNewObject(forEntityName: "MedicineCD",
                                                         into: container.viewContext) as! MedicineCD
        medicine.name = name
        medicine.quantity = Int32(quantity)!
        medicine.unit = Int32(unit)!
        medicine.brand = brand
        
        try? container.viewContext.save()
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        saveMedicine(name: medicineNameTxt.text!, brand: quantityTxt.text!, unit: unitTxt.text!, quantity: quantityTxt.text!)
        performSegue(withIdentifier: "unwindToList", sender: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
