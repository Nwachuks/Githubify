//
//  FollowerItemVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 03/03/2024.
//

import UIKit

class FollowerItemVC: ItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        // Do any additional setup after loading the view.
    }
    
    private func configureItems() {
        guard let user else { return }
        firstItemInfoView.set(itemInfoType: .followers, count: user.followers)
        secondItemInfoView.set(itemInfoType: .following, count: user.following)
        actionBtn.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionBtnTapped() {
        guard let user else { return }
        itemInfoDelegate.didTapGetFollowers(for: user)
    }
}
