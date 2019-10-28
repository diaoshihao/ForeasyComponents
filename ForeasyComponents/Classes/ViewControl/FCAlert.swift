//
//  FCAlert.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/11.
//

//==============================================================
//MARK: - enum
//==============================================================

/// 示例
///
public enum FCAlert {
    public typealias AlertMaker = (FCAlertView) -> Void
    
    case alert
    case sheet
    
    public func show(maker: AlertMaker) {
        let alertView = FCAlertView()
        maker(alertView)
        switch self {
        case .alert:
            alertView.style = .alert
        case .sheet:
            alertView.style = .sheet
        }
        alertView.show()
    }
}

public enum FCAlertContentWidth {
    case automatic                  // 自动 >= 200 && margin <= 25
    case regular(width: CGFloat)    // 固定宽度
    case margin(margin: CGFloat)    // 固定边距
}

public enum FCActionStyle {
    case normal     // 普通（黑色字体，白色背景）
    case highlight  // 高亮（高亮字体，白色背景）
    case inversion  // 反显（白色字体，高亮背景）
    case custom(textColor: UIColor, bgColor: UIColor)
}

//==============================================================
//MARK: - protocol
//==============================================================

public protocol FCActionType {
    typealias ActionHandler = () -> Void
    
    var title: String { get set }
    var font: UIFont? { get set }
    var style: FCActionStyle? { get set }
    
    var handler: ActionHandler? { get set }
}

public protocol FCAlertAppearance {
    var topMargin: CGFloat { get }
    var leftMargin: CGFloat { get }
    var rightMargin: CGFloat { get }
    var bottomMargin: CGFloat { get }
    
    var contentCorner: CGFloat { get }
    var contentWidth: FCAlertContentWidth { get }
    
    var actionFont: UIFont? { get }
    var actionHeight: CGFloat { get }
    var seperatorColor: UIColor? { get }
    
    var titleFont: UIFont? { get }
    var titleColor: UIColor? { get }
    var titleBackgroudColor: UIColor? { get }
    var titleAligment: NSTextAlignment? { get }
    
    var messageFont: UIFont? { get }
    var messageColor: UIColor? { get }
    var messageBackgroudColor: UIColor? { get }
    var messageAligment: NSTextAlignment? { get }
    
}

public extension FCAlertAppearance {
    var topMargin: CGFloat {
        return 15
    }
    var leftMargin: CGFloat {
        return 25
    }
    var rightMargin: CGFloat {
        return 25
    }
    var bottomMargin: CGFloat {
        return 15
    }
    
    var actionHeight: CGFloat  {
        return 40
    }
    var contentCorner: CGFloat {
        return 14
    }
    var contentWidth: FCAlertContentWidth {
        return .automatic
    }
    
    var actionFont: UIFont? {
        return .systemFont(ofSize: 15)
    }
    var seperatorColor: UIColor? {
        return .groupTableViewBackground
    }
    
    var titleFont: UIFont? {
        return .systemFont(ofSize: 17)
    }
    var titleColor: UIColor? {
        return .black
    }
    var titleBackgroudColor: UIColor? {
        return .white
    }
    var titleAligment: NSTextAlignment? {
        return .center
    }
    var titleAttributed: [NSAttributedString.Key : Any]? {
        return nil
    }
    
    var messageFont: UIFont? {
        return .systemFont(ofSize: 14)
    }
    var messageColor: UIColor? {
        return .black
    }
    var messageBackgroudColor: UIColor? {
        return .white
    }
    var messageAligment: NSTextAlignment? {
        return .center
    }
    var messageAttributed: [NSAttributedString.Key : Any]? {
        return nil
    }
    
}

//==============================================================
//MARK: - struct
//==============================================================

public struct FCAlertAction: FCActionType {
    
    public var title: String
    public var font: UIFont?
    public var style: FCActionStyle?
    
    public var handler: ActionHandler?
}

public extension FCAlertAction {
    
    /// 实例化一个默认属性的 action
    ///
    /// - Parameter title: 标题
    /// - Parameter style: 样式
    /// - Parameter handler: 回调
    static func action(with title: String, style: FCActionStyle = .normal, handler: ActionHandler? = nil) -> FCAlertAction {
        return FCAlertAction(title: title, style: style, handler: handler)
    }
}

public struct FCAlertViewDefaultStyle : FCAlertAppearance { }

//==============================================================
//MARK: - FCAlertView
//==============================================================

public class FCAlertView: UIControl {
    public var title: String?
    public var message: String?
    public var attributedTitle: NSAttributedString?
    public var attributedMessage: NSAttributedString?
    
    public var style: Style = .alert
    public var appearance: FCAlertAppearance = FCAlertViewDefaultStyle()
    
    var type: TextType = .none
    var actions: [FCAlertAction] = []
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        titleBackgroundView.addSubview(label)
        return label
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        messageBackgroundView.addSubview(label)
        return label
    }()
    lazy var titleBackgroundView: UIView = {
        let view = UIView()
        contentView.addSubview(view)
        return view
    }()
    lazy var messageBackgroundView: UIView = {
        let view = UIView()
        contentView.addSubview(view)
        return view
    }()
    lazy var actionBackgroudView: UIView = {
        let view = UIView()
        contentView.addSubview(view)
        return view
    }()
    
    public var isBackgroundTapHideEnabled: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .systemBlue
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addTarget(self, action: #selector(tapForHide), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public extension FCAlertView {
    
    enum Style {
        case alert
        case sheet
    }

}

public extension FCAlertView {
    
