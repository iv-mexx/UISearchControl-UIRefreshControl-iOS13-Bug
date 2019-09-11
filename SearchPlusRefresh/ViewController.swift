//
//  ViewController.swift
//  SearchPlusRefresh
//
//  Created by Markus Chmelar on 22.08.19.
//  Copyright © 2019 Innovaptor. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  let searchController = UISearchController(searchResultsController: nil)
  var searchTerm: String?

  override func viewDidLoad() {
    extendedLayoutIncludesOpaqueBars = true
    title = searchTerm ?? "Search"
    super.viewDidLoad()
    setupSearch()
    setupRefresh()
  }

  private func setupSearch() {
    searchController.searchResultsUpdater = self
    navigationItem.searchController = searchController

    if let searchTerm = searchTerm, !searchTerm.isEmpty {
      searchController.searchBar.text = searchTerm

      DispatchQueue.main.async {
        self.searchController.isActive = true
      }
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  private func setupRefresh() {
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }

  @objc func refresh() {
    print("Refresh")
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
      print("Refresh done")
      self.refreshControl?.endRefreshing()
      DispatchQueue.main.async {
        print("Reload Data")
        self.tableView.reloadData()
      }
    }
  }
}

extension ViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showDetailSearch()
  }

  private func showDetailSearch() {
    guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "Search") as? ViewController else {
      return
    }
    detailViewController.searchTerm = searchTerm

    //
    // If the SearchBar is visible (but not active) due to scroll, the push animation is buggy
    //
    DispatchQueue.main.async {
      self.navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for controller: UISearchController) {
    searchTerm = controller.searchBar.text ?? ""
  }
}

extension UITableViewController {
  func hideSearchBar() {
  }
}
