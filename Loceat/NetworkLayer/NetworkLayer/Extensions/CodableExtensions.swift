//
//  CodableExtensions.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import Foundation

extension Decodable {
    public static func jsonToDecoder(_ dictionary: [String: Any]) -> Self? {
        do {
            let options = JSONSerialization.WritingOptions.prettyPrinted
            let jsonData: Data = try JSONSerialization.data(withJSONObject: dictionary, options: options)
            let object = try JSONDecoder().decode(self, from: jsonData)
            return object
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
