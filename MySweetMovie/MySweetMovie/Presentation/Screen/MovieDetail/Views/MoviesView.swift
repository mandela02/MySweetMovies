//
//  MoviesView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import Domain

struct MoviesView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Color.clear.frame(width: 10)
                LazyHStack(spacing: 10) {
                    ForEach(movies) { movie in
                        buildMovieView(movie: movie)
                    }
                }
                Color.clear.frame(width: 10)
            }
        }
    }
    
    private func buildMovieView(movie: Movie) -> some View {
        SmallMovieView(movie: movie)
            .frame(width: 150, height: 150 * 3 / 2)
            .cornerRadius(8)
    }
}
