//
//  UINavigationController.swift
//  PillApp
//
//  Created by Homero Oliveira on 09/04/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

extension UIViewController {
    func tranparentNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
}
