//
//  HomeViewModel.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import SwiftUIExtension
import Domain
import IosUtilities

class HomeViewModel: BaseViewModel<HomeState> {
    
    init(getNowPlayingMoviesUseCase: GetNowPlayingMovieUseCase) {
        self.getNowPlayingMoviesUseCase = getNowPlayingMoviesUseCase
        super.init(state: HomeState())
    }
    
    let getNowPlayingMoviesUseCase: GetNowPlayingMovieUseCase
    
    func fetchDataFromApi() async {
        do {
            let result = try await getNowPlayingMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                                               page: 1))
            print(result)
        } catch {
            self.state.loadingStatus = .error(error.localizedDescription)
        }
    }
}

struct HomeState {
    var loadingStatus: LoadingStatus = .initial
}
