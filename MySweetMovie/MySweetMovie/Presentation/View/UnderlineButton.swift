//
//  UnderlineButton.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import IosUtilities

struct UnderlineButton: View {
    init(title: String,
         font: Font = .system(size: 12, weight: .bold),
         foregroundColor: Color = .white,
         underlindeColor: Color = .roseBonbon,
         onTap: @escaping VoidCallback) {
        self.title = title
        self.font = font
        self.foregroundColor = foregroundColor
        self.underlindeColor = underlindeColor
        self.onTap = onTap
    }
    
    let title: String
    let foregroundColor: Color
    let font: Font
    let underlindeColor: Color
    let onTap: VoidCallback
    
    var body: some View {
        Button(action: onTap,
               label: {
            Text(title)
                .font(font)
                .foregroundColor(foregroundColor)
                .overlay(
                    underlindeColor.frame(height: 2).offset(y: 4),
                    alignment: .bottom)
        })
        .plainButton
        .contentShape(Rectangle())
    }
}
