//
//  FCPickerComponents.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/23.
//

//==============================================================
//MARK: - Picker Components
//==============================================================

public protocol FCPickerHeaderViewStyle {
    var title: String? { get }
    var autoTitle: Bool { get }
    var leftItemTitle: String? { get }
    var rightItemTitle: String? { get }
    
    var titleFont: UIFont? { get }
    var leftItemTitleFont: UIFont? { get }
    var rightItemTitleFont: UIFont? { get }
    
    var titleColor: UIColor? { get }
    var leftItemTitleColor: UIColor? { get }
    var rightItemTitleColor: UIColor? { get }
    
    var seperatorColor: UIColor? { get }
    var seperatorHeight: CGFloat { get }
}

public extension FCPickerHeaderViewStyle {
    var title: String? { nil }
    var autoTitle: Bool { true }
    var leftItemTitle: String? { "取消" }
    var rightItemTitle: String? { "确定" }
    
    var titleFont: UIFont? { nil }
    var leftItemTitleFont: UIFont? { nil }
    var rightItemTitleFont: UIFont? { nil }
    
    var titleColor: UIColor? { .black }
    var leftItemTitleColor: UIColor? { .black }
    var rightItemTitleColor: UIColor? { .black }
    
    var seperatorColor: UIColor? { .systemGray }
    var seperatorHeight: CGFloat { 1.0 / Device.scale }
}

public class FCPickerHeaderView: UIView {
    public let titleLabel = UILabel()
    public let leftItemBtn = UIButton(type: .custom)
    public let rightItembtn = UIButton(type: .custom)
    public let seperator = UIView()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        seperator.backgroundColor = .systemGray
        titleLabel.textAlignment = .center
        leftItemBtn.setTitle("取消", for: .normal)
        rightItembtn.setTitle("确定", for: .normal)
        leftItemBtn.setTitleColor(.black, for: .normal)
        rightItembtn.setTitleColor(.black, for: .normal)
        
        addSubview(seperator)
        addSubview(titleLabel)
        addSubview(leftItemBtn)
        addSubview(rightItembtn)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1.0 / Device.scale)
        }
        leftItemBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.top.left.bottom.equalTo(0)
        }
        rightItembtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.top.right.bottom.equalTo(0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(leftItemBtn.snp.right)
            make.right.equalTo(rightItembtn.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class FCPickerSupplementView: UIView {
    
    public var supplementHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: superview?.width ?? width, height: supplementHeight)
    }
}


class FCPickerContainerView: UIView { }

class FCPickerBackgroundView: UIControl {
    
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


