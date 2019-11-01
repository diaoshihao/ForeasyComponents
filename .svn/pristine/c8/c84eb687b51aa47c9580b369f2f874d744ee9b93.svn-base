//
//  FCSinglePickerView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/25.
//


public class FCSinglePickerView {

    public enum TitleType {
        case none
        case auto
        case custom(title: String)
    }
    
    public typealias Handler = (Int, String) -> Void
    
    public var title: TitleType = .none {
        didSet {
            if case .none = title {
                header.titleLabel.text = nil
            } else if case let .custom(text) = title {
                header.titleLabel.text = text
            }
        }
    }
    public var headerHeight: CGFloat = 50.0
    
    private(set) var titles: [String] = []
    var _handler: Handler?
    let _picker: FCPickerView
    public private(set) var header: FCPickerHeaderView
    
    public init(with titles: [String], style: FCPickerViewStyle? = nil, header: FCPickerHeaderView? = nil) {
        self.titles = titles
        self.header = header ?? FCPickerHeaderView()
        _picker = FCPickerView(with: style)
        _picker.delegate = self
        _picker.dataSource = self
        
        self.header.leftItemBtn.addTarget(self, action: #selector(clickLeftItemAction), for: .touchUpInside)
        self.header.rightItembtn.addTarget(self, action: #selector(clickRightItemAction), for: .touchUpInside)
    }
    
    public func show() {
        _picker.show()
    }
    
    public func handler(_ handler: Handler?) {
        _handler = handler
    }
}

extension FCSinglePickerView {
    
    @objc func clickLeftItemAction() {
        _picker.hide()
    }
    
    @objc func clickRightItemAction() {
        guard let indexPath = _picker.selectedIndexPaths.first, indexPath.row < titles.count else { return }
        _handler?(indexPath.row, titles[indexPath.row])
    }
}

extension FCSinglePickerView: FCPickerViewDelegate {
    public func pickerView(_ pickerView: FCPickerView, didSelectRowAtIndexPath indexPath: IndexPath) {
        guard case .auto = title, indexPath.row < titles.count else { return }
        header.titleLabel.text = titles[indexPath.row]
    }
}

extension FCSinglePickerView: FCPickerViewDataSource {
    
    public func heightForHeader(in pickerView: FCPickerView) -> CGFloat {
        headerHeight
    }
    
    public func viewForHeader(in pickerView: FCPickerView) -> UIView? {
        header
    }
    
    public func numberOfComponent(in pickerView: FCPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: FCPickerView, numberOfRowsInComponent component: Int) -> Int {
        titles.count
    }
    
    public func pickerView(_ pickerView: FCPickerView, titleForRowAtIndexPath indexPath: IndexPath) -> String {
        titles[indexPath.row]
    }
}
