//
//  FCToast.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/8.
//  Copyright © 2019 刁世浩. All rights reserved.
//

public enum FCToast {
    
    case text(String)
    case image(UIImage)
    case message(String, UIImage)
    
    public func show(in view: UIView? = nil, duration: TimeInterval = 2.0, position: FCToastView.Position = .center) {
        guard let superview = view ?? UIApplication.shared.keyWindow else {
            print("无法获取 keyWindow!")
            return
        }
        let toast = FCToastView()
        
        switch self {
        case let .text(text):
            toast.show(in: superview, message: text, duration: duration, position: position)
        case let .image(image):
            toast.show(in: superview, image: image, duration: duration, position: position)
        case let .message(text, image):
            toast.show(in: superview, message: text, image: image, duration: duration, position: position)
        }
    }
}

public protocol FCToastViewStyle {
    var font: UIFont? { get set }
    var textColor: UIColor? { get set }
    var backgroundColor: UIColor? { get }
    var cornerRadius: CGFloat { get set }
}

//extension FCToastViewStyle {
//
//    public var font: UIFont? {
//        return .systemFont(ofSize: 15)
//    }
//    public var textColor: UIColor? {
//        return .white
//    }
//    public var backgroundColor: UIColor? {
//        return UIColor.black.withAlphaComponent(0.8)
//    }
//    public var cornerRadius: CGFloat {
//        return 5.0
//    }
//}

public class FCToastView: FCToastViewStyle {
    public var font: UIFont? = .systemFont(ofSize: 15)
    
    public var cornerRadius: CGFloat = 5.0
    
    public var backgroundColor: UIColor? = UIColor.black.withAlphaComponent(0.8)
    
    public var textColor: UIColor? = .white
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = font
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
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }()
    
    public init() { }
    
}

public extension FCToastView {
    enum Position {
        case top
        case center
        case bottom
        case topOffset(y: CGFloat)
        case bottomOffset(y: CGFloat)
    }
}

public extension FCToastView {
    func show(in view: UIView, message: String, duration: TimeInterval, position: Position = .center) {
        messageLabel.text = message
        messageLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        layout(in: view, at: position)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.contentView.removeFromSuperview()
        }
    }
    
    func show(in view: UIView, image: UIImage, duration: TimeInterval, position: Position = .center) {
        imageView.image = image
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
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

extension FCToastView {
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
