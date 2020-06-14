//
//  AppDelegate.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navCtrl = LoceatNavigationController(rootViewController: Route.start.viewController)
        navCtrl.setNavigationBarHidden(true, animated: false)
        navCtrl.delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navCtrl
        window?.makeKeyAndVisible()
        initGoogleMaps()
        return true
    }
    
    private func initGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyBW1Dkmby8qOMZvNy-JWV1KmKuR39DWfkc")
    }
}

extension AppDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
        guard let preferred = viewController as? PreferredNavigationBar else {
            navigationController.navigationBar.configureBar()
            return
        }
        navigationController.setNavigationBarHidden(preferred.prefersNavigationBarHidden,
                                                    animated: animated)
        navigationController.navigationBar.configureBar(color: preferred.preferredNavigationBarColor,
                                                        titleColor: preferred.preferredNavigationTitleColor)
    }
}
