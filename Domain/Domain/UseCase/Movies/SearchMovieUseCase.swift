//
//  SearchMovieUseCase.swift
//  Domain
//
//  Created by TriBQ on 20/02/2023.
//

import Foundation
import Platform

public struct SearchMovieUseCase: InputOutputUseCaseProtocol {
    public typealias Output = Movies
    
    public struct Input {
        public init(keyword: String, language: String, page: Int) {
            self.language = language
            self.keyword = keyword
            self.page = page
        }
        
        let language: String
        let keyword: String
        let page: Int
    }
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: Input) async throws -> Movies {
        let result = try await moviesRepository.searchMovie(keyword: input.keyword, language: input.language, page: input.page)
        let movies = result.results?.map { $0.toModel } ?? []
        
        return Movies(page: result.page ?? -1,
                      totalPage: result.totalPages ?? -1,
                      totalResult: result.totalResults ?? -1,
                      movies: movies)

    }
}
