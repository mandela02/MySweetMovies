//
//  UseCaseProviderProtocol.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation

public protocol UseCaseProviderProtocol {
    func getGenresUseCase() -> GetGenresUseCase
    func getMoviesUseCase() -> GetMoviesUseCase
    func getHomeUseCase() -> GetHomeUseCase
    func getMoviesByGenresUseCase() -> GetMoviesByGenresUseCase
    func getMoviesByGenreUseCase() -> GetMoviesByGenreUseCase
}
