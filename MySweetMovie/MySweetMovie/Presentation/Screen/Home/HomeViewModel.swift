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
    
    init(getHomeUseCase: GetHomeUseCase) {
        self.getHomeUseCase = getHomeUseCase
        super.init(state: HomeState())
    }
    
    let getHomeUseCase: GetHomeUseCase
    
    func fetchDataFromApi() async {
        do {
            let result = try await getHomeUseCase.run(input: Settings.language.value)
            
            let upcoming = Section(title: "", data: result.upcoming.map { SingleCell(model: $0) }, type: .big)
            let nowPlaying = Section(title: .nowPlaying, data: result.nowPlaying.map { SingleCell(model: $0) }, type: .small)
            
            state.sections = [upcoming, nowPlaying]
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
