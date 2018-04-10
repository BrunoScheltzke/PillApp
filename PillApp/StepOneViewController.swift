//
//  StepOneViewController.swift
//  PillApp
//
//  Created by Homero Oliveira on 09/04/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class StepOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [#colorLiteral(red: 0.08235294118, green: 0.7176470588, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.5843137255, blue: 0.9490196078, alpha: 1)]
        view.applyGradient(colors: colors, gradientOrientation: .topLeftBottomRight)
        
        tranparentNavigationBar()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
