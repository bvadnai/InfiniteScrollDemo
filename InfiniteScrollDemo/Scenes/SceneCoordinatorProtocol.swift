//
//  SceneCoordinatorProtocol.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

protocol SceneCoordinatorProtocol {
    func transition(to scene: Scene, type: SceneTransitionType, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
}

extension SceneCoordinatorProtocol {
    func transition(to scene: Scene, type: SceneTransitionType) {
        transition(to: scene, type: type, animated: true)
    }

    func pop() {
        pop(animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
