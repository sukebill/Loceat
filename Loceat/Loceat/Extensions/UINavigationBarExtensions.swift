//
//  UINavigationBarExtensions.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 13/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

protocol PreferredNavigationBar {
    var prefersNavigationBarHidden: Bool { get }
    var preferredNavigationBarColor: UIColor { get }
    var preferredNavigationTitleColor: UIColor { get }
}

extension PreferredNavigationBar {
    var preferredNavigationTitleColor: UIColor { return .white } // default
    var preferredNavigationBarColor: UIColor { return .black } // default
}

extension UINavigationBar {
    func configureBar(color: UIColor = .black,
                      titleColor: UIColor = .white,
                      letterSpacing: CGFloat? = nil,
                      tintColor: UIColor? = nil) {
        backIndicatorTransitionMaskImage = nil
        backIndicatorImage = nil
        self.tintColor = tintColor ?? titleColor
        
        titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .medium),
                               .foregroundColor: titleColor]
        largeTitleTextAttributes = titleTextAttributes
        isTranslucent = color == .clear
        shadowImage = UIImage()
        backgroundColor = color
        barTintColor = color
    }
}
