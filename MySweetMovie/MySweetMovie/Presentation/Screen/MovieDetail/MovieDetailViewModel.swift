//
//  MovieDetailViewModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUIExtension
import Domain
import IosUtilities

@MainActor
class MovieDetailViewModel: BaseViewModel<MovieDetailViewModel.State> {
    
    init(id: Int,
         navigator: MovieDetailNavigatorProtocol,
         getMovieDetailUseCase: GetMovieDetailUseCase) {
        self.getMovieDetailUseCase = getMovieDetailUseCase
        self.navigator = navigator
        super.init(state: State(movieID: id))
        
        NotificationCenter.default.publisher(for: .languageDidChange)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                Task { @MainActor in
                    await self.fetchDataFromApi()
                }
            })
            .store(in: &cancellables)
    }
    
    private let navigator: MovieDetailNavigatorProtocol
    
    private let getMovieDetailUseCase: GetMovieDetailUseCase
    
    func onChangeMovie(movie: Movie) {
        state.movieID = movie.id
        Task { @MainActor in
            await fetchDataFromApi()
        }
    }
    
    func fetchDataFromApi() async {
        do {
            state.loadingStatus = .inProcess
            let detail = try await getMovieDetailUseCase.run(input: .init(language: Settings.language.value,
                                                                movieID: state.movieID))
            state.detail = detail
            state.loadingStatus = .success
        } catch {
            state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    func goBack() {
        self.navigator.pop()
    }
    
    func goToCollection() {
        if let collection = state.detail?.belongsToCollection {
            self.navigator.goToCollection(collection: collection,
                                          onSelect: { [weak self] movie in
                guard let self = self else { return }
                self.navigator.dismiss()
                self.onChangeMovie(movie: movie)
            })
        }
    }
    
    func goToCheckout() {
        navigator.goToCheckout()
    }
    
    struct State {
        var movieID: Int
        var loadingStatus: LoadingStatus = .initial
        var detail: MovieDetail?
    }
}
