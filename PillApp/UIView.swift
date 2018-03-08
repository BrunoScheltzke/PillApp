//
//  UIView.swift
//  SwiftExt
//
//  Created by Homero Oliveira on 17/01/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView { }

@IBDesignable class DesignableButton: UIButton { }

extension UIView {
    
    @IBInspectable
    var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return layer.borderColor.map(UIColor.init)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return layer.shadowColor.map(UIColor.init)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
           layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
}

extension UIView {
    func lock() {
        guard viewWithTag(Int.min) == nil else {
            return
        }
        
        let subView = UIView()
        subView.tag = Int.min
        subView.backgroundColor = UIColor(white: 0, alpha: 0.10)
        addSubview(subView)
        subView.fillToParent()
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        subView.addSubview(activityIndicator)
        activityIndicator.centerToParent()
        activityIndicator.startAnimating()
    }
    
    func unlock() {
        UIView.animate(withDuration: 0.3) {
            self.viewWithTag(Int.min)?.removeFromSuperview()
        }
    }
}

extension UIView {
    func fillToParent(insets: UIEdgeInsets = .zero){
        guard let superView = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -insets.right).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left).isActive = true
        topAnchor.constraint(equalTo: superView.layoutMarginsGuide.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
    func centerToParent(offset: CGSize = .zero, size: CGSize? = nil) {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        if let size = size {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: offset.width).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: offset.height).isActive = true
    }
}
