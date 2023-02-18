//
//  MovieDetailNavigator.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import UIKit

protocol MovieDetailNavigatorProtocol: BaseNavigator {
}

struct MovieDetailNavigator: MovieDetailNavigatorProtocol {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
}
