//
//  FCDatePickerView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/31.
//

public extension FCDatePickerView {
    
    struct PickOption: OptionSet {
        public let rawValue: Int
        
        public static let year = PickOption(rawValue: 1 << 0)
        public static let month = PickOption(rawValue: 1 << 1)
        public static let day = PickOption(rawValue: 1 << 2)
        
        public static let hour = PickOption(rawValue: 1 << 3)
        public static let minute = PickOption(rawValue: 1 << 4)
        public static let second = PickOption(rawValue: 1 << 5)
        
        public static let date: PickOption = [.year, .month]
        public static let longDate: PickOption = [.year, .month, .day]
        public static let time: PickOption = [.hour, .minute]
        public static let longTime: PickOption = [.hour, .minute, .second]
        public static let dateAndTime: PickOption = [.month, .day, .hour, .minute]
        public static let longDateAndTime: PickOption = [.year, .month, .day, .hour, .minute, .second]
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    struct DateItem {
        var value: Int
        var type: Date.Component
        
        var suffix: String {
            switch type {
            case .year: return "年"
            case .month: return "月"
            case .day: return "日"
            case .hour: return "时"
            case .minute: return "分"
            case .second: return "秒"
            }
        }
        
    }
    
    struct PickerSection {
        var type: Date.Component
        var items: [DateItem]
    }
}

public class FCDatePickerView: FCPickerView {
    
    public typealias FormatDateString = String
    public typealias Handler = (Date?, FormatDateString?) -> Void
    
    public var maxDate: Date? = nil
    public var minDate: Date? = nil
    public var maxYear: Int = Date().year
    public var minYear: Int = 1970
    public var isShowSuffix: Bool = true
    public var format: String = ""

    public var option: PickOption = .date {
        didSet {
            getDateArrFromType()
        }
    }
    
    public var selectedDate: Date? {
        dateForSelected()
    }
    public var selectedItems: [DateItem] {
        itemsForSelected()
    }
    
    public var title: String? = nil {
        didSet {
            _header.titleLabel.text = title
        }
    }
    public var headerStyle: FCPickerHeaderViewStyle? = nil {
        didSet {
            setupHeaderStyle()
        }
    }
    public var headerHeight: CGFloat = 50.0
    
    var _dateArr: [PickerSection] = []
    let _calender = Calendar.current
    let _header = FCPickerHeaderView()
    var _handler: Handler? = nil
    
