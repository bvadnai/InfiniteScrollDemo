//
//  SceneCoordinator.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//


import UIKit

final class SceneCoordinator: SceneCoordinatorProtocol {
    // MARK: - Properties
    private var window: UIWindow
    private var currentViewController: UIViewController?

    // MARK: - Static functions
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first ?? viewController
        }
        return viewController
    }

    // MARK: - Initialization
    required init(window: UIWindow) {
        self.window = window
    }

    // MARK: - ScreenCoordinatorProtocol
    func transition(to scene: Scene, type: SceneTransitionType, animated: Bool) {
        let viewController = scene.createViewController(asNavigationRoot: type != .push)
        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self else { return }
            switch type {
            case .root:
                self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
                self.window.rootViewController = viewController
                // TODO rx
            case .push:
                guard let navigationController = self.currentViewController?.navigationController else {
                    break
                }
                // TODO rx
                navigationController.pushViewController(viewController, animated: animated)
            case .modal:
                self.currentViewController?.present(viewController, animated: animated) {
                    // TODO rx
                }
            }
        }
    }

    func pop(animated: Bool) {
        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self, let navigationController = self.currentViewController?.navigationController else {
                // TODO rx error
                return
            }
            if navigationController.popViewController(animated: animated) == nil {
                // TODO rx error
            } else {
                self.currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
                // TODO rx
            }
        }
    }

    func dismiss(animated: Bool) {
        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self, let presentingViewController = self.currentViewController?.presentingViewController else {
                // TODO rx error
                return
            }
            currentViewController?.dismiss(animated: animated) {
                // TODO rx
            }
            self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
        }
    }

}
