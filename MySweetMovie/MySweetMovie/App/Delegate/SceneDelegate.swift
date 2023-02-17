//
//  SceneDelegate.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import UIKit
import IosUtilities
import SwiftUIExtension

class SceneDelegate: UIResponder, UIWindowSceneDelegate, HasWindow, WindowDetector {

    var window: UIWindow?
    var navigator: AppNavigator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupAppNavigator(windowScene: scene)

    }
}

extension SceneDelegate {
    private func setupAppNavigator(windowScene: UIScene) {
        if let windowScene = windowScene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.makeKeyAndVisible()
            
            navigator = AppNavigator(window: window)
        }
    }
}
