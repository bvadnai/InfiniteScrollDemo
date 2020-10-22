//
//  Scene.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//


import UIKit

enum Scene {
    case list
}

// View(controller) factory
extension Scene {
    func createViewController(asNavigationRoot: Bool) -> UIViewController {
        let viewController: UIViewController
        switch self {
        case .list:
            viewController = ListViewController()
        }
        return asNavigationRoot ? NavigationController(rootViewController: viewController) : viewController
    }
}
