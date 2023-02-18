//
//  AppNavigator.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import SwiftUI
import SwiftUIExtension

protocol AppNavigatorProtocol: BaseNavigator {
    var window: UIWindow? { get }
    func setRootViewController()
    func setHomeViewController()
}

class AppNavigator: AppNavigatorProtocol {
    init(window: UIWindow?) {
        self.window = window
        setRootViewController()
    }
    
    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    
    func setRootViewController() {
        let view = OnBoardingView()
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    @MainActor
    func setHomeViewController() {
        let viewController = MainTabBarViewController()
        
        navigationController.setViewControllers([viewController], animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
