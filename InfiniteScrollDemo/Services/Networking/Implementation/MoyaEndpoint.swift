//
//  MoyaEndpoint.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

struct MoyaEndpoint<T: TargetType> {
    // MARK: - Properties

    private let provider: MoyaProvider<T>
    private let reachability: ReachabilityType

    // MARK: - Initialization

    init(provider: MoyaProvider<T>, reachability: ReachabilityType) {
        self.provider = provider
        self.reachability = reachability
    }

    // MARK: - Request logic

    private func request(_ token: T) -> Single<JSON> {
        let actualRequest = provider.rx.request(token, callbackQueue: DispatchQueue.global(qos: .utility))
        return reachability
            .isReachable
            .take(1)
            .asSingle()
            .do(onSuccess: { reachable in
                if !reachable {
                    throw ApiError.noInternetConnection
                }
            })
            .flatMap { _ in
                return actualRequest.retry(3)
            }
            .do(onSuccess: { response in
                switch response.statusCode {
                case 403:
                    throw ApiError.unauthorized
                case 404:
                    throw ApiError.notFound
                default:
                    break
                }
            })
            .mapSwiftyJSON()
            .do(onSuccess: { json in
                if let errorMessage = json[ServerKey.message].string {
                    throw ApiError.requestFailure(errorMessage)
                }
            })
    }
}

// MARK: - RepositoriesServiceProtocol

extension MoyaEndpoint: RepositoriesServiceProtocol where T == GitHubSearch {
    func fetchRepositories(query: String, sort: String, order: String, page: Int, perPage: Int) -> Single<[Repository]> {
        return request(.repositories(query: query, sort: sort, order: order, page: page, perPage: perPage))
            .map { json in
                guard let items = json[ServerKey.items].array else { throw ApiError.badResponseFormat }
                var repositories = [Repository]()
                for item in items {
                    guard let id = item[ServerKey.id].int,
                        let name = item[ServerKey.name].string,
                        let fullName = item[ServerKey.fullName].string,
                        let owner = item[ServerKey.owner].dictionary,
                        let avatarURLString = owner[ServerKey.avatarURL]?.string,
                        let avatarURL = URL(string: avatarURLString),
                        let score = item[ServerKey.score].int,
                        let description = item[ServerKey.description].string,
                        let forksCount = item[ServerKey.forksCount].int,
                        let openIssuesCount = item[ServerKey.openIssuesCount].int,
                        let watchers = item[ServerKey.watchers].int
                    else {
                        continue
                    }
                    let repository = Repository(
                        id: id,
                        name: name,
                        fullName: fullName,
                        avatarURL: avatarURL,
                        score: score,
                        description: description,
                        forksCount: forksCount,
                        openIssuesCount: openIssuesCount,
                        watchers: watchers
                    )
                    repositories.append(repository)
                }
                return repositories
            }
    }
}
