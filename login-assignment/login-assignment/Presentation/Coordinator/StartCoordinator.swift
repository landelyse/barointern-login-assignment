//
//  StartCoordinator.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

@MainActor
final class StartCoordinator: Coordinator, Finishable {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var isCompleted: (() -> Void)?
    private let useCase: StartNavigationUseCase
    private let coreDataStack: CoreDataStack<UserEntity>

    init(
        navigationController: UINavigationController,
        useCase: StartNavigationUseCase,
        coreDataStack: CoreDataStack<UserEntity>
    ) {
        self.navigationController = navigationController
        self.useCase = useCase
        self.coreDataStack = coreDataStack
    }

    func start() {
        let viewModel: StartViewModel = StartViewModel(navigationUseCase: useCase)
        let viewController: StartViewController = StartViewController(viewModel: viewModel)

        viewModel.navigateToSignInPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showSignIn()
            }
            .store(in: &viewController.cancellables)

        viewModel.navigateToWelcomePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showWelcome()
            }
            .store(in: &viewController.cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showSignIn() {
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
        let coreDataStack: CoreDataStack = CoreDataStack<UserEntity>()
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let preferenceRepository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let useCase: SignInUseCase = SignInUseCase(userRepository: userRepository , preferenceRepository: preferenceRepository)
        let viewModel: SignInViewModel = SignInViewModel(useCase: useCase)
        let viewController: SignInViewController = SignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }

    func showWelcome() {
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let useCase: SignUpUseCase = SignUpUseCase(userRepository: userRepository)
        let viewModel: SignUpViewModel = SignUpViewModel(useCase: useCase)
        let viewController: SignUpViewController = SignUpViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
