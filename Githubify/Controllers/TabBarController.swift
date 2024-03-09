//
//  TabBarController.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 03/03/2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavController(), createFavListNavController()]
    }
    
    func createSearchNavController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavListNavController() -> UINavigationController {
        let favListVC = FavoritesListVC()
        favListVC.title = "Favorites"
        favListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favListVC)
    }
}
