//
//  ViewController.swift
//  ForeasyComponents
//
//  Created by diaoshihao on 10/09/2019.
//  Copyright (c) 2019 diaoshihao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Foreasy Components"
        
        view.backgroundColor = .systemRed
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    @objc func didTapView() {
        let dev = DevelopmentController()
        navigationController?.pushViewController(dev, animated: true)
    }
    
    @objc func injected() {
        print("I've been injected: \(self.description)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
}
