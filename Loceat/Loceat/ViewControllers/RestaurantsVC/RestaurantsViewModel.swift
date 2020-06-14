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
    typealias SectionData = (category: NetworkLayer.Category, restaurants: [Venue])
    var tableData: [SectionData] = []
    
    init(address: GMSAddress?, coordinates: CLLocationCoordinate2D) {
        self.address = address
        self.coordinates = coordinates
    }
}

// MARK: Mutations

extension RestaurantsViewModel {
    mutating func setUpTableData(_ venues: [Venue]) {
        tableData = []
        for venue in venues {
            guard let category = venue.primaryCategory else { continue }
            tableData.append(venue: venue, inCategory: category)
        }
    }
}

// MARK: Api Calls

extension RestaurantsViewModel {
    func fetchRestaurants(onCompletion: @escaping ([Venue], Error?) -> Void) {
        LoceatAPI.shared.fetchRestaurants(lat: coordinates.latitude,
                                          long: coordinates.longitude) { (venues, error) in
                                            onCompletion(venues, error)
        }
    }
}

extension Array where Element == RestaurantsViewModel.SectionData {
    func contains(category: NetworkLayer.Category) -> Bool {
        contains { $0.category == category }
    }
    
    fileprivate mutating func append(venue: Venue,
                                     inCategory category: NetworkLayer.Category) {
        
        guard contains(category: category) else {
            append((category, [venue]))
            return
        }
        for index in 0..<count where self[index].category == category {
            self[index].restaurants.append(venue)
            return
        }
    }
}
