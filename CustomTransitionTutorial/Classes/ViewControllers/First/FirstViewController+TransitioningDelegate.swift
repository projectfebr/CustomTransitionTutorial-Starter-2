//
//  FirstViewController+TransitioningDelegate.swift
//  CustomTransitionTutorial
//
//  Created by Tung on 27.11.19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
// B1 - 1
//extension FirstViewController: UIViewControllerTransitioningDelegate {
////
////    // B1 - 2
////    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
////        // B2 - 16
////          guard let firstViewController = presenting as? FirstViewController,
////              let secondViewController = presented as? SecondViewController,
////              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
////              else { return nil }
////
////          animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
////          return animator
////    }
////
////    // B1 - 3
////    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
////        // B2 - 17
////        guard let secondViewController = dismissed as? SecondViewController,
////            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
////            else { return nil }
////
////        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
////        return animator
////    }
//}

extension FirstViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let firstViewController = fromVC as? FirstViewController,
            let secondViewController = toVC as? SecondViewController,
            let searchBarViewSnapshot = searchBarViewSnapshot,
            let barCodeButtonViewSnapshot = barCodeButtonViewSnapshot
            else { return nil }

        animator = Animator(firstViewController: firstViewController, secondViewController: secondViewController, searchBarViewSnapshot: searchBarViewSnapshot, barCodeButtonViewSnapshot: barCodeButtonViewSnapshot)
        return animator
    }
}
