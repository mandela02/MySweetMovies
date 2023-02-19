//
//  NetworkImage.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import NukeUI

struct NetworkImage: View {
    internal init(url: String,
                  placeholderSize: CGFloat = 100,
                  placeholderText: String = .imagePlaceholderText) {
        self.url = url
        self.placeholderSize = placeholderSize
        self.placeholderText = placeholderText
    }
    
    let url: String
    let placeholderSize: CGFloat
    let placeholderText: String
    
    var body: some View {
        if url.isEmpty {
            nameView
        } else {
            LazyImage(url: URL(string: url)) { phase in
                if phase.isLoading {
                    BlinkingLogo(size: CGSize(width: placeholderSize, height: placeholderSize))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if phase.error != nil {
                    nameView
                } else if let image = phase.image {
                    image
                }
            }
            .animation(.default)
            .pipeline(Application.shared.pipeline)
            .onDisappear(.cancel)
        }
    }
    
    var nameView: some View {
        Text(placeholderText)
            .foregroundColor(.white)
            .font(.system(size: 12, weight: .regular))
            .padding(.all, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadowMountainBackground()
    }
}
