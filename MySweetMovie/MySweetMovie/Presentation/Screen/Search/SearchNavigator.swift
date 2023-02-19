//
//  SearchNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 20/02/2023.
//

import Foundation
import UIKit

protocol SearchNavigatorProtocol: BaseNavigator {
    func goToMovie(movieID: Int)
}

struct SearchNavigator: SearchNavigatorProtocol {
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
