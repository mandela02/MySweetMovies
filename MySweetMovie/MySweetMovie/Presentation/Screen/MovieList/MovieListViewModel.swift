//
//  MovieListViewModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import SwiftUIExtension
import Domain
import IosUtilities
import UnderlyingViewForSwiftUI

enum MovieListKind {
    case upcoming
    case nowPlaying
    case popular
    case topRated
    case genre(Genre)
    
    var name: String {
        switch self {
        case .upcoming:
            return .upcoming
        case .nowPlaying:
            return .nowPlaying
        case .popular:
            return .trending
        case .topRated:
            return .topRated
        case .genre(let genre):
            return genre.name
        }
    }
}

@MainActor
class MovieListViewModel: BaseViewModel<MovieListViewModel.State> {
    init(kind: MovieListKind,
         navigator: MovieListNavigatorProtocol,
         getMoviesUseCase: GetMoviesUseCase,
         getMoviesByGenreUseCase: GetMoviesByGenreUseCase) {
        self.navigator = navigator
        self.getMoviesUseCase = getMoviesUseCase
        self.getMoviesByGenreUseCase = getMoviesByGenreUseCase
        
        super.init(state: State(kind: kind))
        
        NotificationCenter.default.publisher(for: .genresDidChange)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                switch self.state.kind {
                case .genre(let genre):
                    let allMovieGenre = Application.shared.genresManager.movieGenres
                    if let genre = allMovieGenre.first(where: { $0.id == genre.id }) {
                        self.state.kind = .genre(genre)
                    }
                default:
                    return
                }

                Task { @MainActor in
                    await self.pullToRefresh()
                }
            })
            .store(in: &cancellables)
    }
    
    private let navigator: MovieListNavigatorProtocol
    private let getMoviesUseCase: GetMoviesUseCase
    private let getMoviesByGenreUseCase: GetMoviesByGenreUseCase
    
    func fetchDataFromApi() async {
        guard let nextPage = state.nextPage else {
            return
        }

        do {
            if nextPage == 1 {
                state.loadingStatus = .inProcess
            }

            let movies = try await selectUseCase(at: nextPage)
            if nextPage == movies.totalPage {
                state.nextPage = nil
            } else {
                state.nextPage = nextPage + 1
            }
            
            state.movies[0].data.append(contentsOf: movies.movies.map { SingleCell(model: $0) })

            state.loadingStatus = .success
        } catch {
            state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    func pullToRefresh() async {
        state.nextPage = 1
        state.movies = [MovieSection(data: [])]
        await fetchDataFromApi()
    }
    
    private func selectUseCase(at page: Int) async throws -> Movies {
        switch state.kind {
        case .upcoming:
            return try await getMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                               type: .upcoming,
                                                               page: page))
        case .nowPlaying:
            return try await getMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                               type: .nowPlaying,
                                                               page: page))
        case .popular:
            return try await getMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                               type: .popular,
                                                               page: page))
        case .topRated:
            return try await getMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                               type: .topRated,
                                                               page: page))
        case .genre(let genre):
            return try await getMoviesByGenreUseCase.run(input: .init(genre: genre,
                                                                      language: Settings.language.value,
                                                                      page: page))
        }
    }
    
    func back() {
        self.navigator.pop()
    }
    
    func goToMovie(movieID: Int) {
        self.navigator.goToMovie(movieID: movieID)
    }
    
    struct State {
        var kind: MovieListKind
        var loadingStatus: LoadingStatus = .initial
        var nextPage: Int? = 1
        
        var movies = [MovieSection(data: [])]
    }
}
