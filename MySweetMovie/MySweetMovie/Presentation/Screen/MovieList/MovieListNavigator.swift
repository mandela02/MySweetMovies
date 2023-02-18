//
//  MovieListNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import UIKit

protocol MovieListNavigatorProtocol: BaseNavigator {
    func goToMovie(movieID: Int)
}

struct MovieListNavigator: MovieListNavigatorProtocol {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
    
    
    @MainActor
    func goToMovie(movieID: Int) {
        let navigator = MovieDetailNavigator(navigationController: self.navigationController)
        let getMovieDetailUseCase = Application.shared.userCaseProvider.getMovieDetailUseCase()
        
        let viewModel = MovieDetailViewModel(id: movieID,
                                             navigator: navigator,
                                             getMovieDetailUseCase: getMovieDetailUseCase)
        
        let view = MovieDetailScreen(viewModel: viewModel)
        let viewController = BaseViewController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
