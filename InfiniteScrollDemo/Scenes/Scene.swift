//
//  Scene.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

enum Scene {
    case list(ListViewModel)
}

// View(controller) factory
extension Scene {
    func createViewController(asNavigationRoot: Bool) -> UIViewController {
        var viewController: UIViewController
        switch self {
        case .list(let viewModel):
            viewController = ListViewController()
            if var listViewController = viewController as? ListViewController {
                listViewController.bindViewModel(to: viewModel)
            }
        }
        return asNavigationRoot ? NavigationController(rootViewController: viewController) : viewController
    }
}
