//
//  LoceatNavigationController.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

public class LoceatNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        childForStatusBarStyle?.preferredStatusBarStyle ?? topViewController?.preferredStatusBarStyle ?? .default
    }
}
