//
//  SearchViewController.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    lazy var searchBar = UISearchBar(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    //MARK:-
    private func addNavigationSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("search for: \(searchBar.text ?? "No filter found")")
    }
}
