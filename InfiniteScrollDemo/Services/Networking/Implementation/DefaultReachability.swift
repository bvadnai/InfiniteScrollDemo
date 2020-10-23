//
//  DefaultReachability.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import RxSwift
import Reachability

struct DefaultReachability: ReachabilityType {
    let isReachable: Observable<Bool> = { return Reachability.rx.isReachable }()
}
