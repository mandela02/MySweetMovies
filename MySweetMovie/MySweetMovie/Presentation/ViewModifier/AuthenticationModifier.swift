//
//  AuthenticationModifier.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUI

struct AuthenticationModifier: ViewModifier {
    @EnvironmentObject
    private var authenticationManager: BiometricAuthenticationManager

    func body(content: Content) -> some View {
        content
            .overlay {
                if !authenticationManager.state.isUnlocked {
                    LockView()
                        .transition(.opacity)
                }
            }
            .onEnterBackground {
                if Settings.isAuthenticateNeeded.value {
                    authenticationManager.state.isUnlocked = false
                }
            }
            .onBecomeActive {
                if Settings.isAuthenticateNeeded.value {
                    authenticationManager.authenticate()
                }
            }
            .animation(.easeInOut, value: authenticationManager.state.isUnlocked)
    }
}

