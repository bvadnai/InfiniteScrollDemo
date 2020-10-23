//
//  ViewModelsAssemblyContainer.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Swinject

final class ViewModelsAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(ListViewModelProtocol.self) { _ in
            ListViewModel()
        }
    }
}
