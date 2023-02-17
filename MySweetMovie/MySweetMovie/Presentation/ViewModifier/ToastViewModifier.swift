//
//  ToastViewModifier.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI

struct ToastViewModifier: ViewModifier {
    @Binding
    var isShowing: Bool
    
    let message: String
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top,
                     content: {
                if isShowing {
                    Text(message)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.englishDaisy)
                    .clipShape(Capsule())
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        .thinMaterial,
                        in: Capsule()
                    )
                    .padding(.all, 10)
                    .transition(.move(edge: .top))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.isShowing = false
                        })
                    }
                }
            })
            .clipped()
            .animation(.easeInOut, value: isShowing)
    }
}
