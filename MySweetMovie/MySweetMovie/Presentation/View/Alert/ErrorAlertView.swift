//
//  ErrorAlertView.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension

struct ErrorAlertView: View {
    
    @State
    var isShowing: Bool = false
    
    let description: String
    let onCancelTap: (() -> Void)?
    
    var body: some View {
        DefaultAlertView(isShowing: $isShowing,
                         image: .error,
                         title: .error,
                         titleFont: .system(size: 16, weight: .semibold),
                         description: description,
                         descriptionFont: .system(size: 12, weight: .regular),
                         cancelTitle: .cancel,
                         buttonFont: .system(size: 14, weight: .semibold),
                         backgroundColor: .white,
                         foregroundColor: .dullBlack,
                         onCancelTap: onCancelTap)
    }
}
