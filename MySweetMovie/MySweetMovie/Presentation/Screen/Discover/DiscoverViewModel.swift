//
//  DiscoverViewModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 20/02/2023.
//

import Foundation
import Domain
import SwiftUIExtension
import IosUtilities

@MainActor
class DiscoverViewModel: BaseViewModel<DiscoverViewModel.State> {
    
    init(getMoviesByGenreUseCase: GetMoviesByGenreUseCase) {
        self.getMoviesByGenreUseCase = getMoviesByGenreUseCase
        
        super.init(state: State())
        
        NotificationCenter.default.publisher(for: .genresDidChange)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                if let genre = self.state.genre {
                    let allMovieGenre = Application.shared.genresManager.movieGenres
                    if let newGenre = allMovieGenre.first(where: { $0.id == genre.id }) {
                        self.state.genre = newGenre
                    }

                    Task { @MainActor in
                        await self.pullToRefresh()
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    private let getMoviesByGenreUseCase: GetMoviesByGenreUseCase
    
    func fetchDataFromApi(genre: Genre?) async {
        guard let genre = genre else {
            return
        }
        
        guard let nextPage = state.nextPage else {
            return
        }
        
        do {
            if nextPage == 1 {
                state.loadingStatus = .inProcess
            }
            let movies = try await getMoviesByGenreUseCase.run(input: .init(genre: genre,
                                                                            language: Settings.language.value,
                                                                            page: nextPage))
                        
            state.movies[0].data.append(contentsOf: movies.movies.map { SingleCell(model: $0) })

            if nextPage == movies.totalPage {
                state.nextPage = nil
            } else {
                state.nextPage = nextPage + 1
            }
                                        
            state.loadingStatus = .success
            
        } catch let error {
            state.loadingStatus = .error(error.localizedDescription)
        }
    }

    func pullToRefresh() async {
        state.nextPage = 1

        state.movies = [MovieSection(data: [])]
        
        await fetchDataFromApi(genre: state.genre)
    }
    
    func onChangeGenres(genre: Genre) {
        Task { @MainActor in
            state.genre = genre
            await pullToRefresh()
        }
    }
    
    struct State {
        var genre: Genre?
        var loadingStatus: LoadingStatus = .initial
        var nextPage: Int? = 1

        var movies = [MovieSection(data: [])]
    }
}
