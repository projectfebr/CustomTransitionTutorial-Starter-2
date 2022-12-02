//
//  FirstController+SearchBarDelegate.swift
//  CustomTransitionTutorial
//
//  Created by Aleksandr Bolotov on 30.11.2022.
//  Copyright © 2022 Tung. All rights reserved.
//

import UIKit

extension FirstViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBarViewSnapshot = searchBar.snapshotView(afterScreenUpdates: false)
        barCodeButtonViewSnapshot = barCodeButton.snapshotView(afterScreenUpdates: false)
        presentSecondViewController()
        return true
    }
}
