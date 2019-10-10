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
        messageLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        }
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
    
    func show(in view: UIView, image: UIImage, duration: TimeInterval, position: Position = .center) {
        imageView.image = image
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        }
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
    
    func show(in view: UIView, message: String, image: UIImage, duration: TimeInterval, position: Position = .center) {
        messageLabel.text = message
        
        imageView.image = image
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(0)
            make.left.greaterThanOrEqualTo(10)
            make.right.lessThanOrEqualTo(-10)
        }
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom).offset(10)
            make.centerX.equalTo(0)
            make.left.greaterThanOrEqualTo(10)
            make.right.lessThanOrEqualTo(-10)
            make.bottom.equalTo(-10)
        }
        
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
            contentView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(20)
            }
        case .center:
            contentView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        case .bottom:
            contentView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(-20)
            }
        case let .topOffset(y):
            contentView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(y)
            }
        case let .bottomOffset(y):
            contentView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(-y)
            }
        }
    }
}
