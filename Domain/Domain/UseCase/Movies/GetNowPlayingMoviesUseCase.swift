//
//  GetNowPlayingMoviesUseCase.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Platform

public struct GetMoviesUseCase: InputOutputUseCaseProtocol {
    public typealias Output = Movies
    public typealias Input = GetNowPlayingMovieInput
    
    public struct GetNowPlayingMovieInput {
        public init(language: String,
                    type: MovieType,
                    page: Int) {
            self.language = language
            self.page = page
            self.type = type
        }
        
        let language: String
        let page: Int
        let type: MovieType
    }
    
    public enum MovieType {
        case upcoming
        case nowPlaying
        case popular
        case topRated
    }
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: GetNowPlayingMovieInput) async throws -> Movies {
        var result: MoviesEntity
        
        switch input.type {
        case .nowPlaying:
            result = try await moviesRepository.getNowPlaying(language: input.language, page: input.page)
        case .topRated:
            result = try await moviesRepository.getTopRated(language: input.language, page: input.page)
        case .popular:
            result = try await moviesRepository.getPopular(language: input.language, page: input.page)
        case.upcoming:
            result = try await moviesRepository.getUpcomming(language: input.language, page: input.page)
        }
                
        return Movies(page: result.page ?? -1,
                      totalPage: result.totalPages ?? -1,
                      totalResult: result.totalResults ?? -1,
                      movies: result.results?.map { $0.toModel } ?? [])
    }
}
