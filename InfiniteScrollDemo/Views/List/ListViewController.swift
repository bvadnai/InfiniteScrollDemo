//
//  ListViewController.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit
import RxSwift
import RxCocoa

final class ListViewController: ViewController, BindableType {
    // MARK: - Properties

    typealias ViewModelType = ListViewModelProtocol
    var viewModel: ListViewModelProtocol!
    private var listView: ListView! { return view as? ListView }

    // MARK: - UIViewController

    override func loadView() {
        super.loadView()

        view = ListView()
        view.backgroundColor = .blackThree
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.loadMoreReposAction.execute(())
    }

    // MARK: - BindableType

    func bindViewModel() {
        viewModel.list
            .bind(to: listView.tableView.rx.items(cellIdentifier: ListCell.reuseIdentifier, cellType: ListCell.self)) { _, item, cell in
                cell.configure(id: item.id, name: item.name, fullName: item.fullName, avatarURL: item.avatarURL)
            }
            .disposed(by: rx.disposeBag)

        let tableView = listView.tableView
        tableView.rx.contentOffset
            .filter { offset in
                (offset.y + tableView.contentSize.height * 0.666) > tableView.contentSize.height
            }
            .map { _ in }
            .throttle(.milliseconds(6100), scheduler: MainScheduler.instance)
            .subscribe(viewModel.loadMoreReposAction.inputs)
            .disposed(by: rx.disposeBag)
        tableView.rx.modelSelected(Repository.self)
            .subscribe(viewModel.showDetailsAction.inputs)
            .disposed(by: rx.disposeBag)
    }
}
