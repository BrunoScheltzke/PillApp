//
//  ReminderFrequenceViewController.swift
//  PillApp
//
//  Created by Eduardo Fornari on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class ReminderFrequencyViewController: UIViewController {

    var frequency = [Frequency]()
    @IBOutlet weak var tableView: UITableView!

    @IBAction func unwindToReminderFrequency(segue: UIStoryboardSegue) {
        print(frequency)
    }
    
    private var frequencyTableViewCellIdentifier = "FrequencyTableViewCell"
    private var reminderPickerTableViewCellIdentifier = "ReminderPickerTableViewCell"
    private var ReminderHeaderTableViewCellIdentifier = "ReminderHeaderTableViewCell"

    private var goToFrequencyViewControllerSegue = "goToFrequencyViewController"

    private var isReminderPickerViewCellVisible = true
    private var reminderTime: Date? = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.goToFrequencyViewControllerSegue {
            if let destination = segue.destination as? FrequencyViewController {
                destination.frequency = self.frequency
            }
        }
    }

}


extension ReminderFrequencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.ReminderHeaderTableViewCellIdentifier, for: indexPath) as! ReminderHeaderTableViewCell
            cell.delegate = self
            cell.reminderTime = reminderTime!
            return cell
        } else if (self.isReminderPickerViewCellVisible && indexPath.row == 1) || indexPath.row == 2 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.frequencyTableViewCellIdentifier, for: indexPath)
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reminderPickerTableViewCellIdentifier, for: indexPath) as! ReminderPickerTableViewCell
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isReminderPickerViewCellVisible {
            return 2
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier ==  self.frequencyTableViewCellIdentifier {
            performSegue(withIdentifier: self.goToFrequencyViewControllerSegue, sender: nil)
        }
    }
}

extension ReminderFrequencyViewController: ReminderCellDelegate { 
    func setReminderTime(with time: Date) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableView.cellForRow(at: indexPath) as? ReminderHeaderTableViewCell {
            cell.reminderTime = time
            self.reminderTime = time
        }
    }
    
    func setVisibilityPicker(with visible: Bool) {
        self.isReminderPickerViewCellVisible = visible
        let indexPath = IndexPath(row: 1, section: 0)
        if visible {
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }
    }
}
