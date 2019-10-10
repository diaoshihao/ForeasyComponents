//
//  HYNormalPicker.swift
//  HYLibarary
//
//  Created by 刁世浩 on 2019/9/20.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

class HYNormalPicker: HYPickerView {
    
}

protocol HYPickerDisplay {
    func show()
    func hide()
    
    func prepareForShow()
}

protocol HYPickerHeader: UIView {
    var height: CGFloat { get }
}

protocol HYPickerFooter: UIView {
    var height: CGFloat { get }
}

protocol HYPickerContent: UIView {
    var height: CGFloat { get }
}

extension HYPickerHeader {
    var height: CGFloat { return 0.0 }
}
extension HYPickerFooter {
    var height: CGFloat { return 0.0 }
}
extension HYPickerContent {
    var height: CGFloat { return 0.0 }
}

class HYBasePicker: UIViewController {
    enum DisplayType {
        case window
        case present
    }
    
    var headerView: HYPickerHeader?
    var footerView: HYPickerFooter?
    var contentView: HYPickerContent?
    let displayType = DisplayType.window
    
    var tapBackgroundHide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackground)))
    }
    
    @objc func didTapBackground() {
        if tapBackgroundHide {
            hide()
        }
    }
}

extension HYBasePicker: HYPickerDisplay {
    func prepareForShow() {
        let pickBackgroudView = UIView()
        view.addSubview(pickBackgroudView)
        pickBackgroudView.translatesAutoresizingMaskIntoConstraints = false
        pickBackgroudView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickBackgroudView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pickBackgroudView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if let header = headerView {
            pickBackgroudView.addSubview(header)
            header.translatesAutoresizingMaskIntoConstraints = false
            header.heightAnchor.constraint(equalToConstant: header.height).isActive = true
            header.topAnchor.constraint(equalTo: pickBackgroudView.topAnchor).isActive = true
            header.leftAnchor.constraint(equalTo: pickBackgroudView.leftAnchor).isActive = true
            header.rightAnchor.constraint(equalTo: pickBackgroudView.rightAnchor).isActive = true
        }
        
        if let header = headerView {
            pickBackgroudView.addSubview(header)
            header.translatesAutoresizingMaskIntoConstraints = false
            header.heightAnchor.constraint(equalToConstant: header.height).isActive = true
            header.topAnchor.constraint(equalTo: pickBackgroudView.topAnchor).isActive = true
            header.leftAnchor.constraint(equalTo: pickBackgroudView.leftAnchor).isActive = true
            header.rightAnchor.constraint(equalTo: pickBackgroudView.rightAnchor).isActive = true
        }
        
        if let header = headerView {
            pickBackgroudView.addSubview(header)
            header.translatesAutoresizingMaskIntoConstraints = false
            header.heightAnchor.constraint(equalToConstant: header.height).isActive = true
            header.topAnchor.constraint(equalTo: pickBackgroudView.topAnchor).isActive = true
            header.leftAnchor.constraint(equalTo: pickBackgroudView.leftAnchor).isActive = true
            header.rightAnchor.constraint(equalTo: pickBackgroudView.rightAnchor).isActive = true
        }
    }
    
    func show() {
        switch displayType {
        case .window:
            let superview = UIApplication.shared.keyWindow!
            superview.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            
        case .present:
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
        }
    }
    
    func hide() {
        switch displayType {
        case .window:
            view.removeFromSuperview()
        case .present:
            dismiss(animated: false, completion: nil)
        }
    }
}

extension HYBasePicker {
    enum Display {
        case window
        case present
        case display(atView: UIView)
    }
    
    
}

protocol PickerConfiguration {
    
}
