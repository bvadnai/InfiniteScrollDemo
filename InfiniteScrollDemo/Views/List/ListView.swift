//
//  ListView.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit
import SnapKit

final class ListView: UIView {
    // MARK: - Properties

    private(set) lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func addSubviews() {
        addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints {
            if #available(iOS 11, *) {
                $0.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                $0.top.equalToSuperview().offset(LayoutSize.pt26)
                $0.bottom.equalToSuperview()
            }
            $0.left.equalToSuperview().offset(LayoutSize.pt24)
            $0.right.equalToSuperview().offset(-LayoutSize.pt24)
        }
    }
}

// MARK: - UITableViewDelegate

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutSize.pt78
    }
}
