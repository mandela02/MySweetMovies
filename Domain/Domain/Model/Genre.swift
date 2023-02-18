//
//  Genre.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Platform

public struct Genres {
    public let movieGenres: [Genre]
    public let tvGenres: [Genre]
}

public struct Genre: Identifiable, Equatable {
    public static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }

    public let id: Int
    public let name: String
}

extension GenreEntity {
    var toModel: Genre {
        Genre(id: id ?? -1, name: name ?? "")
    }
}
