//
//  RestaurantsViewController.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 13/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: RestaurantsViewModel!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: Set up

extension RestaurantsViewController {
    private func setUp() {
        title = viewModel.address?.thoroughfare
        setUpTable()
        loadRestaurants()
    }
    
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: bottomSafeArea, right: 0)
        let nibName = UINib(nibName: "RestaurantCategoryTableHeader", bundle: nil)
        tableView.register(nibName,
                           forHeaderFooterViewReuseIdentifier: "RestaurantCategoryTableHeader")
    }
    
    private func loadRestaurants() {
        viewModel.fetchRestaurants { [weak self] (venues, error) in
            guard error == nil else { return }
            self?.viewModel.setUpTableData(venues)
            self?.tableView.reloadData()
        }
    }
}

// MARK: UI Table View Delegate

extension RestaurantsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 136 : 88
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RestaurantCategoryTableHeader") as? RestaurantCategoryTableHeader
        let address = section == 0 ? viewModel.addressHeaderText : nil
        let city = section == 0 ? viewModel.cityHeaderText : nil
        header?.setUp(address: address,
                      city: city,
                      category: viewModel.tableData[section].category)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Do something on selection
    }
}

// MARK: UI Table View Datasource

extension RestaurantsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData[section].restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell",
                                                 for: indexPath) as! RestaurantTableViewCell
        let restaurant = viewModel.tableData[indexPath.section].restaurants[indexPath.row]
        cell.setUp(name: restaurant.name, distance: restaurant.location?.distanceInKM ?? "")
        return cell
    }
}

extension RestaurantsViewController: PreferredNavigationBar {
    var prefersNavigationBarHidden: Bool { false }
}
