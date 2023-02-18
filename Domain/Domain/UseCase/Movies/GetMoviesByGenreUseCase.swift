//
//  GetMoviesByGenreUseCase.swift
//  Domain
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import Platform

public struct GetMoviesByGenreUseCase: InputOutputUseCaseProtocol {
    public typealias Output = Movies
    public typealias Input = GetMoviesByGenreInput
    
    public struct GetMoviesByGenreInput {
        public init(genre: Genre, language: String, page: Int) {
            self.language = language
            self.genre = genre
            self.page = page
        }
        
        let language: String
        let genre: Genre
        let page: Int
    }
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: GetMoviesByGenreInput) async throws -> Movies {
        let result = try await moviesRepository.searchByGenre(genre: input.genre.id, language: input.language, page: input.page)
        let movies = result.results?.map { $0.toModel } ?? []
        
        return Movies(page: result.page ?? -1,
                      totalPage: result.totalPages ?? -1,
                      totalResult: result.totalResults ?? -1,
                      movies: movies)

    }
}
