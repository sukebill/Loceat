//
//  Location.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Location: Codable {
    let address: String?
    let city: String?
    let distance: Int?
    let postalCode: String?
    let crossStreet: String?
    let country: String?
    let formattedAddress: [String]
    let lat: Double
    let long: Double
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case city = "city"
        case distance = "distance"
        case postalCode = "postalCode"
        case crossStreet = "crossStreet"
        case country = "country"
        case formattedAddress = "formattedAddress"
        case lat = "lat"
        case long = "lng"
    }
}
