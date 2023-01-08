//
//  STRouterNavigatorProtocol.swift
//  STRouter
//
//  Created by admin on 2023/1/8.
//

import Foundation

/// 里面具体实现逻辑
public protocol STRouterNavigatorProtocol {
    func navigate(from:UIViewController, using transitionType: STRouterTransitionType, parameters: [String: String])
}

public extension STRouterNavigatorProtocol {
    func navigate(to: UIViewController, from sourceViewController: UIViewController, using transitionType: STRouterTransitionType) {
        switch transitionType {
        case .show:
            sourceViewController.show(to, sender: nil)
        case .present:
            sourceViewController.present(to, animated: true)
        case .push:
            sourceViewController.navigationController?.pushViewController(to, animated: true)
        }
    }
}
