//
//  InterfaceController.swift
//  PillApp WatchKit Extension
//
//  Created by Bruno Scheltzke on 06/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit


class MedicineListController: WKInterfaceController {
    
    let medicines: [Medicine] = {
        var medicines: [Medicine] = []
        medicines.append(Medicine(name: "Parecetamol", quantity: 12, brand: nil, unit: nil))
        medicines.append(Medicine(name: "Tylenol", quantity: 12, brand: nil, unit: nil))
        medicines.append(Medicine(name: "Gelol", quantity: 12, brand: nil, unit: nil))
        medicines.append(Medicine(name: "Aspirina", quantity: 12, brand: nil, unit: nil))
        medicines.append(Medicine(name: "Sinvastatina", quantity: 12, brand: nil, unit: nil))
        medicines.append(Medicine(name: "Avamys", quantity: 12, brand: nil, unit: nil))
        return medicines
    }()
    
    @IBOutlet var medicineTable: WKInterfaceTable!
    @IBOutlet var spriteScene: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        medicineTable.setNumberOfRows(medicines.count, withRowType: "MedicineRow")
        
        for index in 0..<medicineTable.numberOfRows {
            guard let controller = medicineTable.rowController(at: index) as? MedicineRowController else { continue }
            
            controller.medicine = medicines[index]
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let scene = GameScene(size: CGSize(width: 45, height: 45))
        spriteScene.presentScene(scene)
        scene.show(at: CGPoint(x: scene.size.width / 2, y: scene.size.height / 2), diameter: scene.size.width)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("tomei")
    }
    
}
