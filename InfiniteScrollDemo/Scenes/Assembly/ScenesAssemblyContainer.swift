//
//  ScenesAssemblyContainer.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import UIKit
import Swinject

final class ScenesAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(SceneCoordinatorProtocol.self) { _ in SceneCoordinator() }
    }
}
