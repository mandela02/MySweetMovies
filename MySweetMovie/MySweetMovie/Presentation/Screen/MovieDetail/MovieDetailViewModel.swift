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
         getMovieDetailUseCase: GetMovieDetailUseCase) {
        self.getMovieDetailUseCase = getMovieDetailUseCase
        super.init(state: State(movieID: id))
    }
    
    private let getMovieDetailUseCase: GetMovieDetailUseCase
    
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
    
    struct State {
        let movieID: Int
        var loadingStatus: LoadingStatus = .initial
        var detail: MovieDetail?
    }
}
