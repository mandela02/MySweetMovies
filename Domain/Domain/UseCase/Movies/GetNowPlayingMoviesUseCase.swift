//
//  GetNowPlayingMoviesUseCase.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Platform

public struct GetNowPlayingMovieUseCase: InputOutputUseCaseProtocol {
    public typealias Output = Movies
    public typealias Input = GetNowPlayingMovieInput
    
    public struct GetNowPlayingMovieInput {
        public init(language: String, page: Int) {
            self.language = language
            self.page = page
        }
        
        let language: String
        let page: Int
    }
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: GetNowPlayingMovieInput) async throws -> Movies {
        let result = try await moviesRepository.getNowPlaying(language: input.language, page: input.page)
        
        return Movies(page: result.page ?? -1,
                      totalPage: result.totalPages ?? -1,
                      totalResult: result.totalResults ?? -1,
                      movies: result.results?.map { $0.toModel } ?? [])
    }
}
