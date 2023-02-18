//
//  MovieListNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import UIKit

protocol MovieListNavigatorProtocol: BaseNavigator {
}

struct MovieListNavigator: MovieListNavigatorProtocol {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
}
