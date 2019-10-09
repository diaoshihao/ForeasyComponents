//
//  HYToast.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/8.
//  Copyright © 2019 刁世浩. All rights reserved.
//

enum HYToast {
    case text(String)
}

public protocol HYToastViewStyle {
    var font: UIFont? { get }
    var textColor: UIColor? { get }
    var backgroundColor: UIColor? { get }
    var cornerRadius: CGFloat { get }
}

extension HYToastViewStyle {
    public var font: UIFont? {
        return .systemFont(ofSize: 15)
    }
    public var textColor: UIColor? {
        return .white
    }
    public var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.8)
    }
    public var cornerRadius: CGFloat {
        return 5.0
    }
}

public class HYToastView: HYToastViewStyle {
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = backgroundColor
        return contentView
    }()
    
    public init() { }
    
    func show(in view: UIView? = nil, message: String? = nil, image: UIImage? = nil, duration: TimeInterval) {
        
    }
    
    
}

public extension HYToastView {
    enum Position {
        case top
        case center
        case bottom
        case topOffset(y: CGFloat)
        case bottomOffset(y: CGFloat)
    }
}

public extension HYToastView {
    func show(in view: UIView, message: String, duration: TimeInterval, position: Position = .center) {
        messageLabel.text = message
        messageLabel.anchor(type: .edgeEqual(UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)))
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
    
    func show(in view: UIView, image: UIImage, duration: TimeInterval, position: Position = .center) {
        imageView.image = image
        imageView.anchor(type: .edgeEqual(UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)))
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
    
    func show(in view: UIView, message: String, image: UIImage, duration: TimeInterval, position: Position = .center) {
        messageLabel.text = message
        
        imageView.image = image
        
        imageView.anchor(type: .topEqualTo(contentView.topAnchor, 10))
        imageView.anchor(type: .centerXEqualSuperview(0))
        imageView.anchor(type: .leftGreaterThanTo(contentView.leftAnchor, 10))
        imageView.anchor(type: .rightLessThanTo(contentView.rightAnchor, -10))
        
        messageLabel.anchor(type: .topEqualTo(imageView.bottomAnchor, 10))
        messageLabel.anchor(type: .centerXEqualSuperview(0))
        messageLabel.anchor(type: .leftGreaterThanTo(contentView.leftAnchor, 10))
        messageLabel.anchor(type: .rightLessThanTo(contentView.rightAnchor, -10))
        messageLabel.anchor(type: .bottomEqualTo(contentView.bottomAnchor, -10))
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
}

extension HYToastView {
    func layout(in view: UIView, at position: Position) {
        if contentView.superview == nil {
            view.addSubview(contentView)
        }
        
        switch position {
        case .top:
            contentView.anchor(type: .centerXEqualSuperview(0))
            contentView.anchor(type: .topEqualTo(view.topAnchor, 20))
        case .center:
            contentView.anchor(type: .centerEqualToSuperview)
        case .bottom:
            contentView.anchor(type: .centerXEqualSuperview(0))
            contentView.anchor(type: .bottomEqualTo(view.bottomAnchor, -20))
        case let .topOffset(y):
            contentView.anchor(type: .centerXEqualSuperview(0))
            contentView.anchor(type: .topEqualTo(view.topAnchor, y))
        case let .bottomOffset(y):
            contentView.anchor(type: .centerXEqualSuperview(0))
            contentView.anchor(type: .bottomEqualTo(view.topAnchor, -y))
        }
    }
}
