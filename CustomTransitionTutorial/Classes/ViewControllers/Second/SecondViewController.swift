//
//  SecondViewController.swift
//  CustomTransitionDemo
//
//  Created by Tung on 13.10.19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private(set) weak var searchBar: SearchBar!

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        setupSearchBar()
        super.viewDidLoad()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(named: "sample"), for: .bookmark, state: .normal)
    }


}

extension SecondViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }


}
