//
//  FollowersListVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 11/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        guard let username else { return }
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] followers, errorMessage in
            guard let self else { return }
            guard let followers else {
                showAlert(title: "Bad Stuff Happened", message: errorMessage ?? "", btnTitle: "OK")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
