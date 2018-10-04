//
//  CreateReminderViewController.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 04/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Eureka

class CreateReminderViewController: FormViewController {

    var viewModel: CreateReminderViewModel!
    
    init(viewModel: CreateReminderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CreateReminderViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    func setupForm() {
        form +++ Section("Medicine")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter the medicine name here"
            }
            <<< PushRow<String>() {
                $0.title = "Dosage"
                $0.selectorTitle = "Select the dosage"
                $0.options = Dosage.allCases.map { $0.rawValue }
                $0.value = Dosage.allCases.first!.rawValue
            }
            <<< IntRow(){ row in
                row.title = "Quantity"
                row.placeholder = "Enter the quantity here"
            }
            +++ Section("Reminder")
            <<< PushRow<String>() {
                $0.title = "Frequency"
                $0.selectorTitle = "Select the Frequency"
                $0.options = Frequency.allCases.map { $0.asString() }
                $0.value = Frequency.allCases.first!.asString()
            }
            <<< TimeRow(){
                $0.title = "Hour"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
}
