//
//  RepoItemVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 03/03/2024.
//

import UIKit

class RepoItemVC: ItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureItems()
    }
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .repos, count: user?.publicRepos ?? 0)
        secondItemInfoView.set(itemInfoType: .gists, count: user?.publicGists ?? 0)
        actionBtn.set(backgroundColor: .systemPurple, title: "Github Profile")
    }

}
