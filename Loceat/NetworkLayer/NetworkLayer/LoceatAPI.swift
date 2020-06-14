//
//  LoceatAPI.swift
//  NetworkLayer
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import FoursquareAPIClient

public class LoceatAPI {
    private let clientId: String = "SWG3G4CQRJVQBZRXAB5KI3ZDRVWBQOVZ155TK2CTZS1D5OQD"
    private let clientSecret: String = "EUVHBYUVTUDFEDCAG1NLGRVJTJSFFFISQJRUOBXUA3WMNNN0"
    public static let shared: LoceatAPI = LoceatAPI()
    let client: FoursquareAPIClient
    private init() {
        client = FoursquareAPIClient(clientId: clientId, clientSecret: clientSecret)
    }
}

// MARK: Restaurants

public extension LoceatAPI {
    func fetchRestaurants(lat: Double,
                          long: Double,
                          completionHandler: @escaping ([Venue], Error?) -> Void) {
        
        let parameters: [String: String] = [
            "ll": "\(lat),\(long)",
            "limit": "100",
            "categoryId": "4d4b7105d754a06374d81259",
            "radius": "1000"
        ]
        
        client.request(path: "venues/search", parameter: parameters) { result in
            
            switch result {
            case let .success(data):
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?]
                guard let response = json?["response"] as? [String: Any?],
                    let venuesJSON = response["venues"] as? [[String: Any]] else {
                    completionHandler([], nil)
                    return
                }
                var venues = [Venue]()
                for venueJson in venuesJSON {
                    guard let venue = Venue.jsonToDecoder(venueJson) else { continue }
                    venues.append(venue)
                }
                venues.sort {
                    $0.location?.distance ?? 0 < $1.location?.distance ?? 0
                }
                completionHandler(venues, nil)
            case let .failure(error):
                completionHandler([], error)
            }
        }
    }
}
