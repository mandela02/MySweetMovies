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
import UnderlyingViewForSwiftUI

@MainActor
class HomeViewModel: BaseViewModel<HomeViewModel.HomeState> {
    
    init(getNowPlayingMoviesUseCase: GetNowPlayingMovieUseCase) {
        self.getNowPlayingMoviesUseCase = getNowPlayingMoviesUseCase
        super.init(state: HomeState())
    }
    
    let getNowPlayingMoviesUseCase: GetNowPlayingMovieUseCase
    
    func fetchDataFromApi() async {
        do {
            let result = try await getNowPlayingMoviesUseCase.run(input: .init(language: Settings.language.value,
                                                                               page: 1))
            
            let section1 = Section(title: "", data: result.movies.map { SingleCell(model: $0) }, type: .big)
            let section2 = Section(title: "", data: result.movies.map { SingleCell(model: $0) }, type: .small)
            
            state.sections = [section1, section2]
        } catch {
            self.state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    enum SectionType {
        case big
        case small
    }
    
    struct Section: GenericSection {
        var title: String
        var data: [any Cell]
        
        var type: SectionType
    }
    
    
    struct HomeState {
        var loadingStatus: LoadingStatus = .initial
        var sections: [Section] = []
    }
}
