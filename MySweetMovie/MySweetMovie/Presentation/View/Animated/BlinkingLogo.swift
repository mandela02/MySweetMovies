//
//  BlinkingLogo.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI

struct BlinkingLogo: View {
    init(size: CGSize = CGSize(width: 100, height: 100)) {
        self.size = size
    }
    
    let size: CGSize
    
    var body: some View {
        Image.movieAndSpeaker
            .resizable()
            .scaledToFit()
            .blinking(duration: 2.5)
            .opacity(0.8)
            .foregroundColor(.white)
            .frame(width: size.width, height: size.height, alignment: .center)
    }
}
