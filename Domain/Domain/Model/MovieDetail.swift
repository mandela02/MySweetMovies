//
//  MovieDetail.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct MovieDetail: Identifiable {
    public let id: Int

    public let backdropPath: String
    public let belongsToCollection: MovieCollection?
    public let budget: Int
    public let genres: [Genre]
    public let homepage: String
    public let imdbID, originalLanguage, originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: Date
    public let revenue, runtime: Int
    public let spokenLanguages: [SpokenLanguage]
    public let status, tagline, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public let backdrops: [MovieImage]
    public let posters: [MovieImage]
    public let casts: [Credit]
    public let crews: [Credit]
    public let similars: [Movie]
    
    public var tags: [String] {
        self.genres.map { $0.name }
    }
}

extension MovieDetailEntity {
    var toModel: MovieDetail {
        MovieDetail(id: id ?? -1,
                    backdropPath: backdropPath ?? "",
                    belongsToCollection: belongsToCollection?.toModel,
                    budget: budget ?? 0,
                    genres: genres?.map { $0.toModel } ?? [],
                    homepage: homepage ?? "",
                    imdbID: imdbID ?? "",
                    originalLanguage: originalLanguage ?? "",
                    originalTitle: originalTitle ?? "",
                    overview: overview ?? "",
                    popularity: popularity ?? 0,
                    posterPath: posterPath ?? "",
                    productionCompanies: productionCompanies?.map { $0.toModel } ?? [],
                    productionCountries: productionCountries?.map { $0.toModel } ?? [],
                    releaseDate: releaseDate?.date ?? Date(),
                    revenue: revenue ?? -1,
                    runtime: runtime ?? -1,
                    spokenLanguages: spokenLanguages?.map { $0.toModel } ?? [],
                    status: status ?? "",
                    tagline: tagline ?? "",
                    title: title ?? "",
                    video: video ?? false,
                    voteAverage: voteAverage ?? -1,
                    voteCount: voteCount ?? -1,
                    backdrops: images?.backdrops?.map { $0.toModel } ?? [],
                    posters: images?.posters?.map { $0.toModel } ?? [],
                    casts: credits?.cast?.sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) }).map { $0.toModel } ?? [],
                    crews: credits?.crew?.sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) }).map { $0.toModel } ?? [],
                    similars: similar?.results?.map { $0.toModel } ?? [])
    }
}

// MARK: - ProductionCompany
public struct ProductionCompany: Identifiable {
    public let id: Int
    public let logoPath: String
    public let name, originCountry: String
}

extension ProductionCompanyEntity {
    var toModel: ProductionCompany {
        ProductionCompany(id: id ?? -1,
                          logoPath: logoPath ?? "",
                          name: name ?? "",
                          originCountry: originCountry ?? "")
    }
}

// MARK: - ProductionCountry
public struct ProductionCountry {
    public let name: String
}

extension ProductionCountryEntity {
    var toModel: ProductionCountry {
        ProductionCountry(name: name ?? "")
    }
}

// MARK: - SpokenLanguage
public struct SpokenLanguage {
    let englishName, name: String
}

extension SpokenLanguageEntity {
    var toModel: SpokenLanguage {
        SpokenLanguage(englishName: englishName ?? "",
                       name: name ?? "")
    }
}
