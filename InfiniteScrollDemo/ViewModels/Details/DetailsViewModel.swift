//
//  DetailsViewModel.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation

final class DetailsViewModel: DetailsViewModelProtocol, NavigationViewModelProtocol {
    var repository: Repository
    var coordinator: SceneCoordinatorProtocol?

    init(repository: Repository) {
        self.repository = repository
    }
}
