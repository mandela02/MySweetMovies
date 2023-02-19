//
//  MovieDetailNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import UIKit
import Domain

protocol MovieDetailNavigatorProtocol: BaseNavigator {
    func goToCheckout()
    func goToCollection(collection: MovieCollection, onSelect: @escaping (Movie) -> Void)
}

struct MovieDetailNavigator: MovieDetailNavigatorProtocol {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
    
    func goToCheckout() {
        let viewController = BaseViewController(rootView: CheckOutView())
        self.navigationController.present(viewController, animated: true)
    }
    
    @MainActor
    func goToCollection(collection: MovieCollection, onSelect: @escaping (Movie) -> Void) {
        let getMovieCollectinoUseCase = Application.shared.userCaseProvider.getMovieCollectinoUseCase()
        let viewModel = MovieCollectionViewModel(collection: collection,
                                                 getMovieCollectinoUseCase: getMovieCollectinoUseCase)
        let view = MovieCollectionScreen(viewModel: viewModel, onSelect: onSelect)
        let viewController = BaseViewController(rootView: view)
        self.navigationController.present(viewController, animated: true)
    }
}
