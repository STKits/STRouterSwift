//
//  STRouter.swift
//  STRouter
//
//  Created by admin on 2023/1/8.
//

import UIKit

/// 路由管理，待添加中间件进行拦截处理，可通过代理暴露或者用插件形式
public final class STRouter: STRouterProtocol {
    
    public static let shared = STRouter()
    
    var navigators: [Path : STRouterNavigatorProtocol] = [:]
    
    private init() {}
    
    public func register(_ path: Path, navigator: STRouterNavigatorProtocol) {
        navigators[path] = navigator
    }
    
    @discardableResult
    public func route(_ url: URL?,
                      from: STRouterViewControllerType?,
                      using transitionType: STRouterTransitionType) -> Bool {
        guard let url = url,
              let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return false
        }
        let queryItems = urlComponents.queryItems ?? []
        let parameters = queryItems.reduce(into: [:]) { partialResult, queryItem in
            partialResult[queryItem.name] = queryItem.value
        }
        guard let from = (from as? UIViewController) ?? UIViewController.topMost else { return false }
        let path = Path(urlComponents.path)
        if let navigator = self.navigators[path] {
            navigator.navigate(from: from, using: transitionType, parameters: parameters)
            return true
        } else {
            return false
        }
    }
    
}

extension STRouter {
    public struct Path: RawRepresentable, Hashable {
        
        public var rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

private extension UIViewController {
    
    class var keyWindow: UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .first(where: { $0.isKeyWindow })
        return keyWindow
    }
    
    /// Returns the current application's top most view controller.
    class var topMost: UIViewController? {
        return self.topMost(of: keyWindow?.rootViewController)
    }
    
    /// Returns the top most view controller from given view controller's stack.
    class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}
