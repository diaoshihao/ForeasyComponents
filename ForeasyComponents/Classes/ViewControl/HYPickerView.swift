//
//  HYPickerView.swift
//  HYLibarary
//
//  Created by 刁世浩 on 2019/9/19.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

extension HYPickerView {
    /// 选择器内容模式，自适应高度、显示行数、固定高度
    enum PickerContentMode {
        case adaptive(scrollEnable: Bool)
        case showRow(max: Int, scrollEnable: Bool)
        case fixed(height: Float, scrollEnable: Bool)
    }
}

extension HYPickerView {
    class HYPickerViewCell : UITableViewCell {
        let titleLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            titleLabel.textAlignment = .center
            contentView.addSubview(titleLabel)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            titleLabel.frame = bounds
        }
    }
}

protocol HYPickerDelegate : NSObjectProtocol {
    func didSelectRow(at index: Int, component: Int, text: String)
}

/// 标题视图协议
protocol HYPickerTitleView : UIView {
    var title: String? { get }
    var titleFont: UIFont? { get }
    var titleColor: UIColor? { get }
    
    var leftTitle: String? { get }
    var leftFont: UIFont? { get }
    var leftColor: UIColor? { get }
    
    var rightTitle: String? { get }
    var rightFont: UIFont? { get }
    var rightColor: UIColor? { get }
    
    var height: CGFloat { get }
    
}

extension HYPickerTitleView {
    var title: String? { return nil }
    var titleFont: UIFont? { return nil }
    var titleColor: UIColor? { return nil }
    
    var leftFont: UIFont? { return nil }
    var rightFont: UIFont? { return nil }
    var leftTitle: String? { return nil }
    
    var rightTitle: String? { return nil }
    var leftColor: UIColor? { return nil }
    var rightColor: UIColor? { return nil }
    
    var height: CGFloat { return 44.0 }
    
}

class HYPickerDefaultTitleView : UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.font = self.titleFont
        label.textColor = self.titleColor
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor)
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        return label
    }()
}

extension HYPickerDefaultTitleView : HYPickerTitleView {
    
}

class HYPickerView : UIControl {
    
    weak var delegate: HYPickerDelegate?
    
    var pickerTextFont: UIFont?
    var pickerTintColor: UIColor?
    
    var titleView: HYPickerTitleView = HYPickerDefaultTitleView()
    
    var isShowRowSeperator: Bool = true
    
    var rowHeight: CGFloat = 44.0
    var rowTextColor: UIColor = .black
    var rowBackgroundColor: UIColor = .white
    var rowTextFont: UIFont = .systemFont(ofSize: 15)
    
    var selectTextFont: UIFont?
    var selectTextColor: UIColor?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        addSubview(view)
        return view
    }()
    
    private let tagStart = 10000
    private var dataArr: [[String]] = []
    private var tableViews: [UITableView] = []
    
    // 多级选择时自适应内容高度无效，如未设置或自适应，固定高度 200
    private var mode: PickerContentMode = .adaptive(scrollEnable: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dataArr: [[String]], contentMode: PickerContentMode = .adaptive(scrollEnable: false)) {
        super.init(frame: .zero)
        self.dataArr = dataArr
        self.mode = contentMode
        show()
    }
}

extension HYPickerView {
    @objc func hide() {
        removeFromSuperview()
    }
    
    func show(animated: Bool = true) {
        prepareForShowInWindow()
        
        let superview = UIApplication.shared.keyWindow!
        superview.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true

    }
}

extension HYPickerView {
    func prepareForShowInWindow() {
        configPickerView()
    }
    
    func configPickerView() {
        if dataArr.isEmpty {
            fatalError("数组不能为空")
        }
        
        if dataArr.count > 1, case .adaptive = self.mode {
            self.mode = .fixed(height: 200, scrollEnable: true)
        }
        
        var height: CGFloat
        var isScrollEnable: Bool
        switch mode {
        case let .adaptive(scrollEnable):
            isScrollEnable = scrollEnable
            height = titleView.height + rowHeight * CGFloat(dataArr[0].count)
        case let .showRow(max, scrollEnable):
            isScrollEnable = scrollEnable
            height = titleView.height + rowHeight * CGFloat(max)
        case let .fixed(fixedHeight, scrollEnable):
            isScrollEnable = scrollEnable
            height = CGFloat(fixedHeight)
        }
        
        var left: CGFloat = 0
        var right: CGFloat = 0
        if #available(iOS 11.0, *) {
            left = safeAreaInsets.left
            right = safeAreaInsets.right
            height += safeAreaInsets.bottom
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: right).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        
        
        contentView.addSubview(titleView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: titleView.height)
        titleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        for (index, _) in dataArr.enumerated() {
            let tableview = UITableView(frame: .zero, style: .plain)
            tableview.delegate = self
            tableview.dataSource = self
            tableview.tag = tagStart + index
            tableview.tableFooterView = UIView()
            tableview.isScrollEnabled = isScrollEnable
            tableview.separatorInset = .zero
            tableview.separatorStyle = isShowRowSeperator ? .singleLine : .none
            tableview.register(HYPickerViewCell.classForCoder(), forCellReuseIdentifier: "HYPickerView")
            tableViews.append(tableview)
        }
        
        let stack = UIStackView(arrangedSubviews: tableViews)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
}

extension HYPickerView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = tableView.tag - tagStart
        if component >= dataArr.count { return }
        let array = dataArr[component]
        
        delegate?.didSelectRow(at: indexPath.row, component: component, text: array[indexPath.row])
    }
}

extension HYPickerView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let component = tableView.tag - tagStart
        if component >= dataArr.count { return 0 }
        return dataArr[component].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYPickerView") as! HYPickerViewCell
        
        let component = tableView.tag - tagStart
        if component >= dataArr.count { return cell }
        let array = dataArr[component]
        
        cell.titleLabel.text = array[indexPath.row]
        
        cell.titleLabel.font = rowTextFont
        cell.titleLabel.textColor = rowTextColor
        cell.titleLabel.backgroundColor = rowBackgroundColor
        
        return cell
    }
    
    
}
