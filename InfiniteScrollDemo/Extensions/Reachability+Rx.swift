//
//  Reachability+Rx.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Reachability
import RxSwift

extension Reachability {
    enum Errors: Error {
        case unavailable
    }
}

extension Reactive where Base: Reachability {
    static var isReachable: Observable<Bool> {
        return Observable.create { observer in
            let reachability = Reachability.forInternetConnection()
            if let reachability = reachability {
                observer.onNext(reachability.isReachable())
                reachability.reachableBlock = { _ in observer.onNext(true) }
                reachability.unreachableBlock = { _ in observer.onNext(false) }
                reachability.startNotifier()
            } else {
                observer.onError(Reachability.Errors.unavailable)
            }
            return Disposables.create {
                reachability?.stopNotifier()
            }
        }
    }
}
