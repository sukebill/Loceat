//
//  Venue.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Venue: Codable {
    public let name: String?
    public let location: Location?
    public let categories: [Category]?
    public var primaryCategory: Category? {
        categories?.lazy.filter { $0.isPrimary }.first ?? categories?.first
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
        case categories = "categories"
    }
}
