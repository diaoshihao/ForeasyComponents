//
//  FCNormalPickerView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/25.
//


public class FCNormalPickerView: FCPickerView {
    
    public typealias Handler = (Int, String) -> Void
    
    public var dataArr: [String] = []
    
    public var headerHeight: CGFloat = 50.0
    public var headerStyle: FCPickerHeaderViewStyle? = nil {
        didSet {
            setupHeaderStyle()
        }
    }
    
    let _header = FCPickerHeaderView()
    var _handler: Handler?
    
    public override init(with style: FCPickerViewStyle? = nil) {
        super.init(with: style)
        
        delegate = self
        dataSource = self
        
        _header.leftItemBtn.addTarget(self, action: #selector(clickLeftItemAction), for: .touchUpInside)
        _header.rightItembtn.addTarget(self, action: #selector(clickRightItemAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func pickerHandler(_ handler: @escaping Handler) {
        _handler = handler
    }
}

extension FCNormalPickerView {
    
    @objc func clickLeftItemAction() {
        hide()
    }
    
    @objc func clickRightItemAction() {
        hide()
        guard let index = selectedIndexPaths.first?.row, index < dataArr.count else { return }
        let string = dataArr[index]
        _handler?(index, string)
    }
}

extension FCNormalPickerView {
    func setupHeaderStyle() {
        _header.seperator.backgroundColor = headerStyle?.seperatorColor
        
        _header.titleLabel.text = headerStyle?.title
        _header.titleLabel.font = headerStyle?.titleFont
        _header.titleLabel.textColor = headerStyle?.titleColor
        
        _header.leftItemBtn.titleLabel?.font = headerStyle?.leftItemTitleFont
        _header.leftItemBtn.setTitle(headerStyle?.leftItemTitle, for: .normal)
        _header.leftItemBtn.setTitleColor(headerStyle?.leftItemTitleColor, for: .normal)
        
        _header.rightItembtn.titleLabel?.font = headerStyle?.rightItemTitleFont
        _header.rightItembtn.setTitle(headerStyle?.rightItemTitle, for: .normal)
        _header.rightItembtn.setTitleColor(headerStyle?.rightItemTitleColor, for: .normal)
    }
}

extension FCNormalPickerView: FCPickerViewDelegate {
    public func pickerView(_ pickerView: FCPickerView, didSelectRowAtIndexPath indexPath: IndexPath) {
        if let style = headerStyle, indexPath.row < dataArr.count, style.autoTitle {
            _header.titleLabel.text = dataArr[indexPath.row]
        }
    }
}

extension FCNormalPickerView: FCPickerViewDataSource {
    public func viewForHeader(in pickerView: FCPickerView) -> UIView? {
        _header
    }
    
    public func heightForHeader(in pickerView: FCPickerView) -> CGFloat {
        headerHeight
    }
    
    public func numberOfComponent(in pickerView: FCPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: FCPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataArr.count
    }
    
    public func pickerView(_ pickerView: FCPickerView, titleForRowAtIndexPath indexPath: IndexPath) -> String {
        dataArr[indexPath.row]
    }
}
