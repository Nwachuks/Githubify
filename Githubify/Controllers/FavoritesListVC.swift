//
//  FavoritesListVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 11/02/2024.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        // Do any additional setup after loading the view.
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }

}
