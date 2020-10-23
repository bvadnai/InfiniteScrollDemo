//
//  ListViewModelProtocol.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import RxSwift
import Action

protocol ListViewModelProtocol: class {
    var list: BehaviorSubject<[Repository]> { get }
    var loadMoreReposAction: Action<Void, [Repository]> { get }
}
