//
//  BiometricAuthenticationManager.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import LocalAuthentication
import IosUtilities

enum AuthType {
    case face
    case touch
    
    var name: String {
        switch self {
        case .touch:
            return "Touch ID"
        case .face:
            return "Face ID"
        }
    }
}

class BiometricAuthenticationManager: ObservableObject {
    @Published
    var state: AuthenticationState = AuthenticationState()
    
    lazy var biometricsPolicy = LAPolicy.deviceOwnerAuthentication

    var error: NSError?

    var localizedReason: String?
    
    init() {
        self.loadAuthenticate()
        state.isUnlocked = !Settings.isAuthenticateNeeded.value
    }
    
    private func loadAuthenticate() {
        let laContext = LAContext()
        
        if laContext.canEvaluatePolicy(biometricsPolicy, error: &error) {
            
            if let laError = error {
                state.loadingStatus = .error(laError.localizedDescription)
                return
            }
            
            if laContext.biometryType == LABiometryType.faceID {
                state.type = .face
                localizedReason = "Unlock using Face ID"
            } else if laContext.biometryType == LABiometryType.touchID {
                state.type = .touch
                localizedReason = "Unlock using Touch ID"
            } else {
                state.loadingStatus = .error("No biometric")
            }
        }
    }
    
    func authenticate() {
        if state.isUnlocked {
            return
        }
        
        guard let localizedReason = localizedReason else {
            return
        }
        
        let laContext = LAContext()
        
        laContext.evaluatePolicy(biometricsPolicy,
                                 localizedReason: localizedReason,
                                 reply: { [weak self] isSuccess, error in

            guard let self = self else { return }
            DispatchQueue.main.async(execute: {

                if let laError = error {
                    self.state.loadingStatus = .error(laError.localizedDescription)
                } else {
                    self.state.isUnlocked = isSuccess
                }

            })
        })
    }
}

struct AuthenticationState {
    var type: AuthType?
    var loadingStatus: LoadingStatus = .initial
    
    var isUnlocked = false
}
