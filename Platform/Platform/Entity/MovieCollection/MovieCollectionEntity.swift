//
//  MovieCollectionEntity.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public struct MovieCollectionEntity: Codable {
    public let id: Int?
    public let name, overview, posterPath, backdropPath: String?
    public let parts: [MovieEntity]?

    public enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case parts
    }
}
