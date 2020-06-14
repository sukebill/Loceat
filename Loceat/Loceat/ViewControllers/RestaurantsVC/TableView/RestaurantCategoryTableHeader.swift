//
//  RestaurantCategoryTableHeader.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 14/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit
import NetworkLayer

class RestaurantCategoryTableHeader: UITableViewHeaderFooterView {
    
    @IBOutlet var addressBig: UILabel!
    @IBOutlet var addressSmall: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    
    func setUp(address: String?, city: String?, category: NetworkLayer.Category) {
        addressBig.isHidden = address == nil && city == nil
        addressSmall.isHidden = addressBig.isHidden
        categoryLabel.text = category.pluralName
        addressBig.text = address
        addressSmall.text = city
    }
}
