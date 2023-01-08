//
//  STRouterProtocol.swift
//  STRouter
//
//  Created by admin on 2023/1/8.
//

import Foundation

protocol STRouterProtocol: AnyObject {
    
    var navigators: [STRouter.Path: STRouterNavigatorProtocol] { get set }
    
    /// 注册
    func register(_ path:STRouter.Path, navigator:STRouterNavigatorProtocol)
    
    /// 跳转
    func route(_ url: URL?, from: STRouterViewControllerType?, using transitionType: STRouterTransitionType) -> Bool 
    
}
