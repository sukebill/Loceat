//
//  Loader.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

class Loader {
    static let loaderSize: CGFloat = 100
    
    class func show(to view: UIView) {
        let frame = CGRect(x: view.bounds.origin.x,
                           y: view.bounds.origin.y,
                           width: view.bounds.width,
                           height: view.bounds.height)
        let bgView = UIView(frame: frame)
        bgView.backgroundColor = .clear
        let spinnerBG = UIView(frame: CGRect(x: (frame.width / 2) - (loaderSize / 2),
                                             y: (frame.height / 2) - (loaderSize / 2),
                                             width: loaderSize,
                                             height: loaderSize))
        spinnerBG.layer.cornerRadius = 12
        spinnerBG.backgroundColor = .white
        let spinner = UIImage(named: "Loader")
        spinnerBG.center = bgView.center
        let spinnerImageView = UIImageView(frame: CGRect(origin: .zero,
                                                         size: CGSize(width: 50, height: 50)))
        spinnerImageView.image = spinner
        spinnerImageView.center = spinnerBG.center
        bgView.tag = 999
        bgView.addSubview(spinnerBG)
        bgView.addSubview(spinnerImageView)
        view.addSubview(bgView)
        rotateAnimation(spinnerImageView)
    }
    
    private class func rotateAnimation(_ spinner: UIImageView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 1.2
        animation.repeatCount = .greatestFiniteMagnitude
        spinner.layer.add(animation, forKey: nil)
    }
    
    class func hide(from view: UIView) {
        for item in view.subviews where item.tag == 999 {
            UIView.animate(withDuration: 0.3, animations: {
                item.alpha = 0
            }) { (_) in
                item.removeFromSuperview()
                view.isUserInteractionEnabled = true
            }
        }
    }
}
