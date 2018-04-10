//
//  StepOneViewController.swift
//  PillApp
//
//  Created by Homero Oliveira on 09/04/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

class StepOneViewController: UIViewController {
    
    @IBOutlet weak var topConstraintPillImage: NSLayoutConstraint!
    @IBOutlet weak var topConstraintText: NSLayoutConstraint!
    @IBOutlet weak var heightPillImage: NSLayoutConstraint!
    @IBOutlet weak var widthPillImage: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintNextButton: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [#colorLiteral(red: 0.08235294118, green: 0.7176470588, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.5843137255, blue: 0.9490196078, alpha: 1)]
        view.applyGradient(colors: colors, gradientOrientation: .topLeftBottomRight)
        
        tranparentNavigationBar()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    private func setUpKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
           self.topConstraintPillImage.constant = 0
            self.heightPillImage.constant = 0
            self.widthPillImage.constant = 0
            self.topConstraintText.constant = 0
            self.bottomConstraintNextButton.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.topConstraintPillImage.constant = 44
            self.heightPillImage.constant = 145
            self.widthPillImage.constant = 135
            self.topConstraintText.constant = 50
            self.bottomConstraintNextButton.constant = 36
            self.view.layoutIfNeeded()
        }
    }
}
