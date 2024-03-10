//
//  AlertVC.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 11/02/2024.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = BodyLabel(textAlignment: .center)
    let actionBtn = MainButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var btnTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, btnTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.btnTitle = btnTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        // Do any additional setup after loading the view.
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Error occurred"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionBtn)
        actionBtn.setTitle(btnTitle ?? "OK", for: .normal)
        actionBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionBtn.topAnchor, constant: -12)
        ])
    }
}
