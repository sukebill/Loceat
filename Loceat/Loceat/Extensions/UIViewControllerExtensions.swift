//
//  UIViewControllerExtensions.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

extension UIViewController {
    class var storyboardID: String { "\(self)" }

    class func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error",
                                        message: message,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func overrideBack(_ title: String? = nil, action: Selector? = nil) {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 44)
        backButton.tintColor = .white
        backButton.setImage(UIImage(named: "Back")!, for: .normal)
        backButton.setTitle(title ?? "", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.contentHorizontalAlignment = .leading
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        backButton.addTarget(self, action: action ?? #selector(pop), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
}
