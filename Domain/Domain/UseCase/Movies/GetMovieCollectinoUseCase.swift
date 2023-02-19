//
//  GetMovieCollectinoUseCase.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct GetMovieCollectinoUseCase: InputOutputUseCaseProtocol {
    public typealias Output = GetMovieCollectinoOutput
    public typealias Input = GetMovieCollectinoInput
    
    public struct GetMovieCollectinoInput {
        public init(language: String, collectionID: Int) {
            self.language = language
            self.collectionID = collectionID
        }
        
        let language: String
        let collectionID: Int
    }
    
    public struct GetMovieCollectinoOutput {
        public let movie: [Movie]
        public let overview: String
    }
    
    public init(movieCollectionRepository: MovieCollectionRepository) {
        self.movieCollectionRepository = movieCollectionRepository
    }

    private let movieCollectionRepository: MovieCollectionRepository

    public func run(input: GetMovieCollectinoInput) async throws -> GetMovieCollectinoOutput {
        let result = try await movieCollectionRepository.getDetail(language: input.language, collectionID: input.collectionID)
        return Output(movie: result.parts?.map { $0.toModel } ?? [],
                      overview: result.overview ?? "")
    }
}
