//
//  GenresRepository.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation

public class GenresRepository: BaseRepository<GenresEntity> {
    public override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    public func getMovieGenres(language: String) async throws -> GenresEntity {
        var param = baseParam
        param["language"] = language
        let result = try await dataRepository.fetchItem(path: .movieGenrePath, param: param, needAuthToken: false)
        return try result.getData()
    }
    
    public func getTvGenres(language: String) async throws -> GenresEntity {
        var param = baseParam
        param["language"] = language
        let result = try await dataRepository.fetchItem(path: .tvGenrePath, param: param, needAuthToken: false)
        return try result.getData()
    }
}
