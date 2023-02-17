//
//  ErrorAlertViewModifier.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI

struct ErrorAlertViewModifier: ViewModifier {
    @Binding
    var isShowing: Bool
    
    let errorMessage: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isShowing {
                    ZStack {
                        Color.black
                            .opacity(0.001)
                            .onTapGesture {
                                isShowing = false
                            }
                        
                        ErrorAlertView(description: errorMessage,
                                       onCancelTap: {
                            isShowing = false
                        })
                        .transition(.opacity)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.15),
                       value: isShowing)
    }
}
