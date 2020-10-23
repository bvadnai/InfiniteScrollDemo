//
//  DetailsViewController.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit

final class DetailsViewController: UIViewController, BindableType {
    // MARK: - Properties

    typealias ViewModelType = DetailsViewModelProtocol
    var viewModel: DetailsViewModelProtocol!
    private var detailsView: DetailsView! { return view as? DetailsView }

    // MARK: - UIViewController

    override func loadView() {
        super.loadView()

        view = DetailsView()
        view.backgroundColor = .blackThree
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - BindableType

    func bindViewModel() {
        let repository = viewModel.repository
        detailsView.configure(
            name: repository.name,
            fullName: repository.fullName,
            avatarURL: repository.avatarURL,
            score: repository.score,
            description: repository.description,
            forksCount: repository.forksCount,
            openIssuesCount: repository.openIssuesCount,
            watchers: repository.watchers
        )
    }
}
