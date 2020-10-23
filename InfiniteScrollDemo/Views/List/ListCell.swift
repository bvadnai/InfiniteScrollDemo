//
//  ListCell.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit

final class ListCell: UITableViewCell {
    // MARK: - Properties

    private lazy var containerView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = LayoutSize.pt4
    }

    private lazy var avatarContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = LayoutSize.pt40 / 2
        $0.clipsToBounds = true
    }

    private lazy var avatarView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    private lazy var nameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = LayoutSize.pt4
        $0.alignment = .leading
    }

    private lazy var nameLabel = UILabel().then {
        $0.font = .helveticaBold(ofSize: LayoutSize.pt22)
        $0.textColor = .white
    }

    private lazy var fullNameLabel = UILabel().then {
        $0.font = .helvetica(ofSize: LayoutSize.pt13)
        $0.textColor = .warmGrey
    }

    private lazy var separator = UIView().then {
        $0.backgroundColor = .blackThree
    }

    private lazy var idLabel = UILabel().then {
        $0.font = .helvetica(ofSize: LayoutSize.pt13)
        $0.textColor = .warmGrey
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private var avatarLoading: DispatchWorkItem?

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarView)
        containerView.addSubview(nameStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(fullNameLabel)
        containerView.addSubview(separator)
        containerView.addSubview(idLabel)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 8, right: 0))
        }

        avatarContainerView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.size.equalTo(CGSize(width: LayoutSize.pt40, height: LayoutSize.pt40))
            $0.centerY.equalTo(containerView.snp.centerY)
        }

        avatarView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }

        nameStackView.snp.makeConstraints {
            $0.left.equalTo(avatarView.snp.right).offset(20)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(LayoutSize.pt176)
        }

        idLabel.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: LayoutSize.pt58, height: LayoutSize.pt34))
            $0.right.equalToSuperview().offset(-LayoutSize.pt16)
            $0.centerY.equalToSuperview()
        }

        separator.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: LayoutSize.pt1, height: LayoutSize.pt48))
            $0.centerY.equalToSuperview()
            $0.right.equalTo(idLabel.snp.left).offset(-LayoutSize.pt15)
        }
    }

    func configure(id: Int, name: String, fullName: String, avatarURL: URL) {
        idLabel.text = "ID \(id)"
        nameLabel.text = name
        fullNameLabel.text = fullName
        avatarLoading = avatarView.load(url: avatarURL)
        DispatchQueue.global().async(execute: avatarLoading!)
    }

    override func prepareForReuse() {
        avatarLoading?.cancel()

        super.prepareForReuse()
    }
}
