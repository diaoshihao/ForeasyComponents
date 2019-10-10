//
//  HYButton.swift
//  HYLibarary
//
//  Created by 刁世浩 on 2019/9/17.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

class HYButton: UIButton {
    
    var space: CGFloat = 3.0
    var style: ButtonStyle? {
        didSet {
            setEdgeInsets(style: style ?? .left, space: space)
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(style buttonStyle: ButtonStyle?) {
        self.init()
        style = buttonStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            setEdgeInsets(style: style ?? .left, space: space)
        }
    }
}
