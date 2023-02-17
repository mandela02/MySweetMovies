//
//  GetGenresUseCase.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Platform

public struct GetGenresUseCase: InputOutputUseCaseProtocol {
    public typealias Output = Genres
    public typealias Input = String
    
    public init(genresRepository: GenresRepository) {
        self.genresRepository = genresRepository
    }

    private let genresRepository: GenresRepository
    
    public func run(input: String) async throws -> Genres {
        async let movieGenres = genresRepository.getMovieGenres(language: input)
        async let tvGenres = genresRepository.getTvGenres(language: input)
        
        let result = try await (movieGenres, tvGenres)
        
        return Genres(movieGenres: result.0.genres?.compactMap {
            if let id = $0.id, let name = $0.name {
                return Genre(id: id, name: name)
            } else {
                return nil
            }
        } ?? [],
                      tvGenres: result.1.genres?.compactMap {
            if let id = $0.id, let name = $0.name {
                return Genre(id: id, name: name)
            } else {
                return nil
            }
        } ?? [])
    }
}
