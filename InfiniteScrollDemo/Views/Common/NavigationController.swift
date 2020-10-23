//
//  NavigationController.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

final class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        super.loadView()

        navigationBar.barTintColor = UIColor(white: 10.0 / 255.0, alpha: 1)
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.helvetica(ofSize: 17)]
        navigationBar.tintColor = .white
    }
}
