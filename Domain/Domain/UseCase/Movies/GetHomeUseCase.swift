//
//  GetHomeUseCase.swift
//  Domain
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import Platform

public struct GetHomeUseCase: InputOutputUseCaseProtocol {
    public typealias Output = HomeData
    public typealias Input = String
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: String) async throws -> HomeData {
        async let nowPlaying = moviesRepository.getNowPlaying(language: input, page: 1)
        async let upcomming = moviesRepository.getUpcomming(language: input, page: 1)
        
        let result = try await (nowPlaying, upcomming)
        
        return HomeData(upcoming: result.1.results?.map { $0.toModel } ?? [],
                        nowPlaying: result.0.results?.map { $0.toModel } ?? [])
    }
}
