//
//  SmallMovieCollectionViewCell.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import Domain

class SmallMovieCollectionViewCell: BaseCollectionViewCell<SmallMovieView> {
    func setup(movie: Movie) {
        setupView(content: SmallMovieView(movie: movie))
    }
}

struct SmallMovieView: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { proxy in
                NetworkImage(url: movie.posterPath.tmdbImage)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    .cornerRadius(14)
            }
        }
    }
}
