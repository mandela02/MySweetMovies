//
//  MovieCollectionEntity.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public struct MovieCollectionEntity: Codable {
    public let id: Int?
    public let name, posterPath, backdropPath: String?

    public enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
