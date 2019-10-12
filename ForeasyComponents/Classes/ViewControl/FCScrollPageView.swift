//
//  FCScrollPageView.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/9/29.
//  Copyright © 2019 刁世浩. All rights reserved.
//


open class FCScrollPageView: UIView {

    var currentIndex: Int = 0
    var viewControllers: [UIViewController] = []
    let pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    init(frame: CGRect, viewControllers: [UIViewController]) {
        super.init(frame: frame)
        self.viewControllers = viewControllers
        
        pageView.delegate = self
        pageView.dataSource = self
        addSubview(pageView.view)
        
        viewControllers.forEach { (vc) in
            pageView.addChildViewController(vc, toContainerView: pageView.view)
        }
        let show: [UIViewController]? = (viewControllers.first != nil) ? nil : [viewControllers.first!]
        pageView.setViewControllers(show, direction: .forward, animated: true, completion: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCScrollPageView: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first, let index = viewControllers.firstIndex(of: vc) {
            currentIndex = index
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}

extension FCScrollPageView: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewControllers[currentIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewControllers[currentIndex]
    }
    
}
