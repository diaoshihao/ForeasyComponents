//
//  ViewController.swift
//  ForeasyComponents
//
//  Created by diaoshihao on 10/09/2019.
//  Copyright (c) 2019 diaoshihao. All rights reserved.
//

import UIKit
import ForeasyComponents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        view.addSubview(FCButton(style: .top))
//        view.backgroundColor = UIColor.lightGray
        
        let field = FCTextField()
        field.backgroundColor = .white
        field.frame = CGRect(x: 20, y: 300, width: 300, height: 44)
        field.limit = .length(len: 10)
        field.hyDelegate = self
        
//        view.addSubview(field)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alert = FCAlertView()
        alert.title = "123"
        alert.message = "gdgoagioagoi"
        alert.appearance = ATestStyle()
        alert.tintColor = .init(hex: 0x39C33A)
        alert.addAction(action: .action(with: "cancel"))
        alert.addAction(action: .action(with: "aaaaa"))
        alert.addAction(action: .action(with: "bbbbb"))
        alert.addAction(action: .action(with: "ccccc"))
        alert.show()
        
        FCAlert.alert.show { (alert) in
            alert.title = "这是标题"
//            alert.message = "这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的提示信息"
            
            alert.isBackgroundTapHideEnabled = true
            alert.addAction(action: .action(with: "普通"))
            alert.addAction(action: .action(with: "普通"))
            alert.addAction(action: .action(with: "普通"))
            alert.addAction(action: .action(with: "普通"))
//            alert.addAction(action: .action(with: "高亮", style: .highlight))
//            alert.addAction(action: .action(with: "反显", style: .inversion))
//            alert.addAction(action: .action(with: "自定义", style: .custom(textColor: .red, bgColor: .white)))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
}

struct ATestStyle: FCAlertAppearance {
    var contentCorner: CGFloat = 3
    var contentWidth: FCAlertContentWidth = .regular(width: 223)
    var titleBackgroudColor: UIColor? = UIColor.init(hex: 0x515256)
    var messageBackgroudColor: UIColor? = .systemBlue
}

extension ViewController: FCTextFieldDelegate {
    
    func textFieldDidLimited(_ textField: FCTextField, limit: FCTextField.LimitInfoType) {
        FCToast.text("limited").show()
    }
    
}
