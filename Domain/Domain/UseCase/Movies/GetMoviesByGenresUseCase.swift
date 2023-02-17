//
//  GetMoviesByGenresUseCase.swift
//  Domain
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import Platform

public struct GetMoviesByGenresUseCase: InputOutputUseCaseProtocol {
    public typealias Output = [MovieGenre]
    public typealias Input = GetMoviesByGenresInput
    
    public struct GetMoviesByGenresInput {
        public init(genres: [Genre], language: String) {
            self.language = language
            self.genres = genres
        }
        
        let language: String
        let genres: [Genre]
    }
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    private let moviesRepository: MoviesRepository

    public func run(input: GetMoviesByGenresInput) async throws -> [MovieGenre] {
        try await withThrowingTaskGroup(of: MovieGenre.self,
                                        returning: [MovieGenre].self,
                                        body: { group in
            var genreMovies: [MovieGenre] = []
            
            for genre in input.genres {
                group.addTask {
                    try await self.getMovieByGenre(genre: genre, language: input.language)
                }
            }
            
            for try await movies in group {
                if !movies.movies.isEmpty {
                    genreMovies.append(movies)
                }
            }
            
            return genreMovies
        })
        
    }
}

extension GetMoviesByGenresUseCase {
    private func getMovieByGenre(genre: Genre, language: String) async throws -> MovieGenre {
        let result = try await moviesRepository.searchByGenre(genre: genre.id, language: language, page: 1)
        return MovieGenre(genre: genre,
                          movies: result.results?.map { $0.toModel } ?? [])
    }
}
