//
//  MovieDetailRepository.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public class MovieDetailRepository: BaseRepository<MovieDetailEntity> {
    public override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    public func getDetail(language: String, movieID: Int) async throws -> MovieDetailEntity {
        var param = baseParam
        param["language"] = language
        param["append_to_response"] = "images,credits,similar"
        param["include_image_language"] = "\(language),null"
        let result = try await dataRepository.fetchItem(path: String(format: .movieDetailPath, "\(movieID)"),
                                                        param: param,
                                                        needAuthToken: false)
        return try result.getData()
    }
}
