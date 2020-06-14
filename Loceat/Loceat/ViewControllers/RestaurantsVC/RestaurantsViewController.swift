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
    @IBOutlet var errorMessage: UILabel!
    
    var viewModel: RestaurantsViewModel!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: Set up

extension RestaurantsViewController {
    private func setUp() {
        title = ""
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
        Loader.show(to: view)
        viewModel.fetchRestaurants { [weak self] (venues, error) in
            guard let self = self else { return }
            Loader.hide(from: self.view)
            guard error == nil else {
                self.showError(error)
                return
            }
            self.viewModel.setUpTableData(venues)
            self.tableView.reloadData()
        }
    }
}

// MARK: Error

extension RestaurantsViewController {
    private func showNotFoundMessageIfNeeded() {
        errorMessage.isHidden = viewModel.tableData.count > 0
        tableView.isHidden = !errorMessage.isHidden
    }
    
    private func showError(_ error: Error?) {
        showAlert(message: error?.localizedDescription ?? "Something went wrong")
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
                      category: viewModel.tableData[section].category.shortName,
                      iconUrl: viewModel.tableData[section].category.icon.url32)
        return header
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

// MARK: UI ScrollView Delegate

extension RestaurantsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        title = yOffset > 48 ? viewModel.address?.thoroughfare : ""
    }
}

extension RestaurantsViewController: PreferredNavigationBar {
    var prefersNavigationBarHidden: Bool { false }
}
