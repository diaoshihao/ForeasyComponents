//
//  FCPickerable.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/11.
//


public protocol FCPickerable {
    var title: String? { get set }
    var leftTitle: String? { get set }
    var rightTitle: String? { get set }
    
    func show()
    func hide()
    
    func didTapLeftItem()
    func didTapRightItem()
}

public extension FCPickerable {
  
    func didTapLeftItem() { }
    
    func didTapRightItem() { }
}

public protocol FCPickerStyle {
    var titleFont: UIFont? { get set }
    var titleColor: UIColor? { get set }
    
    var leftTitleFont: UIFont? { get set }
    var leftTitleColor: UIColor? { get set }
    
    var rightTitleFont: UIFont? { get set }
    var rightTitleColor: UIColor? { get set }
    
    var titleViewBackgroudColor: UIColor? { get set }
    var contentViewBackgroundColor: UIColor? { get set }
}

public class FCPicker: FCPickerable {
    
    public var title: String? = nil
    
    public var leftTitle: String? = nil
    
    public var rightTitle: String? = nil
    
    public func show() {
        
    }
    
    public func hide() {
        
    }
    
    
}
