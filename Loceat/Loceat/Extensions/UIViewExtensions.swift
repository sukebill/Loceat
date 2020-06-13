//
//  UIViewExtensions.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 13/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(_ color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
