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
        container.register(ListViewModelProtocol.self) { resolver in
            ListViewModel(repositoriesService: resolver.resolve(RepositoriesServiceProtocol.self)!)
        }
        container.register(DetailsViewModelProtocol.self) { (_, repository: Repository) in
            DetailsViewModel(repository: repository)
        }
    }
}
