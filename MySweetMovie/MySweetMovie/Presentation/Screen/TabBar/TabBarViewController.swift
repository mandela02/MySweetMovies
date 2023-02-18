//
//  TabBarViewController.swift
//  MySweetMovie
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import UIKit

enum Tab: Int {
    case movies
    case tvs
    case search
    case discover
    case setting
}

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        self.tabBar.tintColor = .englishDaisy
        self.tabBar.unselectedItemTintColor = .philipineGray
        UIApplication.shared.addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupTabBar() {
        self.viewControllers = [buildMovie(),
                                buildTv(),
                                buildSearch(),
                                buildDiscover(),
                                buildSettings()]
    }
}

extension MainTabBarViewController {
    private func buildMovie() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let getHomeUseCase = Application.shared.userCaseProvider.getHomeUseCase()
        let getMoviesByGenresUseCase = Application.shared.userCaseProvider.getMoviesByGenresUseCase()
                
        let viewModel = HomeViewModel(getHomeUseCase: getHomeUseCase,
                                      getMoviesByGenresUseCase: getMoviesByGenresUseCase)
        let view = HomeScreen(viewModel: viewModel)
        
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: .movie,
                                                       image: .popcornFill,
                                                       tag: Tab.movies.rawValue)
        
        return navigationController
    }
    
    private func buildTv() -> UINavigationController {
        let navigationController = UINavigationController()
        let view = TvScreen()
        
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: .tv,
                                                       image: .tv,
                                                       tag: Tab.tvs.rawValue)
        
        return navigationController
    }
    
    private func buildSearch() -> UINavigationController {
        let navigationController = UINavigationController()
        let view = SearchScreen()
        
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: .search,
                                                       image: .magnifyingglass,
                                                       tag: Tab.search.rawValue)
        
        return navigationController
    }
    
    private func buildDiscover() -> UINavigationController {
        let navigationController = UINavigationController()
        let view = DiscoverScreen()
        
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: .discover,
                                                       image: .playFill,
                                                       tag: Tab.discover.rawValue)
        
        return navigationController
    }
    
    private func buildSettings() -> UINavigationController {
        let navigationController = UINavigationController()
        let view = SettingsScreen()
        
        let viewController = BaseViewController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: .setting,
                                                       image: .gear,
                                                       tag: Tab.setting.rawValue)
        
        return navigationController
    }
}
