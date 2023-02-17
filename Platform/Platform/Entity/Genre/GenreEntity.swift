//
//  GenreEntity.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation

// MARK: - Genres
public struct GenresEntity: Codable {
    public let genres: [GenreEntity]?
}

// MARK: - Genre
public struct GenreEntity: Codable {
    public let id: Int?
    public let name: String?
}
