//
//  Icon.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

public struct Icon: Codable {
    let prefix: String
    let suffix: String
    public var url: String {
        prefix + suffix
    }
    
    enum CodingKeys: String, CodingKey {
        case prefix = "prefix"
        case suffix = "suffix"
    }
}
