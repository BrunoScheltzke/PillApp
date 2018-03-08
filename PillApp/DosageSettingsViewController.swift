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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DosageSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableview() {
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setDosageCell", for: indexPath) as! SetDosageTableViewCell

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setUnitCell", for: indexPath) as! SetUnitTableViewCell
            return cell
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//
//        }
        if indexPath.row == 0 {
            let cell = tableview.cellForRow(at: indexPath) as! SetDosageTableViewCell
            cell.dosageTxt.becomeFirstResponder()
//            print(cell.dosageTxt)
        } else {
//            let cell = tableview.cellForRow(at: indexPath) as! SetUnitTableViewCell
            
//            cell..becomeFirstResponder()
        }
    }
}
