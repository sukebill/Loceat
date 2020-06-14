//
//  Route.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

enum Route: RouteProtocol {
    case start
    case restaurants(address: GMSAddress?, coordinates: CLLocationCoordinate2D)
    
    var viewController: UIViewController {
        switch self {
        case .start:
            return StartViewController.instantiate(fromAppStoryboard: .main)
        case .restaurants(let address, let coordinates):
            let destination = RestaurantsViewController.instantiate(fromAppStoryboard: .main)
            destination.viewModel = RestaurantsViewModel(address: address,
                                                         coordinates: coordinates)
            return destination
        }
    }
}
