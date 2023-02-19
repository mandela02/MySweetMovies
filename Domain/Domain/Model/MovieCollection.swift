//
//  MovieCollection.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct MovieCollection: Identifiable {
    public var id: Int
    public let name, posterPath, backdropPath: String
}

extension MovieCollectionEntity {
    var toModel: MovieCollection {
        MovieCollection(id: id ?? -1,
                        name: name ?? "",
                        posterPath: posterPath ?? "",
                        backdropPath: backdropPath ?? "")
    }
}
