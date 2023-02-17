//
//  Genre.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation

public struct Genres {
    public let movieGenres: [Genre]
    public let tvGenres: [Genre]
}

public struct Genre {
    let id: Int
    let name: String
}
