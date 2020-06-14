//
//  Category.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Category: Codable {
    public let id: String
    public let pluralName: String
    public let name: String
    public let shortName: String
    public let isPrimary: Bool
    public let icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pluralName = "pluralName"
        case name = "name"
        case shortName = "shortName"
        case isPrimary = "primary"
        case icon = "icon"
    }
}

extension Category: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