    /// 快速实例化方法
    /// - Parameter title: 标题
    /// - Parameter message: 信息
    /// - Parameter style: 样式（默认 alert）
    /// - Parameter appearance: 外观
    convenience init(title: String?, message: String?, style: Style?, appearance: FCAlertAppearance?) {
        self.init()
        self.title = title
        self.message = message
        self.style = style ?? .alert
        self.appearance = appearance ?? FCAlertViewDefaultStyle()
    }
    
    /// 添加动作
    /// - Parameter action: action
    func addAction(action: FCAlertAction) {
        actions.append(action)
    }
}

public extension FCAlertView {
    
    func show() {
        
        prepareForShow()
        
        guard let window = UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first else { return }
        
        let isExist = window.subviews.contains { (view) -> Bool in
            return view.isKind(of: FCAlertView.self)
        }
        
        if isExist {
            print("已显示弹窗，请勿重复添加")
            return
        }
        
        window.addSubview(self)
        snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func hide() {
        removeFromSuperview()
    }
}

extension FCAlertView {
    
    @objc func tapForHide() {
        if isBackgroundTapHideEnabled {
            hide()
        }
    }
    
    @objc func tapAction(_ sender: UIButton) {
        let index = sender.tag - 100
        if index < actions.count {
            let action = actions[index]
            action.handler?()
        }
        hide()
    }
}

extension FCAlertView {
    
    struct TextType: OptionSet {
        let rawValue: Int
        
        static let title = TextType(rawValue: 1 << 0)
        static let message = TextType(rawValue: 1 << 1)
        
        static let none: TextType = []
        static let all: TextType = [.title, .message]
    }
    
    func prepareForShow() {
        if actions.isEmpty {
            fatalError("请添加 action！")
        }
    
        if title != nil || attributedTitle != nil {
            settingTitle()
            type.formUnion(.title)
        }
        
        if message != nil || attributedMessage != nil {
            settingMessage()
            type.formUnion(.message)
        }
        
        settingActions()
        
        switch style {
        case .alert:
            settingContentViewByAlertStyle()
        case .sheet:
            settingContentViewBySheetStyle()
        }
        
    }
    
    func settingTitle() {
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleColor
        titleLabel.textAlignment = appearance.titleAligment ?? .center
        
        if let alertTitle = title {
            titleLabel.text = alertTitle
        }
        if let alertAttrTitle = attributedTitle {
            titleLabel.attributedText = alertAttrTitle
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appearance.topMargin)
            make.left.equalTo(appearance.leftMargin)
            make.right.equalTo(-appearance.rightMargin)
            make.bottom.equalTo(-appearance.bottomMargin)
        }
        
        titleBackgroundView.backgroundColor = appearance.titleBackgroudColor
        titleBackgroundView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
    
    func settingMessage() {
        messageLabel.font = appearance.messageFont
        messageLabel.textColor = appearance.messageColor
        messageLabel.textAlignment = appearance.messageAligment ?? .left
        
        if let alertMessage = message {
            messageLabel.text = alertMessage
        }
        if let alertAttrMessage = attributedMessage {
            messageLabel.attributedText = alertAttrMessage
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appearance.topMargin)
            make.left.equalTo(appearance.leftMargin)
            make.right.equalTo(-appearance.rightMargin)
            make.bottom.equalTo(-appearance.bottomMargin)
        }
        
        messageBackgroundView.backgroundColor = appearance.messageBackgroudColor
        messageBackgroundView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(type.contains(.title) ? titleBackgroundView.snp.bottom : 0)
        }
    }
    
    func settingActions() {
        var tag = 100
        let buttons = actions.map { (action) -> UIButton in
            var titleColor: UIColor = .black
            var actionBackgroundColor: UIColor = .white
            switch action.style {
            case .highlight:
                titleColor = tintColor ?? .systemBlue
            case .inversion:
                titleColor = .white
                actionBackgroundColor = tintColor ?? .systemBlue
            case let .custom(textColor, bgColor):
                titleColor = textColor
                actionBackgroundColor = bgColor
            default:
                break
            }
            
            let button = UIButton(type: .custom)
            button.tag = tag
            button.backgroundColor = actionBackgroundColor
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = action.font ?? appearance.actionFont
            button.addTarget(self, action: #selector(tapAction(_:)), for: .touchUpInside)
            tag += 1
            return button
        }
        
        let topView: UIView? = type.contains(.message) ? messageBackgroundView : (type.contains(.title) ? titleBackgroundView : nil)
        
        actionBackgroudView.backgroundColor = appearance.seperatorColor
        actionBackgroudView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView == nil ? 0 : topView!.snp.bottom)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = appearance.seperatorColor ?? UIColor.groupTableViewBackground
        actionBackgroudView.addSubview(seperator)
        
        seperator.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.spacing = 1.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = buttons.count <= 2 ? .horizontal : .vertical
        actionBackgroudView.addSubview(stack)
        
        let height = buttons.count <= 2 ? appearance.actionHeight : CGFloat(buttons.count) * appearance.actionHeight
        
        stack.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.top.equalTo(seperator.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func settingContentViewByAlertStyle() {
        addSubview(contentView)
        contentView.layer.cornerRadius = appearance.contentCorner
        contentView.layer.masksToBounds = true
        
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        if case .automatic = appearance.contentWidth {
            contentView.snp.makeConstraints { (make) in
                make.width.greaterThanOrEqualTo(200)
                make.leftMargin.greaterThanOrEqualTo(25)
                make.rightMargin.lessThanOrEqualTo(-25)
            }
        }
        if case let .regular(width) = appearance.contentWidth {
            contentView.snp.makeConstraints { (make) in
                make.width.equalTo(width)
            }
        }
        if case let .margin(margin) = appearance.contentWidth {
            contentView.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(margin)
                make.rightMargin.equalTo(-margin)
            }
        }
    }
    
    func settingContentViewBySheetStyle() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
    }
}
