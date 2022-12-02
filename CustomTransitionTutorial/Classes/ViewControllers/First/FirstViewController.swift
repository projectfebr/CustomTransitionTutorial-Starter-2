//
//  FirstViewController.swift
//  CustomTransitionDemo
//
//  Created by Tung on 12.10.19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
//    var selectedCell: CollectionViewCell?
    var searchBarViewSnapshot: UIView?
    var barCodeButtonViewSnapshot: UIView?

    var animator: Animator?

    
    @IBOutlet weak var barCodeButton: UIButton!
    @IBOutlet private(set) weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupSearchBar()
    }

    func presentSecondViewController() {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        navigationController?.delegate = self
        navigationController?.pushViewController(secondViewController, animated: true)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }
}
