//
//  CreateReminderCoordinator.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 04/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class CreateReminderCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController
    var presenter: UIViewController
    
    init(presenter: UIViewController) {
        navigationController = UINavigationController()
        self.presenter = presenter
    }
    
    func start() {
        let createReminderVM = CreateReminderViewModel()
        let createReminderVC = CreateReminderViewController(viewModel: createReminderVM)
        navigationController.viewControllers = [createReminderVC]
        presenter.present(navigationController, animated: true, completion: nil)
    }
}
