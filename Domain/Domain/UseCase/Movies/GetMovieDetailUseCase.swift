//
//  GetMovieDetailUseCase.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct GetMovieDetailUseCase: InputOutputUseCaseProtocol {
    public typealias Output = MovieDetail
    public typealias Input = GetMovieDetailInput
    
    public struct GetMovieDetailInput {
        public init(language: String, movieID: Int) {
            self.language = language
            self.movieID = movieID
        }
        
        let language: String
        let movieID: Int
    }
    
    public init(movieDetailRepository: MovieDetailRepository) {
        self.movieDetailRepository = movieDetailRepository
    }

    private let movieDetailRepository: MovieDetailRepository

    public func run(input: GetMovieDetailInput) async throws -> MovieDetail {
        let result = try await movieDetailRepository.getDetail(language: input.language, movieID: input.movieID)
        return result.toModel
    }
}
