//
//  Application.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Domain
import UIKit

class Application {
    static let shared = Application()

    private init() {
        userCaseProvider = UseCaseProvider()
        internetManager = InternetManager()
        biometricAuthenticationManager = BiometricAuthenticationManager()
    }
    
    private(set) var userCaseProvider: UseCaseProviderProtocol
    private(set) var internetManager: InternetManager
    private(set) var biometricAuthenticationManager: BiometricAuthenticationManager
    
    var navigator: AppNavigator? {
        UIViewController.currentSceneDelegate?.navigator
    }
}
