//
//  DetailsView.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import SnapKit

private func createTitleLabel() -> UILabel {
    return UILabel().then {
        $0.font = .helvetica(ofSize: 13)
        $0.textColor = .warmGrey
    }
}

private func createResultLabel() -> UILabel {
    return UILabel().then {
        $0.font = .helveticaBold(ofSize: 23)
        $0.textColor = .white
    }
}

final class DetailsView: UIView {
    // MARK: - Properties

    private lazy var avatarContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = LayoutSize.pt141 / 2
        $0.clipsToBounds = true
    }

    private lazy var avatarView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    private lazy var nameLabel = UILabel().then {
        $0.font = .helveticaBold(ofSize: 38)
        $0.textColor = .white
    }

    private lazy var fullNameLabel = UILabel().then {
        $0.font = .helvetica(ofSize: 16)
        $0.textColor = .warmGrey
    }

    private lazy var separator1 = UIView().then {
        $0.backgroundColor = .black
    }

    private lazy var descriptionTitle = createTitleLabel().then {
        $0.text = "Description"
    }

    private lazy var descriptionLabel = UILabel().then {
        $0.font = .helvetica(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private lazy var separator2 = UIView().then {
        $0.backgroundColor = .black
    }

    private lazy var scoreIcon = UIImageView().then {
        $0.image = UIImage(named: "score")
        $0.contentMode = .center
    }

    private lazy var scoreTitle = createTitleLabel().then {
        $0.text = "Score"
    }

    private lazy var scoreLabel = createResultLabel()

    private lazy var redLine1 = UIView().then {
        $0.backgroundColor = .red
    }

    private lazy var forksTitle = createTitleLabel().then {
        $0.text = "Forks number"
    }

    private lazy var forksCountLabel = createResultLabel()

    private lazy var openIssuesIcon = UIImageView().then {
        $0.image = UIImage(named: "openIssues")
        $0.contentMode = .center
    }

    private lazy var openIssuesTitle = createTitleLabel().then {
        $0.text = "Open issues"
    }

    private lazy var openIssuesLabel = createResultLabel()

    private lazy var redLine2 = UIView().then {
        $0.backgroundColor = .red
    }

    private lazy var watchersTitle = createTitleLabel().then {
        $0.text = "Watchers"
    }

    private lazy var watchersLabel = createResultLabel()

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
        addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(fullNameLabel)
        addSubview(separator1)
        addSubview(descriptionTitle)
        addSubview(descriptionLabel)
        addSubview(separator2)
        addSubview(scoreIcon)
        addSubview(scoreTitle)
        addSubview(scoreLabel)
        addSubview(redLine1)
        addSubview(forksTitle)
        addSubview(forksCountLabel)
        addSubview(openIssuesIcon)
        addSubview(openIssuesTitle)
        addSubview(openIssuesLabel)
        addSubview(redLine2)
        addSubview(watchersTitle)
        addSubview(watchersLabel)
    }

    private func setupConstraints() {
        avatarContainerView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: LayoutSize.pt141, height: LayoutSize.pt141))
            $0.left.equalToSuperview().offset(LayoutSize.pt32)
            $0.top.equalToSuperview().offset(LayoutSize.pt108)
        }

        avatarView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.left.equalTo(avatarContainerView.snp.left)
            $0.top.equalTo(avatarContainerView.snp.bottom).offset(LayoutSize.pt32)
            $0.right.equalToSuperview().offset(-LayoutSize.pt32)
        }

        fullNameLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.left)
            $0.top.equalTo(nameLabel.snp.bottom).offset(LayoutSize.pt1)
            $0.right.equalTo(nameLabel.snp.right)
        }

        separator1.snp.makeConstraints {
            $0.left.equalTo(fullNameLabel.snp.left)
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(LayoutSize.pt32)
            $0.right.equalTo(fullNameLabel.snp.right)
            $0.height.equalTo(LayoutSize.pt1)
        }

        descriptionTitle.snp.makeConstraints {
            $0.left.equalTo(separator1.snp.left)
            $0.top.equalTo(separator1.snp.bottom).offset(LayoutSize.pt32)
            $0.right.equalTo(separator1.snp.right)
        }

        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(descriptionTitle.snp.left)
            $0.top.equalTo(descriptionTitle.snp.bottom).offset(LayoutSize.pt1)
            $0.right.equalTo(descriptionTitle.snp.right)
        }

        separator2.snp.makeConstraints {
            $0.left.equalTo(descriptionLabel.snp.left)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(LayoutSize.pt32)
            $0.right.equalTo(descriptionLabel.snp.right)
            $0.height.equalTo(LayoutSize.pt1)
        }

        openIssuesIcon.snp.makeConstraints {
            $0.left.equalTo(separator2.snp.left)
            $0.bottom.equalToSuperview().offset(-LayoutSize.pt30)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }

        openIssuesLabel.snp.makeConstraints {
            $0.left.equalTo(openIssuesIcon.snp.right).offset(LayoutSize.pt8)
            $0.bottom.equalToSuperview().offset(-LayoutSize.pt23)
        }

        openIssuesTitle.snp.makeConstraints {
            $0.left.equalTo(openIssuesLabel)
            $0.bottom.equalTo(openIssuesLabel.snp.top).offset(-LayoutSize.pt1)
        }

        redLine2.snp.makeConstraints {
            $0.right.equalTo(watchersLabel.snp.left).offset(-LayoutSize.pt8)
            $0.bottom.equalToSuperview().offset(-LayoutSize.pt30)
            $0.size.equalTo(CGSize(width: 7, height: 38))
        }

        watchersLabel.snp.makeConstraints {
            $0.right.equalTo(separator2.snp.right)
            $0.left.equalTo(redLine2.snp.right).offset(LayoutSize.pt8)
            $0.bottom.equalToSuperview().offset(-LayoutSize.pt23)
        }

        watchersTitle.snp.makeConstraints {
            $0.left.equalTo(watchersLabel)
            $0.bottom.equalTo(watchersLabel.snp.top).offset(-LayoutSize.pt1)
        }

        scoreIcon.snp.makeConstraints {
            $0.bottom.equalTo(openIssuesIcon.snp.top).offset(-46)
            $0.centerX.equalTo(openIssuesIcon.snp.centerX)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }

        scoreTitle.snp.makeConstraints {
            $0.bottom.equalTo(openIssuesTitle.snp.top).offset(-60)
            $0.left.equalTo(scoreIcon.snp.right).offset(8)
        }

        scoreLabel.snp.makeConstraints {
            $0.bottom.equalTo(openIssuesLabel.snp.top).offset(-47)
            $0.left.equalTo(scoreIcon.snp.right).offset(8)
        }

        redLine1.snp.makeConstraints {
            $0.centerY.equalTo(scoreIcon.snp.centerY)
            $0.centerX.equalTo(redLine2.snp.centerX)
            $0.size.equalTo(CGSize(width: 7, height: 38))
        }

        forksTitle.snp.makeConstraints {
            $0.bottom.equalTo(watchersTitle.snp.top).offset(-60)
            $0.left.equalTo(redLine1.snp.right).offset(8)
        }

        forksCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(watchersLabel.snp.top).offset(-47)
            $0.left.equalTo(redLine2.snp.right).offset(8)
        }
    }

    func configure(
        name: String,
        fullName: String,
        avatarURL: URL,
        score: Int,
        description: String,
        forksCount: Int,
        openIssuesCount: Int,
        watchers: Int
    ) {
        nameLabel.text = name
        fullNameLabel.text = fullName
        avatarView.load(url: avatarURL)
        scoreLabel.text = "\(score)"
        descriptionLabel.text = description
        forksCountLabel.text = "\(forksCount)"
        openIssuesLabel.text = "\(openIssuesCount)"
        watchersLabel.text = "\(watchers)"
    }
}
