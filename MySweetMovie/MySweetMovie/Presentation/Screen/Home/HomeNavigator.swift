//
//  HomeNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Domain
import UIKit

protocol HomeNavigatorProtocol: BaseNavigator {
    func goToList(kind: MovieListKind)
}

struct HomeNavigator: HomeNavigatorProtocol {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    var navigationController: UINavigationController
    
    @MainActor
    func goToList(kind: MovieListKind) {
        let navigator = MovieListNavigator(navigationController: self.navigationController)
        
        let getMoviesUseCase = Application.shared.userCaseProvider.getMoviesUseCase()
        let getMoviesByGenreUseCase = Application.shared.userCaseProvider.getMoviesByGenreUseCase()
        let viewModel = MovieListViewModel(kind: kind,
                                           navigator: navigator,
                                           getMoviesUseCase: getMoviesUseCase,
                                           getMoviesByGenreUseCase: getMoviesByGenreUseCase)
        let view = MovieListScreen(viewModel: viewModel)
        let viewController = BaseViewController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
