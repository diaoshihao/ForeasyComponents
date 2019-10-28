//
//  FCPageController.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/9/29.
//  Copyright © 2019 刁世浩. All rights reserved.
//

public extension FCPageController {
    typealias SpineLocation = UIPageViewController.SpineLocation
    typealias Direction = UIPageViewController.NavigationDirection
    
    enum Style {
        case scroll(space: CGFloat)
        case curl(spine: SpineLocation)
    }
}

/// FCPageController：添加分页控制器 FCPageViewController 作为子控制器的视图控制器
/// - index：分页控制器当前正在显示的视图索引，只读
/// - style：分页控制器样式，包括 scroll（滑动）和 curl（卷曲），只读
/// - viewControllers：已添加到分页控制器中的控制器，只读
/// - insets：分页控制器视图在父控制器中的边距，默认 zero
/// - showIndicator：是否显示索引视图（底部小圆点），默认不显示
public class FCPageController: UIViewController {    
    public var index: Int {
        return _pageViewController.index
    }
    public var style: Style {
        return _style
    }
    public var viewControllers: [UIViewController] {
        return _pageViewController.viewControllers ?? []
    }
    
    public var insets: UIEdgeInsets = .zero {
        didSet {
            _pageViewController.view.snp.updateConstraints { (make) in
                make.edges.equalTo(insets)
            }
        }
    }
    public var showIndicator: Bool = false {
        didSet {
            _pageViewController.showIndicator = showIndicator
        }
    }
    
    var _style: Style = .scroll(space: 0)
    var _pageViewController = FCPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    
    public init(with style: Style = .scroll(space: 0)) {
        super.init(nibName: nil, bundle: nil)
        self._style = style
        self.configPageViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configPageViewController() {
        switch style {
        case let .curl(spine):
            _pageViewController = FCPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: [.spineLocation:NSNumber(value: spine.rawValue)])
        case let .scroll(space):
            _pageViewController = FCPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.interPageSpacing:NSNumber(value: space.float)])
        }
        
        view.tintColor = .systemRed
        view.addSubview(_pageViewController.view)
        _pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(insets)
        }
        
        addChild(_pageViewController)
    }
}

public extension FCPageController {
    func setPage(to index: Int, animated: Bool = true) {
        _pageViewController.setPage(to: index, animated: animated)
    }
    
    func addPages(viewControllers: [UIViewController], asChild: Bool = true) {
        _pageViewController.addPages(viewControllers, asChild: asChild)
    }
    
    func didChangePage(_ handler: FCPageViewController.PageHandler?) {
        _pageViewController.didChangePage(handler)
    }
}
