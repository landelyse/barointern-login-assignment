//
//  SignUpViewController.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit
import Combine

final class SignUpViewController: UIViewController {
    private var contentView: SignUpUIView!
    var cancellables: Set<AnyCancellable> = []
    private let viewModel: SignUpViewModel

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) 미구현")
    }

    override func loadView() {
        contentView = SignUpUIView()
        view = contentView
    }

    override func viewDidLoad() {
        setupViewCallbacks()
        bindTextField()
        bindViewModel()
    }

    private func setupViewCallbacks() {
        contentView.onSignUpButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.signUpButtonTapped()
        }
        contentView.onSignInButtonTapped = {  [weak self] in
            guard let self = self else { return }
            self.viewModel.signInButtonTapped()
        }
    }

    private func bindTextField() {
        contentView.emailTextField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        contentView.passwordTextField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
        contentView.confirmPasswordTextField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &cancellables)
        contentView.nicknameTextField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.nickname, on: viewModel)
            .store(in: &cancellables)
    }

    private func bindViewModel() {
        viewModel.isSignUpButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] isEnabled in
                guard let self = self else { return }
                self.contentView.signUpButton.isEnabled = isEnabled
                self.contentView.signUpButton.alpha = isEnabled ? 1 : 0.5
            }
            .store(in: &cancellables)
    }
}
