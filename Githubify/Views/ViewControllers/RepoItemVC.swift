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
        guard let user else { return }
        firstItemInfoView.set(itemInfoType: .repos, count: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, count: user.publicGists)
        actionBtn.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionBtnTapped() {
        guard let user else { return }
        itemInfoDelegate.didTapGithubProfile(for: user)
    }
}
