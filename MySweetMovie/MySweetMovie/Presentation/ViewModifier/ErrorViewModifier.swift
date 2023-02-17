//
//  ErrorViewModifier.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import IosUtilities

struct ErrorViewModifier: ViewModifier {

    @Binding
    var loadingStatus: LoadingStatus
    
    @State
    var errorMessage: String = ""
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center, content: {
                if !errorMessage.isEmpty {
                    ZStack {
                        Color.black
                            .opacity(0.001)
                            .onTapGesture {
                                loadingStatus = .initial
                            }
                        ErrorAlertView(description: errorMessage,
                                       onCancelTap: {
                            errorMessage = ""
                        })
                        .transition(.opacity)
                    }
                }
            })
            .onChange(of: loadingStatus, perform: { newValue in
                switch newValue {
                case .error(let error):
                    errorMessage = error
                default:
                    return
                }
            })
            .animation(.easeInOut, value: loadingStatus)
    }
}
