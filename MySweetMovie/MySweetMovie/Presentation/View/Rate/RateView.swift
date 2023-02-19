//
//  RateView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI

struct RateView: View {
    let rate: Double
    let size: CGFloat
    
    @ViewBuilder
    private func getStar(at index: Int) -> some View {
        let doubleIndex = index.asDouble ?? 0
        if doubleIndex <= rate {
            Image.fullStar
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.eyelashViper)
        } else {
            if doubleIndex - rate < 1 {
                Image.halfStar
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.eyelashViper)
            } else {
                Image.emptyStar
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.philipineGray)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...10, id: \.self) { index in
                getStar(at: index)
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        }
    }
}
