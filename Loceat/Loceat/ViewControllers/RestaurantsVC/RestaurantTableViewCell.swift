//
//  RestaurantTableViewCell.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 13/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    func setUp(with name: String, and distance: String) {
        nameLabel.text = name
        distanceLabel.text = distance
    }
}
