//
//  UIApplication+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var curretnAppDelegate: AppDelegate? {
        return appDelegate as? AppDelegate
    }
    
    static var currentSceneDelegate: SceneDelegate? {
        return sceneDelegate as? SceneDelegate
    }
    
    static func rootViewController() -> UINavigationController? {
        let rootVC = UIViewController.currentSceneDelegate?.window?.rootViewController as? UINavigationController
        
        return rootVC
    }
}

