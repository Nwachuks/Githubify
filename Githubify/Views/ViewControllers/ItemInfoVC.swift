//
//  ItemInfoVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 03/03/2024.
//

import UIKit

class ItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let firstItemInfoView = ItemInfoView()
    let secondItemInfoView = ItemInfoView()
    let actionBtn = MainButton()
    
    var user: User?

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        // Do any additional setup after loading the view.
        layoutUI()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionBtn)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
