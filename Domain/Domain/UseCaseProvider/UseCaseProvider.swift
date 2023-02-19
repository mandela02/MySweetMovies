//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Platform

public struct UseCaseProvider: UseCaseProviderProtocol {
    private let provider: RepositoryProvider
    
    public init(repositoryProvider: RepositoryProvider = RepositoryProvider()) {
        self.provider = repositoryProvider
    }
    
    public func getGenresUseCase() -> GetGenresUseCase {
        return GetGenresUseCase(genresRepository: provider.genresRepository)
    }
    
    public func getMoviesUseCase() -> GetMoviesUseCase {
        GetMoviesUseCase(moviesRepository: provider.moviesRepository)
    }
    
    public func getHomeUseCase() -> GetHomeUseCase {
        GetHomeUseCase(moviesRepository: provider.moviesRepository)
    }
    
    public func getMoviesByGenresUseCase() -> GetMoviesByGenresUseCase {
        GetMoviesByGenresUseCase(moviesRepository: provider.moviesRepository)
    }
    
    public func getMoviesByGenreUseCase() -> GetMoviesByGenreUseCase {
        GetMoviesByGenreUseCase(moviesRepository: provider.moviesRepository)
    }
    
    public func getMovieDetailUseCase() -> GetMovieDetailUseCase {
        GetMovieDetailUseCase(movieDetailRepository: provider.movieDetailRepository)
    }
    
    public func getMovieCollectinoUseCase() -> GetMovieCollectinoUseCase {
        GetMovieCollectinoUseCase(movieCollectionRepository: provider.movieCollectionRepository)
    }
    
    public func searchMovieUseCase() -> SearchMovieUseCase {
        SearchMovieUseCase(moviesRepository: provider.moviesRepository)
    }
}
