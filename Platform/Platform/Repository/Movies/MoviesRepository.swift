//
//  MoviesRepository.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation

public class MoviesRepository: BaseRepository<MoviesEntity> {
    public override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    public func getNowPlaying(language: String, page: Int) async throws -> MoviesEntity {
        var param = baseParam
        param["language"] = language
        param["page"] = "\(page)"
        let result = try await dataRepository.fetchItem(path: .nowPlayingPath, param: param, needAuthToken: false)
        return try result.getData()
    }
}
