//
//  FCPageHeaderView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/15.
//

public extension FCPageHeaderView {
    
    /// 标签栏样式
    /// - regular: 平均分配标签宽度
    /// - scroll：自定义标签宽度，可滑动
    enum Style {
        case regular
        case scroll(itemWidth: CGFloat)
    }
}

public struct FCPageBarStyle {
    public enum Width {
        case none
        case auto
        case regular
        case custom(width: CGFloat)
    }
    
    public var width: Width
    public var height: CGFloat
    public var color: UIColor?
    
    public static let none = FCPageBarStyle(width: .none, height: 0, color: nil)
    public static let auto = FCPageBarStyle(width: .auto, height: 2, color: nil)
    public static let regular = FCPageBarStyle(width: .regular, height: 2, color: nil)
    
    public init(width: Width, height: CGFloat, color: UIColor?) {
        self.width = width
        self.height = height
        self.color = color
    }
}

/// 标签栏视图
public class FCPageHeaderView: UIView {
    public var index: Int {
        return _index
    }
    public var titles: [String] = [] {
        didSet {
            _collectionView.reloadData()
        }
    }
    public var style: Style = .regular
    public var barStyle: FCPageBarStyle = .auto {
        didSet {
            setBarStyle()
        }
    }

    public typealias TitleHandler = (Int) -> Void
    
    typealias TitleCell = FCTextCollectionViewCell
    var _handler: TitleHandler?
    
    var _index: Int = 0
    
    var _normalTitleFont: UIFont = .systemFont(ofSize: 16)
    var _selectTitleFont: UIFont = .systemFont(ofSize: 16)
    
    var _normalTitleColor: UIColor = .black
    var _selectedTitleColor: UIColor = .black
    
    var _normalItemColor: UIColor = .clear
    var _selectedItemColor: UIColor = .clear
    
    let _barView = UIView()
    let _collectionView: UICollectionView
            
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        _collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        _collectionView.bounces = false
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = .white
        _collectionView.showsVerticalScrollIndicator = false
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.registerReusableCell(class: TitleCell.self)
        addSubview(_collectionView)
        
        _collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updateBar()
    }
}

extension FCPageHeaderView {
    
    func setBarStyle() {
        _barView.removeFromSuperview()
        
        if case .none = barStyle.width {
            return
        }
        
        addSubview(_barView)
        _barView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(0)
            make.height.equalTo(barStyle.height)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateBar() {
        if case .none = barStyle.width {
            return
        }
        
        if _index >= titles.count {
            return
        }
        
        _barView.backgroundColor = barStyle.color ?? _selectedTitleColor
        let itemWidth = _collectionView.width / titles.count.cgFloat
        var barX = itemWidth * _index.cgFloat
        var barWidth = itemWidth
        
        if case .auto = barStyle.width {
            let str = titles[_index] as NSString
            barWidth = str.size(withAttributes: [.font: _selectTitleFont]).width
        } else if case let .custom(width) = barStyle.width {
            barWidth = width
        }
        barX += (itemWidth - barWidth) / 2.0
        
        UIView.animate(withDuration: 0.25) {
            self._barView.snp.updateConstraints { (make) in
                make.left.equalTo(barX)
                make.width.equalTo(barWidth)
            }
            self.layoutIfNeeded()
        }
    }
}

public extension FCPageHeaderView {
    func setTitleFont(normal: UIFont, selected: UIFont) {
        _normalTitleFont = normal
        _selectTitleFont = selected
    }
    
    func setTitleColor(normal: UIColor, selected: UIColor) {
        _normalTitleColor = normal
        _selectedTitleColor = selected
    }
    
    func setItemColor(normal: UIColor, selected: UIColor) {
        _normalItemColor = normal
        _selectedItemColor = selected
    }
    
    func setIndex(_ index: Int) {
        if index >= titles.count { return }
        let indexPath = IndexPath(item: index, section: 0)
        didSelectItem(at: indexPath)
    }
    
    func didSelectIndex(_ handler: TitleHandler?) {
        self._handler = handler
    }
}

extension FCPageHeaderView {
    func didSelectItem(at indexPath: IndexPath) {
        if _index != indexPath.item {
            let preIndexPath = IndexPath(item: _index, section: 0)
            _index = indexPath.item
            
            _collectionView.reloadItems(at: [indexPath, preIndexPath])
            updateBar()
        }
    }
}

extension FCPageHeaderView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.width / titles.count.cgFloat
        if case let .scroll(itemWidth) = style {
            width = itemWidth
        }
        return CGSize(width: width, height: collectionView.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(at: indexPath)
        _handler?(_index)
    }
}

extension FCPageHeaderView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(class: TitleCell.self, for: indexPath)
        
        cell.textLabel.text = titles[indexPath.item]
        
        let isSelected = indexPath.item == _index
        cell.textLabel.font = isSelected ? _selectTitleFont : _normalTitleFont
        cell.textLabel.textColor = isSelected ? _selectedTitleColor : _normalTitleColor
        cell.textLabel.backgroundColor = isSelected ? _selectedItemColor : _normalItemColor

        return cell
    }
    
}
