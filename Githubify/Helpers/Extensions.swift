//
//  Extensions.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 11/02/2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, btnTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(alertTitle: title, message: message, btnTitle: btnTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
