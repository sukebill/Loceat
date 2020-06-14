//
//  RestaurantsViewModel.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 13/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import NetworkLayer

struct RestaurantsViewModel {
    let address: GMSAddress?
    let coordinates: CLLocationCoordinate2D
    
    init(address: GMSAddress?, coordinates: CLLocationCoordinate2D) {
        self.address = address
        self.coordinates = coordinates
        fetchRestaurants()
    }
}

// MARK: Api Calls

extension RestaurantsViewModel {
    func fetchRestaurants() {
        LoceatAPI.shared.fetchRestaurants(lat: coordinates.latitude,
                                          long: coordinates.longitude) { (venues, error) in
                                            debugPrint(venues)
        }
    }
}
