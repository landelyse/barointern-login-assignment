//
//  SignInViewController.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit
import Combine

final class SignInViewController: UIViewController {
    private var contentView: SignInUIView!
    var cancellables: Set<AnyCancellable> = []
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) 미구현")
    }
    
    override func loadView() {
        contentView = SignInUIView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCallbacks()
        bindTextField()
        bindViewModel()
    }
    
    private func setupViewCallbacks() {
        contentView.onSignInButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.signInButtonTapped()
        }
        contentView.onSignUpButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.signUpButtonTapped()
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
    }
    
    private func bindViewModel() {
        viewModel.isSignInButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                self.contentView.signInButton.isEnabled = isEnabled
                self.contentView.signInButton.alpha = isEnabled ? 1 : 0.5
            }
            .store(in: &cancellables)
    }
}
