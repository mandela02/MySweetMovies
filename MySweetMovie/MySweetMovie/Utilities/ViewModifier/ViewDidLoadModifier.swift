//
//  ViewDidLoadModifier.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUI
import IosUtilities

struct ViewDidLoadModifier: ViewModifier {
    @State
    private var isFirstTime = true
    
    @EnvironmentObject
    var internetManager: InternetManager
    
    let initState: AsyncVoidCallback
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                Task { @MainActor in
                    if !internetManager.isConnectedToInternet {
                        return
                    }
                    if isFirstTime {
                        isFirstTime = false
                        await initState()
                    }
                }
            }
            .onChange(of: internetManager.isConnectedToInternet) { isHavingInternet in
                guard isHavingInternet else {
                    return
                }
                Task { @MainActor in
                    await initState()
                }
            }
    }
}
