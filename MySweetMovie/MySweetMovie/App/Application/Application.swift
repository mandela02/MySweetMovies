//
//  Application.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Domain
import UIKit
import Nuke

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
    
    let pipeline = ImagePipeline {
        $0.dataLoader = {
            let config = URLSessionConfiguration.default
            config.urlCache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 1_000_000_000)
            return DataLoader(configuration: config)
        }()
    }

    var navigator: AppNavigator? {
        UIViewController.currentSceneDelegate?.navigator
    }
}
