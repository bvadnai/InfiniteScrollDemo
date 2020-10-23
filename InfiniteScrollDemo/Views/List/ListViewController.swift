//
//  ListViewController.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

final class ListViewController: UIViewController, BindableType {
    // MARK: - Properties

    typealias ViewModelType = ListViewModelProtocol
    var viewModel: ListViewModelProtocol!

    // MARK: - UIViewController

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
    }

    // MARK: - BindableType

    func bindViewModel() {
    }
}
