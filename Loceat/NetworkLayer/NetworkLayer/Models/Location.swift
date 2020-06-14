//
//  Location.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Location: Codable {
    public let address: String?
    public let city: String?
    public let distance: Int?
    public let postalCode: String?
    public let crossStreet: String?
    public let country: String?
    public let formattedAddress: [String]
    public let lat: Double
    public let long: Double
    public var distanceInKM: String {
        guard let distance = distance else {
            return ""
        }
        let kilometers: Double = Double(distance) / 1000.0
        return String(kilometers) + "km"
    }
    
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
