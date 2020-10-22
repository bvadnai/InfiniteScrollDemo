//
//  UINavigationController+Rx.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UINavigationController {
    typealias ShowEvent = (viewController: UIViewController, animated: Bool)

    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    var delegate: DelegateProxy<UINavigationController, UINavigationControllerDelegate> {
        return RxNavigationControllerDelegateProxy.proxy(for: base)
    }
}
