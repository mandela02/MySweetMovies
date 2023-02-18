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
                  placeholderSize: CGFloat = 100) {
        self.url = url
        self.placeholderSize = placeholderSize
    }
    
    let url: String
    let placeholderSize: CGFloat
    
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
        GeometryReader { proxy in
            Image
                .movieAndSpeaker
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding(.all, 10)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}
