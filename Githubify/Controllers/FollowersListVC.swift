//
//  FollowersListVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 11/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var collectionView: UICollectionView!
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let availableWidth: CGFloat = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth: CGFloat = availableWidth / 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return layout
    }
    
    func getFollowers() {
        guard let username else { return }
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
            case .failure(let error):
                showAlert(title: "Bad Stuff Happened", message: error.rawValue, btnTitle: "OK")
                return
            }
        }
    }
}
