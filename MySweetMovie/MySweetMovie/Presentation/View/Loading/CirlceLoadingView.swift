//
//  CirlceLoadingView.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension

struct CircleLoadingView: View {
    init(size: CGSize = CGSize(width: 130, height: 130)) {
        self.size = size
    }
    
    private let size: CGSize
    
    var body: some View {
        ZStack {
            LoadingView(backgroundColor: .englishDaisy.opacity(0.3),
                        foregroundColor: .englishDaisy,
                        thickess: 12,
                        innerThickess: 8)
            BlinkingLogo(size: .init(width: 80, height: 80))
                .offset(y: -10)
        }
        .frame(width: size.width, height: size.height, alignment: .center)
    }
}
