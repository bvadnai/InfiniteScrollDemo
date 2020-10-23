//
//  ListViewModel.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

private let query = "+language:swift"
private let sort = "stars"
private let order = "desc"
private let perPage = Int(UIScreen.main.bounds.height / LayoutSize.pt78) * 13

final class ListViewModel: ListViewModelProtocol, HasDisposeBag {
    // MARK: - Properties

    private let canLoadMore = BehaviorSubject(value: true)

    private let repositoriesService: RepositoriesServiceProtocol
    private var page = 1

    // MARK: - Initialization

    init(repositoriesService: RepositoriesServiceProtocol) {
        self.repositoriesService = repositoriesService

        loadMoreReposAction.elements
            .map { !$0.isEmpty }
            .debug()
            .do(onNext: { [weak self] _ in self?.page += 1 })
            .bind(to: canLoadMore)
            .disposed(by: disposeBag)

        loadMoreReposAction.elements
            .withLatestFrom(list) { ($1, $0) }
            .map { oldElements, newElements in
                oldElements + newElements
            }
            .bind(to: list)
            .disposed(by: disposeBag)

        loadMoreReposAction.errors.subscribe(onNext: { logger("error", $0) }).disposed(by: disposeBag)
    }

    // MARK: - ListViewModelProtocol

    let list = BehaviorSubject<[Repository]>(value: [])

    private(set) lazy var loadMoreReposAction: Action<Void, [Repository]> = { [weak self] in
        Action(enabledIf: self?.canLoadMore ?? .just(false)) {
            guard let self = self else { return .just([]) }
            logger("loading page \(self.page)... (\(perPage) per page)")
            return self.repositoriesService
                .fetchRepositories(query: query, sort: sort, order: order, page: self.page, perPage: perPage)
                .asObservable()
                .observeOn(MainScheduler.instance)
        }
    }()
}
