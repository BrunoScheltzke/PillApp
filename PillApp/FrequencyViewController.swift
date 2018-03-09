//
//  FrequenceViewController.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class FrequencyViewController: UIViewController {

    private var unwindToReminderFrequency = "unwindToReminderFrequency"
    @IBOutlet weak var tableView: UITableView!

    private var model = [Frequency.everySunday, Frequency.everyMonday, Frequency.everyTuesday, Frequency.everyWednesday, Frequency.everyThursday, Frequency.everyFriday, Frequency.everySaturday]
    
    var frequency = [Frequency]()
    
    

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.unwindToReminderFrequency {
            if let frequency = sender as? [Frequency] {
                if let destination = segue.destination as? ReminderFrequencyViewController {
                    destination.frequency = frequency
                }
            }
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: self.unwindToReminderFrequency, sender: nil)
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: self.unwindToReminderFrequency, sender: self.frequency)
    }
    
    
}

extension FrequencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FrequencyTableViewCell", for: indexPath) as! FrequencyTableViewCell
        let day = self.model[indexPath.row]
        cell.dayOfWeek = day
        cell.delegate = self
        if self.frequency.contains(day) {
            cell.check = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FrequencyTableViewCell
        cell.isSelected = false
        print(cell.check)
    }
}

extension FrequencyViewController: FrequencyTableViewCellDelegate {
    func update(day: Frequency, check: Bool) {
        let index = self.frequency.index { value -> Bool in
            value == day
        }
        if let index = index {
            self.frequency.remove(at: index)
        } else {
            self.frequency.append(day)
        }
    }
}
