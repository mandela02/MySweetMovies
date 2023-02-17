//
//  Movies.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Platform

public struct Movies {
    public let page: Int
    public let totalPage: Int
    public let totalResult: Int
     
    public let movies: [Movie]
}

public struct MovieGenre {
    public let genre: Genre
    public let movies: [Movie]
}

public struct Movie: Identifiable {
    public let id: Int

    public let adult: Bool
    public let backdropPath: String
    public let genreIDS: [Int]
    
    public let originalLanguage: String
    public let originalTitle, overview: String
    public let posterPath, title: String
    public let releaseDate: Date
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
}

extension MovieEntity {
    var toModel: Movie {
        Movie(id: self.id ?? -1,
              adult: self.adult ?? false,
              backdropPath: self.backdropPath ?? "",
              genreIDS: self.genreIDS ?? [],
              originalLanguage: self.originalLanguage ?? "",
              originalTitle: self.originalTitle ?? "",
              overview: self.overview ?? "",
              posterPath: self.posterPath ?? "",
              title: self.title ?? "",
              releaseDate: self.releaseDate?.date ?? Date(),
              video: self.video ?? false,
              voteAverage: self.voteAverage ?? 0,
              voteCount: self.voteCount ?? 0)
    }
}
