//
//  FrequenceViewController.swift
//  PillApp
//
//  Created by Eduardo Fornari on 08/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class FrequencyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

//    case everySunday
//    case everyMonday
//    case everyTuesday
//    case everyWednesday
//    case everyThursday
//    case everyFriday
//    case everySaturday
//    case everyDay
    private var model = [Frequency.everySunday, Frequency.everyMonday, Frequency.everyTuesday, Frequency.everyWednesday, Frequency.everyThursday, Frequency.everyFriday, Frequency.everySaturday]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension FrequencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FrequencyTableViewCell", for: indexPath) as! FrequencyTableViewCell
        cell.frequence = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
}
