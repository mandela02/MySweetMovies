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
    
    init(getHomeUseCase: GetHomeUseCase,
         getMoviesByGenresUseCase: GetMoviesByGenresUseCase) {
        self.getHomeUseCase = getHomeUseCase
        self.getMoviesByGenresUseCase = getMoviesByGenresUseCase
        super.init(state: HomeState())
    }
    
    let getHomeUseCase: GetHomeUseCase
    let getMoviesByGenresUseCase: GetMoviesByGenresUseCase
    
    func fetchDataFromApi() async {
        do {
            self.state.loadingStatus = .inProcess
            let movies = try await getHomeUseCase.run(input: Settings.language.value)
            
            let upcoming = Section(title: "", data: movies.upcoming.map { SingleCell(model: $0) }, type: .big)
            let nowPlaying = Section(title: .nowPlaying, data: movies.nowPlaying.map { SingleCell(model: $0) }, type: .small)
            let popular = Section(title: .trending, data: movies.popular.map { SingleCell(model: $0) }, type: .small)
            let topRated = Section(title: .topRated, data: movies.topRated.map { SingleCell(model: $0) }, type: .small)
            
            state.sections = [upcoming, nowPlaying, popular, topRated]
            
            self.state.loadingStatus = .success
            
            let movieByGenres = try await getMoviesByGenresUseCase.run(input: .init(genres: Application.shared.genresManager.movieGenres,
                                                                                    language: Settings.language.value))
            
            let genreSections = movieByGenres.map { Section(title: $0.genre.name,
                                                            data: $0.movies.map { SingleCell(model: $0) },
                                                            type: .small) }
            
            state.sections.append(contentsOf: genreSections)
            
        } catch {
            self.state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    func pullToRefresh() async {
        state.sections = []
        await self.fetchDataFromApi()
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
