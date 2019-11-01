//
//  FCPageContentView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/15.
//

public class FCPageContentView: UIView {
    public var index: Int {
        return _index
    }
    public var space: CGFloat = 0
    public var views: [UIView] = [] {
        didSet {
            pageViewsConfiguration()
        }
    }
    
    var _index: Int = 0 {
        didSet {
            if _index != oldValue {
                handler?(_index)
            }
        }
    }
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    public typealias PageHandler = (Int) -> Void
    var handler: PageHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space))
        }
        
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPage(index: Int) {
        if index < 0 || index >= views.count {
            return
        }
        self._index = index
        let view = views[index]
        scrollView.contentOffset = view.frame.origin
    }
    
    public func didChangePage(_ handler: PageHandler?) {
        self.handler = handler
    }
}

extension FCPageContentView {
    
    func pageViewsConfiguration() {
        if views.isEmpty {
            return
        }
        
        contentView.removeSubviews()
        
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = space
        stack.distribution = .fillEqually
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            make.width.equalTo(scrollView.snp.width).multipliedBy(views.count)
        }
    }
}

extension FCPageContentView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _index = Int(scrollView.contentOffset.x / scrollView.width)
    }
}
