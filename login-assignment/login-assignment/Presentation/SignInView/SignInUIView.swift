//
//  SignInUIView.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

final class SignInUIView: UIView {
    var onSignInButtonTapped: (() -> Void)?
    var onSignUpButtonTapped: (() -> Void)?

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sign In"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title2)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Baro-Intern"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title)
        label.textColor = .black
        return label
    }()

    let emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Email address"
        textField.textColor = .accentTextColor
        textField.backgroundColor = .textFieldColor
        textField.layer.cornerRadius = UIMetric.CornerRadius.textField
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .accentTextColor
        textField.backgroundColor = .textFieldColor
        textField.layer.cornerRadius = UIMetric.CornerRadius.textField
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()

    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignIn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body, weight: .bold)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = UIMetric.CornerRadius.button
        return button
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New User Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body, weight: .bold)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .white
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            emailTextField,
            passwordTextField,
            signInButton,
            signUpButton
        ].forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        [
            titleLabel,
            descriptionLabel,
            emailTextField,
            passwordTextField,
            signInButton,
            signUpButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UIMetric.Padding.regular),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIMetric.Padding.large),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: UIMetric.Padding.large),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.regular),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.regular),
            emailTextField.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.textFieldHeight),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: UIMetric.Padding.small),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIMetric.Padding.regular),
            signInButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.buttonHeight),

            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: UIMetric.Padding.large),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupButtonAction() {
        let signInAction: UIAction = UIAction { [weak self] _ in
            self?.onSignInButtonTapped?()
        }
        let signUpAction: UIAction = UIAction { [weak self] _ in
            self?.onSignUpButtonTapped?()
        }

        signInButton.addAction(signInAction, for: .touchUpInside)
        signUpButton.addAction(signUpAction, for: .touchUpInside)
    }
}
