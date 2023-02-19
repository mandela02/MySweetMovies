//
//  SearchViewModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 20/02/2023.
//

import Foundation
import SwiftUIExtension
import IosUtilities
import Domain

@MainActor
class SearchViewModel: BaseViewModel<SearchViewModel.State> {
    
    init(navigator: SearchNavigatorProtocol,
         searchMovieUseCase: SearchMovieUseCase) {
        self.navigator = navigator
        
        self.searchMovieUseCase = searchMovieUseCase
        super.init(state: State())
        
        $state
            .map { $0.query }
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.state.nextPage = 1
                self.state.movies = [MovieSection(data: [])]
                self.state.isSearching = true
                Task { @MainActor in
                    await self.fetchDataFromApi(keyword: searchText)
                    self.state.isSearching = false
                }
            }
            .store(in: &cancellables)
    }
    
    private let navigator: SearchNavigatorProtocol
    private let searchMovieUseCase: SearchMovieUseCase
    
    func fetchDataFromApi(keyword: String) async {
        guard let nextPage = state.nextPage else {
            return
        }
        
        do {
            if nextPage == 1 && !state.isSearching {
                state.loadingStatus = .inProcess
            }
            let movies = try await searchMovieUseCase.run(input: .init(keyword: keyword,
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
    
    func pullToRefresh() {
        self.state.nextPage = 1
        self.state.movies = [MovieSection(data: [])]
        self.state.isSearching = true
        Task { @MainActor in
            await self.fetchDataFromApi(keyword: state.query)
            self.state.isSearching = false
        }
    }
    
    func goToMovie(movieID: Int) {
        self.navigator.goToMovie(movieID: movieID)
    }

    struct State {
        var query: String = ""
        var loadingStatus: LoadingStatus = .initial
        var nextPage: Int? = 1
        var isSearching = false

        var movies = [MovieSection(data: [])]
    }
}
