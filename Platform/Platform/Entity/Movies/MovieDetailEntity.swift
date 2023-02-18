//
//  MovieDetailEntity.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

// MARK: - MovieDetailEntity
public struct MovieDetailEntity: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let belongsToCollection: MovieCollectionEntity?
    public let budget: Int?
    public let genres: [GenresEntity]?
    public let homepage: String?
    public let id: Int?
    public let imdbID, originalLanguage, originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue, runtime: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status, tagline, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let images: MovieImagesEntity?
    public let credits: MovieCreditsEntity?

    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case images, credits
    }
}

public struct MovieImagesEntity: Codable {
    public let backdrops: [MovieImageEntity]?
    public let logos: [MovieImageEntity]?
    public let posters: [MovieImageEntity]?
}

// MARK: - Credits
public struct MovieCreditsEntity: Codable {
    public let cast, crew: [CreditEntity]?
}

// MARK: - ProductionCompany
public struct ProductionCompany: Codable {
    public let id: Int?
    public let logoPath: String?
    public let name, originCountry: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
public struct ProductionCountry: Codable {
    public let name: String?

    public enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - SpokenLanguage
public struct SpokenLanguage: Codable {
    let englishName, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
    }
}
