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
    }
    
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomSafeArea, right: 0)
    }
}

// MARK: UI Table View Delegate

extension RestaurantsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 28
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
//        view.backgroundColor = .black
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
//        view.backgroundColor = .black
//        return view
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Do something on selection
    }
}

// MARK: UI Table View Datasource

extension RestaurantsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell",
                                                 for: indexPath)
        
        return cell
    }
}

extension RestaurantsViewController: PreferredNavigationBar {
    var prefersNavigationBarHidden: Bool { false }
}
