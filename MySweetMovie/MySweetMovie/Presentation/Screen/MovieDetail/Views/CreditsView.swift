//
//  ActorsView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import Domain

struct CreditsView: View {
    let credits: [Credit]
    let isActor: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Color.clear.frame(width: 10)
                LazyHStack(spacing: 10) {
                    ForEach(credits) { actor in
                        buildCreditView(credit: actor)
                    }
                }
                Color.clear.frame(width: 10)
            }
        }
    }
    
    private func buildCreditView(credit: Credit) -> some View {
        ZStack(alignment: .bottomLeading) {
            NetworkImage(url: credit.image.tmdbImage,
                         placeholderText: credit.name)
            
            VStack(alignment: .leading) {
                Text(credit.name)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(isActor ? credit.character : credit.job)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.philipineGray)
            }
            .padding(.all, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .blurBackground()
        }
        .frame(width: 150, height: 150 * 3 / 2)
        .cornerRadius(8)
    }
}
