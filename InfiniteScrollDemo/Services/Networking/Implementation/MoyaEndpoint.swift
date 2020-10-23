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
    private let provider: MoyaProvider<T>
    private let reachability: ReachabilityType

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
                if response.statusCode == 403 {
                    throw ApiError.unauthorized
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
