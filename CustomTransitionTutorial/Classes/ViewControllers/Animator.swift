//
//  Animator.swift
//  CustomTransitionTutorial
//
//  Created by Tung on 27.11.19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    static let duration: TimeInterval = 0.25

    private let firstViewController: FirstViewController
    private let secondViewController: SecondViewController
    private var searchBarViewSnapshot: UIView
    private var barCodeButtonViewSnapshot: UIView
    private let searchBarViewRect: CGRect
    private let barCodeButtonViewRect: CGRect


    init?(firstViewController: FirstViewController, secondViewController: SecondViewController, searchBarViewSnapshot: UIView, barCodeButtonViewSnapshot: UIView) {
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.searchBarViewSnapshot = searchBarViewSnapshot
        self.barCodeButtonViewSnapshot = barCodeButtonViewSnapshot

        guard let window = firstViewController.view.window,
              let searchBar = firstViewController.searchBar,
              let barCodeButton = firstViewController.barCodeButton
        else { return nil }

        self.searchBarViewRect = searchBar.convert(searchBar.bounds, to: window)
        self.barCodeButtonViewRect = barCodeButton.convert(barCodeButton.bounds, to: window)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = secondViewController.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        guard let searchBar = firstViewController.searchBar,
              let barCodeButton = firstViewController.barCodeButton,
              let window = firstViewController.view.window,
              let searchBarSnapshot = searchBar.snapshotView(afterScreenUpdates: true),
              let barCodeButtonSnapshot = barCodeButton.snapshotView(afterScreenUpdates: true),
              let secondSearchBarSnapshot = secondViewController.searchBar.snapshotView(afterScreenUpdates: true),
                let secondBarCodeButtonSnapshot = secondViewController.searchBar.searchTextField.rightView?.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }

        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor

        searchBarViewSnapshot = searchBarSnapshot
        barCodeButtonViewSnapshot = barCodeButtonSnapshot
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0

        toView.alpha = 0

        [backgroundView, searchBarViewSnapshot,barCodeButtonViewSnapshot, secondSearchBarSnapshot, secondBarCodeButtonSnapshot].forEach { containerView.addSubview($0) }



        let secondSearchBarViewRect = secondViewController.searchBar.convert(secondViewController.searchBar.bounds, to: window)
        let secondBarCodeButtonViewRect = secondViewController.searchBar.searchTextField.rightView?.convert(secondViewController.searchBar.searchTextField.rightView?.bounds ?? CGRect.zero, to: window) ?? CGRect.zero

        [searchBarViewSnapshot, secondSearchBarSnapshot].forEach {
            $0.frame = searchBarViewRect
        }

        secondSearchBarSnapshot.alpha = 0
        searchBarViewSnapshot.alpha = 1
        secondBarCodeButtonSnapshot.alpha = 0

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.searchBarViewSnapshot.frame = secondSearchBarViewRect
                self.barCodeButtonViewSnapshot.frame = secondBarCodeButtonViewRect
                secondSearchBarSnapshot.frame = secondSearchBarViewRect
                fadeView.alpha = 1
                toView.alpha = 1
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.searchBarViewSnapshot.alpha = 0
                secondSearchBarSnapshot.alpha = 1

            }
        }, completion: { _ in
            self.searchBarViewSnapshot.removeFromSuperview()
            secondSearchBarSnapshot.removeFromSuperview()

            backgroundView.removeFromSuperview()

            toView.alpha = 1
            transitionContext.completeTransition(true)
        })
    }
}
