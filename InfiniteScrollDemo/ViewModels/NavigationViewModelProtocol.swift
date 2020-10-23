//
//  NavigationViewModelProtocol.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Action

protocol NavigationViewModelProtocol: class {
}

extension NavigationViewModelProtocol {
    var backAction: CocoaAction {
        return CocoaAction {
            sharedApplication.coordinator.pop().asObservable().map { _ in }
        }
    }
}
