//
//  Venue.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Venue: Codable {
    let name: String?
    let location: Location?
    let categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
        case categories = "categories"
    }
}
