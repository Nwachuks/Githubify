//
//  UserInfoVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 27/02/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let detailView = UIView()
    let subDetailView = UIView()
    let dateLabel = BodyLabel(textAlignment: .center)
    
    var username = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        // Do any additional setup after loading the view.
        layoutUI()
        getUserInfo()
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(detailView)
        view.addSubview(subDetailView)
        view.addSubview(dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        subDetailView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 150
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            detailView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            detailView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            subDetailView.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: padding),
            subDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            subDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            subDetailView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: subDetailView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: RepoItemVC(user: user), to: self.detailView)
                    self.add(childVC: FollowerItemVC(user: user), to: self.subDetailView)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToDate().convertToMonthYearFormat())"
                }
            case .failure(let error):
                showAlert(title: "Error occurred", message: error.rawValue, btnTitle: "OK")
            }
        }
    }
}
