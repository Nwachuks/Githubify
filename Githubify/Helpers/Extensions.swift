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

extension UICollectionViewFlowLayout {
    func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
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
}
