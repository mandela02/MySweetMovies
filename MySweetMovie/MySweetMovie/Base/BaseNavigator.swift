//
//  BaseNavigator.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 21/11/2022.
//

import Foundation
import UIKit

protocol BaseNavigator {
    var navigationController: UINavigationController { get }
    func dismiss()
    func pop()
}

extension BaseNavigator {
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