    public override init(with style: FCPickerViewStyle? = nil) {
        super.init(with: style)
        delegate = self
        dataSource = self
        getDateArrFromType()
        
        self._header.leftItemBtn.addTarget(self, action: #selector(clickLeftItemAction), for: .touchUpInside)
        self._header.rightItembtn.addTarget(self, action: #selector(clickRightItemAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func pickerHandler(_ handler: @escaping Handler) {
        _handler = handler
    }

}

extension FCDatePickerView {
    
    @objc func clickLeftItemAction() {
        hide()
    }
    
    @objc func clickRightItemAction() {
        hide()
        _handler?(selectedDate, selectedDate?.string(format))
    }
}

extension FCDatePickerView {
    
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
    
    func getDateArrFromType() {
        _dateArr.removeAll()
        
        if option.contains(.year) {
            let yearArr = _calender.years(from: minYear, to: maxDate?.year ?? maxYear).map { DateItem(value: $0, type: .year) }
            _dateArr.append(PickerSection(type: .year, items: yearArr))
        }
        if option.contains(.month) {
            let monthArr = _calender.months().map { DateItem(value: $0, type: .month) }
            _dateArr.append(PickerSection(type: .month, items: monthArr))
        }
        if option.contains(.day) {
            let dayArr = _calender.days(month: 1, year: minYear).map { DateItem(value: $0, type: .day) }
            _dateArr.append(PickerSection(type: .day, items: dayArr))
        }
        if option.contains(.hour) {
            let hourArr = _calender.hours().map { DateItem(value: $0, type: .hour) }
            _dateArr.append(PickerSection(type: .hour, items: hourArr))
        }
        if option.contains(.minute) {
            let minuteArr = _calender.minutes().map { DateItem(value: $0, type: .minute) }
            _dateArr.append(PickerSection(type: .minute, items: minuteArr))
        }
        if option.contains(.second) {
            let secondArr = _calender.seconds().map { DateItem(value: $0, type: .second) }
            _dateArr.append(PickerSection(type: .second, items: secondArr))
        }
    }
    
    func reloadDays() {
        guard let dayComponent = _dateArr.firstIndex(where: { $0.type == .day }) else { return }
        guard let year = (selectedItems.first { $0.type == .year }?.value) else { return }
        guard let month = (selectedItems.first { $0.type == .month }?.value) else { return }
        
        let dayArr = _calender.days(month: month, year: year).map { DateItem(value: $0, type: .day) }
        let replacingItem = PickerSection(type: .day, items: dayArr)
        
        _dateArr[dayComponent] = replacingItem
        reload(components: [dayComponent])
    }
        
    func itemsForSelected() -> [DateItem] {
        return selectedIndexPaths.map { (indexPath) -> DateItem? in
            guard indexPath.component < _dateArr.count else { return nil }
            let pickItem = _dateArr[indexPath.component]
            guard indexPath.row < pickItem.items.count else { return nil }
            return pickItem.items[indexPath.row]
        }.compactMap { $0 }
    }
    
    func dateForSelected() -> Date? {
        guard selectedItems.count > 0 else { return nil }
        var components = DateComponents()
        components.year = selectedItems.first { $0.type == .year }?.value
        components.month = selectedItems.first { $0.type == .month }?.value
        components.day = selectedItems.first { $0.type == .day }?.value
        components.hour = selectedItems.first { $0.type == .hour }?.value
        components.minute = selectedItems.first { $0.type == .minute }?.value
        components.second = selectedItems.first { $0.type == .second }?.value
        
        return _calender.date(from: components)
    }
    
    func component(for type: Date.Component) -> Int? {
        for (index, item) in _dateArr.enumerated() {
            if item.type == type { return index }
        }
        return nil
    }
    
    func row(for value: Int, at component: Int) -> Int? {
        guard component < _dateArr.count else { return nil }
        return _dateArr[component].items.firstIndex { $0.value == value }
    }
}

extension FCDatePickerView: FCPickerViewDelegate {

    public func pickerView(_ pickerView: FCPickerView, didSelectRowAtIndexPath indexPath: IndexPath) {
        if let style = headerStyle, let date = selectedDate, style.autoTitle {
            _header.titleLabel.text = date.string(format)
        }
        
        // 若有 day 类型，必要时刷新天数
        let item = _dateArr[indexPath.component]
        if item.type == .year || item.type == .month {
            reloadDays()
        }
        
        // 若设置了最大日期，将超过日期的设置到最大日期位置
        guard let date = maxDate else { return }
        var component = 0
        while component < _dateArr.count {
            let section = _dateArr[component]
            
            if let item = selectedItems.first(where: { $0.type == section.type }) {
                // 如果比最大日期小，后面就无需比较了
                if item.value < date.value(for: section.type) { return }
                if item.value > date.value(for: section.type), let row = row(for: date.value(for: section.type), at: component) {
                    selectRow(at: IndexPath(row: row, component: component), animated: true)
                }
            }
            component += 1
        }
        
    }
}

extension FCDatePickerView: FCPickerViewDataSource {
    public func viewForHeader(in pickerView: FCPickerView) -> UIView? {
        _header
    }
    
    public func heightForHeader(in pickerView: FCPickerView) -> CGFloat {
        headerHeight
    }
    
    public func numberOfComponent(in pickerView: FCPickerView) -> Int {
        _dateArr.count
    }
    
    public func pickerView(_ pickerView: FCPickerView, numberOfRowsInComponent component: Int) -> Int {
        _dateArr[component].items.count
    }
    
    public func pickerView(_ pickerView: FCPickerView, titleForRowAtIndexPath indexPath: IndexPath) -> String {
        let item = _dateArr[indexPath.component].items[indexPath.row]
        return item.value.string + (isShowSuffix ? item.suffix : "")
    }
}
