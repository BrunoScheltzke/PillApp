//
//  RemindersViewController.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 03/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController {
    var viewModel: RemindersViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(type: ReminderItemTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RemindersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.reminderCellVMsByDate.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reminderCellVMsByDate[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderItemTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ReminderItemTableViewCell
            else { return UITableViewCell() }
        
        cell.viewModel = viewModel.reminderCellVMsByDate[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension RemindersViewController: UITableViewDelegate {
    
}
