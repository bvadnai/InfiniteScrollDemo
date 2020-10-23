//
//  Scene.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

enum Scene {
    case list
    case details(Repository)
}

// View(controller) factory

extension Scene {
    func createViewController(asNavigationRoot: Bool) -> UIViewController {
        var viewController: UIViewController
        switch self {
        case .list:
            viewController = ListViewController()
            if var listViewController = viewController as? ListViewController {
                let viewModel = sharedApplication.assembler.resolver.resolve(ListViewModelProtocol.self)!
                listViewController.bindViewModel(to: viewModel)
            }
        case .details(let repository):
            viewController = DetailsViewController()
            if var detailsViewController = viewController as? DetailsViewController {
                let viewModel = sharedApplication.assembler.resolver.resolve(DetailsViewModelProtocol.self, argument: repository)!
                detailsViewController.bindViewModel(to: viewModel)
            }
        }
        return asNavigationRoot ? NavigationController(rootViewController: viewController) : viewController
    }
}
