//
//  Development.swift
//  ForeasyComponents_Example
//
//  Created by 刁世浩 on 2019/10/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import ForeasyComponents

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

class DevelopmentController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        injected()
        
        var titles: [String] = []
        for index in 0 ..< 100 {
            titles.append(index.string)
        }
        let picker = FCSinglePickerView(with: titles, style: FCSinglePickerViewStyle())
        picker.title = .auto
        picker.header.leftItemBtn.setTitleColor(.systemBlue, for: .normal)
        picker.header.rightItembtn.setTitleColor(.systemBlue, for: .normal)
        
        picker.show()
        
        picker.handler { (index, title) in
            print("The selected is at index of \(index) which title is \(title)")
        }
    }
        
    @objc func injected() {
        view.removeSubviews()
        
    }
}


//==============================================================
//MARK: - workspace
//==============================================================

struct FCSinglePickerViewStyle: FCPickerViewStyle {
    var selectedTextColor: UIColor? = .systemBlue
}
