//
//  FCPickerView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/23.
//


public protocol FCPickerViewDataSource {
    func heightForHeader(in pickerView: FCPickerView) -> CGFloat
    func heightForFooter(in pickerView: FCPickerView) -> CGFloat

    func viewForHeader(in pickerView: FCPickerView) -> UIView?
    func viewForFooter(in pickerView: FCPickerView) -> UIView?
    
    func numberOfComponent(in pickerView: FCPickerView) -> Int
    func pickerView(_ pickerView: FCPickerView, numberOfRowsInComponent component: Int) -> Int
    func pickerView(_ pickerView: FCPickerView, titleForRowAtIndexPath indexPath: IndexPath) -> String
}

public protocol FCPickerViewDelegate {
    func pickerView(_ pickerView: FCPickerView, willSelectRowAtIndexPath indexPath: IndexPath)
    func pickerView(_ pickerView: FCPickerView, willDeselectRowAtIndexPath indexPath: IndexPath)
    func pickerView(_ pickerView: FCPickerView, didSelectRowAtIndexPath indexPath: IndexPath)
    func pickerView(_ pickerView: FCPickerView, didDeselectRowAtIndexPath indexPath: IndexPath)
}

public extension FCPickerViewDataSource {
    func viewForHeader(in pickerView: FCPickerView) -> UIView? { return nil }
    func viewForFooter(in pickerView: FCPickerView) -> UIView? { return nil }

    func heightForHeader(in pickerView: FCPickerView) -> CGFloat { return 0 }
    func heightForFooter(in pickerView: FCPickerView) -> CGFloat { return 0 }

    func heightForRow(in pickerView: FCPickerView) -> CGFloat { return 44.0 }
}

public extension FCPickerViewDelegate {
    func pickerView(_ pickerView: FCPickerView, willSelectRowAtIndexPath indexPath: IndexPath) { }
    func pickerView(_ pickerView: FCPickerView, willDeselectRowAtIndexPath indexPath: IndexPath) { }
    func pickerView(_ pickerView: FCPickerView, didSelectRowAtIndexPath indexPath: IndexPath) { }
    func pickerView(_ pickerView: FCPickerView, didDeselectRowAtIndexPath indexPath: IndexPath) { }
}

public protocol FCPickerViewStyle: FCPickerStyle {
    var isTapBlankHideEnable: Bool { get }
    
    var viewForHeader: UIView? { get }
    var viewForFooter: UIView? { get }
    
    var heightForHeader: CGFloat { get }
    var heightForFooter: CGFloat { get }
}

public extension FCPickerViewStyle {
    var isTapBlankHideEnable: Bool { true }
    
    var viewForHeader: UIView? { nil }
    var viewForFooter: UIView? { nil }
    
    var heightForHeader: CGFloat { 0 }
    var heightForFooter: CGFloat { 0 }
}

public struct FCPickerViewDefaultStyle: FCPickerViewStyle { }

public class FCPickerView: UIView {
    
    public var delegate: FCPickerViewDelegate?
    public var dataSource: FCPickerViewDataSource?
    
    public var selectedIndexPaths: [IndexPath] {
        return _pickerTableView.selectedIndexPath
    }
        
    var _style: FCPickerViewStyle
    
    let _container = FCPickerContainerView()
    let _backgroundView = FCPickerBackgroundView()
    let _pickerTableView: FCPickerTableView
    var _pickerHeaderView = FCPickerSupplementView()
    let _pickerFooterView = FCPickerSupplementView()

    
    public init(with style: FCPickerViewStyle? = nil) {
        _style = style ?? FCPickerViewDefaultStyle()
        _pickerTableView = FCPickerTableView(with: _style)
        
        super.init(frame: .zero)
        
        _backgroundView.addTarget(self, action: #selector(didTapBlankArea), for: .touchUpInside)
        
        addSubview(_backgroundView)
        _backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        _pickerTableView.delegate = self
        _pickerTableView.dataSource = self
        
        _backgroundView.addSubview(_container)
        _container.addSubview(_pickerHeaderView)
        _container.addSubview(_pickerTableView)
        _container.addSubview(_pickerFooterView)
        
        _container.backgroundColor = .white
        _container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
        }
        
        _pickerHeaderView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.height.equalTo(_style.heightForHeader)
        }
        
