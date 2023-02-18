//
//  MovieImageEntity.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public struct MovieImageEntity: Codable {
    public let aspectRatio: Double?
    public let height: Int?
    public let filePath: String?
    public let voteAverage: Double?
    public let voteCount, width: Int?

    public enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
