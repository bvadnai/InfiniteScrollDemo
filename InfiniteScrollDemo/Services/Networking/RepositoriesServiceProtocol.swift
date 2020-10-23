//
//  RepositoriesServiceProtocol.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import RxSwift

protocol RepositoriesServiceProtocol {
    func fetchRepositories(query: String, sort: String, order: String, page: Int, perPage: Int) -> Single<[Repository]>
}
