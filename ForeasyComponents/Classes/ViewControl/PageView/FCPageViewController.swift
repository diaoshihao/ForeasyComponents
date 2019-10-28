//
//  FCPageViewController.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/18.
//


/// 继承自 UIPageViewController
/// 实现了数据源和代理
/// 可直接 加载/重载 需要展示的控制器
open class FCPageViewController: UIPageViewController {

    public var index: Int {
        return _index
    }
    public var showIndicator: Bool = false
    
    public typealias PageHandler = (Int) -> Void
    var handler: PageHandler?
    
    var _index: Int = 0 {
        didSet {
            if _index != oldValue {
                handler?(_index)
            }
        }
    }
    var _pendingIndex: Int = 0
    var _viewControllers: [UIViewController] = []
    
    public override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        delegate = self
        dataSource = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension FCPageViewController {
    func addPages(_ viewControllers: [UIViewController], asChild: Bool = true) {
        _viewControllers.append(contentsOf: viewControllers)
        if asChild {
            viewControllers.forEach { (vc) in
                addChild(vc)
            }
        }
    }
    
    func reloadPages(_ viewControllers: [UIViewController], asChild: Bool = true) {
        _viewControllers.removeAll()
        addPages(viewControllers, asChild: asChild)
    }
    
    func setPage(to index: Int, animated: Bool = true) {
        if index < 0 || index >= _viewControllers.count {
            return
        }
        
        var show: [UIViewController] = [_viewControllers[index]]
        if case .pageCurl = transitionStyle, spineLocation == .mid {
            if index + 1 >= _viewControllers.count {
                return
            }
            show = _viewControllers.count >= 2 ? [_viewControllers[index], _viewControllers[index + 1]] : []
        }
        if show.isEmpty {
            return
        }
        
        let direction: UIPageViewController.NavigationDirection = index > _index ? .forward : .reverse
        
        _index = index
        setViewControllers(show, direction: direction, animated: animated, completion: nil)
    }
    
    func didChangePage(_ handler: PageHandler?) {
        self.handler = handler
    }
}

extension FCPageViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first, let index = _viewControllers.firstIndex(of: vc) {
            _pendingIndex = index
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            _index = _pendingIndex
        }
    }
}

extension FCPageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = _viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let afterIndex = index + 1
        if afterIndex >= _viewControllers.count  {
            return nil
        }
        
        return _viewControllers[afterIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = _viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let afterIndex = index - 1
        if afterIndex < 0  {
            return nil
        }
        
        return _viewControllers[afterIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return showIndicator ? _viewControllers.count : 0
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return _index
    }
}
