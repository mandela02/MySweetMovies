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
class HomeViewModel: BaseViewModel<HomeViewModel.State> {
    
    init(navigator: HomeNavigatorProtocol,
         getHomeUseCase: GetHomeUseCase,
         getMoviesByGenresUseCase: GetMoviesByGenresUseCase) {
        self.navigator = navigator
        self.getHomeUseCase = getHomeUseCase
        self.getMoviesByGenresUseCase = getMoviesByGenresUseCase
        super.init(state: State())
        
        NotificationCenter.default.publisher(for: .languageDidChange)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                Task { @MainActor in
                    await self.pullToRefresh()
                }
            })
            .store(in: &cancellables)
    }
    
    private let navigator: HomeNavigatorProtocol
    
    private let getHomeUseCase: GetHomeUseCase
    private let getMoviesByGenresUseCase: GetMoviesByGenresUseCase
    
    func fetchDataFromApi() async {
        do {
            self.state.loadingStatus = .inProcess
            let movies = try await getHomeUseCase.run(input: Settings.language.value)
            
            let upcoming = Section(title: "", data: movies.upcoming.map { SingleCell(model: $0) }, type: .big, kind: .upcoming)
            let nowPlaying = Section(title: .nowPlaying, data: movies.nowPlaying.map { SingleCell(model: $0) }, type: .small, kind: .nowPlaying)
            let popular = Section(title: .trending, data: movies.popular.map { SingleCell(model: $0) }, type: .small, kind: .popular)
            let topRated = Section(title: .topRated, data: movies.topRated.map { SingleCell(model: $0) }, type: .small, kind: .topRated)
            
            state.sections = [upcoming, nowPlaying, popular, topRated]
            
            self.state.loadingStatus = .success
            
            let movieByGenres = try await getMoviesByGenresUseCase.run(input: .init(genres: Application.shared.genresManager.movieGenres,
                                                                                    language: Settings.language.value))
            
            let genreSections = movieByGenres.map { Section(title: $0.genre.name,
                                                            data: $0.movies.map { SingleCell(model: $0) },
                                                            type: .small, kind: .genre($0.genre)) }
            
            state.sections.append(contentsOf: genreSections)
            
        } catch {
            self.state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    func pullToRefresh() async {
        state.sections = []
        await self.fetchDataFromApi()
    }
    
    func goToList(kind: MovieListKind) {
        self.navigator.goToList(kind: kind)
    }
    
    func goToMovie() {
        self.navigator.goToMovie()
    }
    
    enum SectionType {
        case big
        case small
    }
    
    struct Section: GenericSection {
        var title: String
        var data: [any Cell]
        
        var type: SectionType
        var kind: MovieListKind
    }
    
    
    struct State {
        var loadingStatus: LoadingStatus = .initial
        var sections: [Section] = []
    }
}
