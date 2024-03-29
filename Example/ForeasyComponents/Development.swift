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

struct DatePickerStyle: FCPickerViewStyle {
    var selectedTextColor: UIColor? = .systemBlue
    var selectedTextFont: UIFont? = .systemFont(ofSize: 20)
}

struct DatePickerHeader: FCPickerHeaderViewStyle {
    var title: String? = "Time"
    var autoTitle: Bool = true
    var titleFont: UIFont? = .systemFont(ofSize: 20)
    var rightItemTitleColor: UIColor? = .systemBlue
}

class DevelopmentController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
    }
    
    @objc func didTapView() {
        
        let picker = FCNormalPickerView(with: DatePickerStyle())
        picker.dataArr = [Int](0 ... 10).map { $0.string }
        picker.headerStyle = DatePickerHeader()
        picker.show(in: view)
        
        picker.pickerHandler { (index, string) in
            self.navigationItem.title = string
        }
    }
        
    @objc func injected() {
        view.removeSubviews()
        
    }
}


//==============================================================
//MARK: - workspace
//==============================================================

