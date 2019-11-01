//
//  FCButton.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/9/17.
//  Copyright © 2019 刁世浩. All rights reserved.
//


public class FCButton: UIButton {
    
    public var space: CGFloat = 3.0
    public var style: ButtonStyle? {
        didSet {
            setEdgeInsets(style: style ?? .left, space: space)
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var frame: CGRect {
        didSet {
            setEdgeInsets(style: style ?? .left, space: space)
        }
    }
}

public extension FCButton {
    convenience init(style buttonStyle: ButtonStyle?) {
        self.init()
        style = buttonStyle
    }
}
