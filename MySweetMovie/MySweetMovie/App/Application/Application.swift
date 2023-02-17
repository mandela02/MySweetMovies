//
//  Application.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Domain
import UIKit

@MainActor
class Application {
    static let shared = Application()

    private init() {
        userCaseProvider = UseCaseProvider()
        internetManager = InternetManager()
        biometricAuthenticationManager = BiometricAuthenticationManager()
        
        genresManager = GenresManager(getGenresUseCase: userCaseProvider.getGenresUseCase())
    }
    
    private(set) var userCaseProvider: UseCaseProviderProtocol
    
    private(set) var internetManager: InternetManager
    private(set) var biometricAuthenticationManager: BiometricAuthenticationManager
    private(set) var genresManager: GenresManager
    
    var navigator: AppNavigator? {
        UIViewController.currentSceneDelegate?.navigator
    }
}
