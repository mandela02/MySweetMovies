//
//  MovieCollectionRepository.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public class MovieCollectionRepository: BaseRepository<MovieCollectionEntity> {
    public override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    public func getDetail(language: String, collectionID: Int) async throws -> MovieCollectionEntity {
        var param = baseParam
        param["language"] = language
        let result = try await dataRepository.fetchItem(path: String(format: .movieCollectionPath, "\(collectionID)"),
                                                        param: param,
                                                        needAuthToken: false)
        return try result.getData()
    }
}
