//
//  BigMovieCollectionViewCell.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import Domain

class BigMovieCollectionViewCell: BaseCollectionViewCell<BigMovieView> {
    func setup(movie: Movie) {
        setupView(content: BigMovieView(movie: movie))
    }
}

struct BigMovieView: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { proxy in
                NetworkImage(url: movie.backdropPath.tmdbImage)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    .cornerRadius(14)
            }
        }
    }
}
