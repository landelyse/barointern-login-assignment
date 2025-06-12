//
//  SignUpUIView.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

final class SignUpUIView: UIView {
    var onSignInButtonTapped: (() -> Void)?
    var onSignUpButtonTapped: (() -> Void)?

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sign Up"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title2)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Create your account"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title)
        label.textColor = .black
        return label
    }()

    let emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Email"
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

    let confirmPasswordTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.textColor = .accentTextColor
        textField.backgroundColor = .textFieldColor
        textField.layer.cornerRadius = UIMetric.CornerRadius.textField
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()

    let nicknameTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Nickname"
        textField.textColor = .accentTextColor
        textField.backgroundColor = .textFieldColor
        textField.layer.cornerRadius = UIMetric.CornerRadius.textField
        textField.autocapitalizationType = .none
        return textField
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body, weight: .bold)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = UIMetric.CornerRadius.button
        return button
    }()

    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Sign In", for: .normal)
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
            confirmPasswordTextField,
            nicknameTextField,
            signUpButton,
            signInButton
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
            confirmPasswordTextField,
            nicknameTextField,
            signUpButton,
            signInButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIMetric.Padding.regular),
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

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIMetric.Padding.small),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            nicknameTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: UIMetric.Padding.small),
            nicknameTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            nicknameTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            nicknameTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            signUpButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: UIMetric.Padding.regular),
            signUpButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.buttonHeight),

            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: UIMetric.Padding.large),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupButtonAction() {
        let signInAction: UIAction = UIAction { [weak self] _ in
            self?.onSignInButtonTapped?()
        }
        let signUpAction: UIAction = UIAction { [weak self] _ in
            self?.onSignUpButtonTapped?()
        }

        signUpButton.addAction(signUpAction, for: .touchUpInside)
        signInButton.addAction(signInAction, for: .touchUpInside)
    }
}
