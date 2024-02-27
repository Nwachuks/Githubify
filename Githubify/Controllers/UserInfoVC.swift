//
//  UserInfoVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 27/02/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        // Do any additional setup after loading the view.
        getUserInfo()
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                showAlert(title: "Error occurred", message: error.rawValue, btnTitle: "OK")
            }
        }
    }
}
