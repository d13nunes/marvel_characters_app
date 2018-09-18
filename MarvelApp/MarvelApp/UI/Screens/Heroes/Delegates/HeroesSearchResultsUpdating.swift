//
//  HeroesSearchResultsUpdating.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 23/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import UIKit

extension HeroesScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        search(for: searchController.isActive ? searchController.searchBar.text : nil)
    }
}

