//
//  AuthCoordinator.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

@MainActor
final class AuthCoordinator: Coordinator, Finishable {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var isCompleted: (() -> Void)?
    private let signInUseCase: SignInUseCase
    private let coreDataStack: CoreDataStack<UserEntity>

    init(
        navigationController: UINavigationController,
        signInUseCase: SignInUseCase,
        coreDataStack: CoreDataStack<UserEntity>
    ) {
        self.navigationController = navigationController
        self.signInUseCase = signInUseCase
        self.coreDataStack = coreDataStack
    }

    func start() {
        let viewModel: SignInViewModel = SignInViewModel(useCase: signInUseCase)
        let viewController: SignInViewController = SignInViewController(viewModel: viewModel)

        viewModel.navigateSignUpPublisher
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] in
                self?.showSignUp()
            }
            .store(in: &viewController.cancellables)
        viewModel.signInResultPublisher
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] result in
                switch result {
                case .success:
                    self?.showWelcome()
                case .failure: break // TODO: 에러처리
                }
            }
            .store(in: &viewController.cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showSignUp() {
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let useCase: SignUpUseCase = SignUpUseCase(userRepository: userRepository)
        let viewModel: SignUpViewModel = SignUpViewModel(useCase: useCase)
        let viewController: SignUpViewController = SignUpViewController(viewModel: viewModel)

        viewModel.signUpResultPublisher
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] result in
                switch result {
                case .success: self?.navigationController.popViewController(animated: true)
                case .failure:
                    print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
                }
            }
            .store(in: &viewController.cancellables)

        viewModel.navigateToSignInPublisher
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            .store(in: &viewController.cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showWelcome() {
        print("welcome view 미구현")
    }
}
