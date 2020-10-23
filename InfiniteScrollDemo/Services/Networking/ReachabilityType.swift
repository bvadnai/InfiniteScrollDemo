//
//  ReachabilityType.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import RxSwift

protocol ReachabilityType {
    var isReachable: Observable<Bool> { get }
}
