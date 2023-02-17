//
//  View+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUI
import IosUtilities

extension View {
    func setEnvironment() -> some View {
        self
            .environmentObject(Application.shared.internetManager)
            .environmentObject(Application.shared.biometricAuthenticationManager)
    }
    
    func deviceAuthentication() -> some View {
        self
            .modifier(AuthenticationModifier())
    }
    
    func viewDidLoad(initState: @escaping AsyncVoidCallback) -> some View {
        self
            .modifier(ViewDidLoadModifier(initState: initState))
    }
}

extension View {
    @ViewBuilder
    func blackBackground() -> some View {
        ZStack {
            Color.blackRussian
                .ignoresSafeArea()
            self
        }
    }
}
