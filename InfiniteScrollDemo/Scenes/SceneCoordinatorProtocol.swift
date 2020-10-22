//
//  SceneCoordinatorProtocol.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit
import RxSwift

protocol SceneCoordinatorProtocol {
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, animated: Bool) -> Completable
    @discardableResult
    func pop(animated: Bool) -> Completable
    @discardableResult
    func dismiss(animated: Bool) -> Completable
}

extension SceneCoordinatorProtocol {
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        return transition(to: scene, type: type, animated: true)
    }

    @discardableResult
    func pop() -> Completable {
        return pop(animated: true)
    }

    @discardableResult
    func dismiss() -> Completable {
        return dismiss(animated: true)
    }
}
