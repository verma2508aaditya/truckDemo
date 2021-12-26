//
//  ViewController.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 23/12/21.
//

import UIKit
import Alamofire
import ObjectMapper

class TruckListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var truckListTableView: UITableView!
    
    // MARK: - Variables
    
    var searchBar: UISearchBar!
    var viewModel : TruckListViewModel?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckListTableView.delegate = self
        truckListTableView.dataSource = self
        viewModel = TruckListViewModel()
        getTruckList()
        setupSearchBar()
    }
    
    // MARK: - IBActions
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TruckMapViewController") as? TruckMapViewController
        vc?.viewModel = TruckMapViewModel()
        vc?.viewModel?.trucklistData = viewModel?.filteredtrucklistData
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        self.getTruckList()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        if (viewModel?.filteredtrucklistData?.count ?? 0) > 0 {
            self.truckListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        }
    }
    
    // MARK: - Get Data
    
    fileprivate func getTruckList() {
        viewModel?.getTruckList(completion: { (truckData) in
            self.truckListTableView.reloadData()
            if (self.viewModel?.filteredtrucklistData?.count ?? 0) > 0 {
                self.truckListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        })
    }
    
    // MARK: - Search Bar
    
    fileprivate func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.sizeToFit()
        truckListTableView.tableHeaderView = searchBar
    }
}

// MARK: - Table View Delegates And DataSource

extension TruckListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.filteredtrucklistData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TruckTableViewCell.self), for: indexPath) as! TruckTableViewCell
        cell.setupUI()
        cell.initialiseTruckData(with: self.viewModel?.filteredtrucklistData?[indexPath.row])
        return cell
    }
}

// MARK: - Searching Data

extension TruckListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            self.viewModel?.filteredtrucklistData = self.viewModel?.trucklistData
            self.truckListTableView.reloadData()
            if (viewModel?.filteredtrucklistData?.count ?? 0) > 0 {
                self.truckListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            return
        }
        self.viewModel?.filteredtrucklistData = self.viewModel?.trucklistData?.filter({ (truckObj) -> Bool in
            (truckObj.truckNumber?.contains(searchText) ?? false)
        })
        self.truckListTableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.filteredtrucklistData = self.viewModel?.trucklistData
        self.truckListTableView.reloadData()
    }
}
