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
        firstItemInfoView.set(itemInfoType: .followers, count: user?.followers ?? 0)
        secondItemInfoView.set(itemInfoType: .following, count: user?.following ?? 0)
        actionBtn.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
