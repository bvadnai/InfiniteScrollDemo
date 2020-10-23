//
//  SceneCoordinator.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit
import RxSwift

enum CoordinatorError: Error {
    case invalidViewController
    case cannotNavigateBack
}

final class SceneCoordinator: SceneCoordinatorProtocol {
    // MARK: - Properties

    private lazy var window = UIWindow(frame: UIScreen.main.bounds).then {
        $0.makeKeyAndVisible()
    }
    private var currentViewController: UIViewController?

    // MARK: - Static functions

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first ?? viewController
        }
        return viewController
    }

    // MARK: - ScreenCoordinatorProtocol

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, animated: Bool) -> Completable {
        let viewController = scene.createViewController(asNavigationRoot: type != .push)
        logger(
            "transitioning to",
            Swift.type(of: SceneCoordinator.actualViewController(for: viewController)),
            "animated:",
            animated,
            "type:",
            type,
            event: .info
        )

        let subject = PublishSubject<Void>()

        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self else { return }
            switch type {
            case .root:
                self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
                self.window.rootViewController = viewController
                subject.onCompleted()
            case .push:
                guard let navigationController = self.currentViewController?.navigationController else {
                    subject.onError(CoordinatorError.invalidViewController)
                    break
                }
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
                navigationController.pushViewController(viewController, animated: animated)
            case .modal:
                self.currentViewController?.present(viewController, animated: animated) {
                    subject.onCompleted()
                }
            }
        }

        return subject
            .asObservable()
            .take(1)
            .ignoreElements()
    }

    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()

        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self, let navigationController = self.currentViewController?.navigationController else {
                subject.onError(CoordinatorError.invalidViewController)
                return
            }
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            if navigationController.popViewController(animated: animated) == nil {
                subject.onError(CoordinatorError.cannotNavigateBack)
            } else {
                self.currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            }
        }

        return subject
            .asObservable()
            .take(1)
            .ignoreElements()
    }

    func dismiss(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()

        DispatchQueue.mainSyncSafe { [weak self] in
            guard let self = self, let presentingViewController = self.currentViewController?.presentingViewController else {
                subject.onError(CoordinatorError.invalidViewController)
                return
            }
            currentViewController?.dismiss(animated: animated) {
                subject.onCompleted()
            }
            self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
        }

        return subject
        .asObservable()
        .take(1)
        .ignoreElements()
    }
}