        _pickerTableView.snp.makeConstraints { (make) in
            make.top.equalTo(_pickerHeaderView.snp.bottom)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }
        
        _pickerFooterView.snp.makeConstraints { (make) in
            make.height.equalTo(_style.heightForFooter)
            make.top.equalTo(_pickerTableView.snp.bottom)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.bottomMargin.equalTo(snp.bottomMargin)
        }
        
        if let header = _style.viewForHeader {
            _pickerHeaderView.addSubview(header)
            header.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
        
        if let footer = _style.viewForFooter {
            _pickerFooterView.addSubview(footer)
            footer.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSupplementView()
    }
    
    func layoutSupplementView() {
        let headerHeight = dataSource?.heightForHeader(in: self) ?? _style.heightForHeader
        _pickerHeaderView.snp.updateConstraints { (make) in
            make.height.equalTo(headerHeight)
        }
        
        let footerHeight = dataSource?.heightForFooter(in: self) ?? _style.heightForFooter
        _pickerFooterView.snp.updateConstraints { (make) in
            make.height.equalTo(footerHeight)
        }
        
        if let header = dataSource?.viewForHeader(in: self) {
            _pickerHeaderView.removeSubviews()
            _pickerHeaderView.addSubview(header)
            header.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
        
        if let footer = _style.viewForFooter {
            _pickerFooterView.removeSubviews()
            _pickerFooterView.addSubview(footer)
            footer.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapBlankArea() {
        if _style.isTapBlankHideEnable {
            removeFromSuperview()
        }
    }
}

public extension FCPickerView {
    func hide() {
        removeFromSuperview()
    }
    
    func show(in view: UIView? = nil) {
        guard let atView = view ?? Application.window else { return }
        atView.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func selectRow(at indexPath: IndexPath?, animated: Bool) {
        _pickerTableView.selectRow(at: indexPath, animated: animated)
    }
    
    func selectRows(at indexPaths: [IndexPath]?, animated: Bool) {
        _pickerTableView.selectRows(at: indexPaths, animated: animated)
    }
    
    func reload(indexPaths: [IndexPath]?) {
        _pickerTableView.reload(indexPaths: indexPaths)
    }
    
    func reload(components: [Int]) {
        _pickerTableView.reload(components: components)
    }
    
    func reloadAllComponents() {
        _pickerTableView.reloadAllComponents()
    }
}

extension FCPickerView: FCPickerTableViewDelegate {
    func tableView(_ tableView: FCPickerTableView, willSelectRowAtIndexPath indexPath: IndexPath) {
        delegate?.pickerView(self, willSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(_ tableView: FCPickerTableView, willDeselectRowAtIndexPath indexPath: IndexPath) {
        delegate?.pickerView(self, willDeselectRowAtIndexPath: indexPath)
    }
    
    func tableView(_ tableView: FCPickerTableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        delegate?.pickerView(self, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(_ tableView: FCPickerTableView, didDeselectRowAtIndexPath indexPath: IndexPath) {
        delegate?.pickerView(self, didDeselectRowAtIndexPath: indexPath)
    }
}

extension FCPickerView: FCPickerTableViewDataSource {
    
    func numberOfComponents(in tableView: FCPickerTableView) -> Int {
        return dataSource?.numberOfComponent(in: self) ?? 0
    }
    
    func tableView(_ tableView: FCPickerTableView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.pickerView(self, numberOfRowsInComponent: component) ?? 0
    }
    
    func tableView(_ tableView: FCPickerTableView, titleForRowAtIndexPath indexPath: IndexPath) -> String {
        return dataSource?.pickerView(self, titleForRowAtIndexPath: indexPath) ?? ""
    }
}
