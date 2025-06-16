//
//  Untitled.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

final class WelcomeUIView: UIView {
    var onSignOutButtonTapped: (() -> Void)?
    var onDeleteButtonTapped: (() -> Void)?
    private let userName: String

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Welcome user!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "you can sign out or delete user"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.body)
        label.textColor = .black
        return label
    }()

    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignOut", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body, weight: .bold)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = UIMetric.CornerRadius.button
        return button
    }()

    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body, weight: .bold)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .white
        return button
    }()

    init(name: String) {
        self.userName = name
        super.init(frame: .zero )
        setUpUI()
        setupConstraints()
        setupButtonAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)는 미구현입니다.")
    }

    private func setUpUI() {
        backgroundColor = .white
        [
            titleLabel,
            descriptionLabel,
            signOutButton,
            deleteButton
        ].forEach {
            addSubview($0)
        }
        self.titleLabel.text = "Welcome \(self.userName)!"
    }

    private func setupConstraints() {
        [
            titleLabel,
            descriptionLabel,
            signOutButton,
            deleteButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIMetric.Padding.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.large),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.large),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIMetric.Padding.regular),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.large),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.large),

            signOutButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: UIMetric.Padding.regular),
            signOutButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.buttonHeight),

            deleteButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: UIMetric.Padding.large),
            deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupButtonAction() {
        let signOutAction: UIAction = UIAction { [weak self] _ in
            self?.onSignOutButtonTapped?()
        }
        let deleteAction: UIAction = UIAction { [weak self] _ in
            self?.onDeleteButtonTapped?()
        }

        signOutButton.addAction(signOutAction, for: .touchUpInside)
        deleteButton.addAction(deleteAction, for: .touchUpInside)
    }
}
