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
        let preferenceRepository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let useCase: SignInUseCase = SignInUseCase(
            userRepository: userRepository,
            preferenceRepository: preferenceRepository
        )
        let authCoordinator: AuthCoordinator = AuthCoordinator(
            navigationController: navigationController,
            signInUseCase: useCase,
            coreDataStack: coreDataStack
        )

        authCoordinator.isCompleted = { [weak self, weak authCoordinator] in
            guard let coordinator = authCoordinator,
                  let self = self
            else { return }
            self.removeChildCoordinator(coordinator)
        }

        coordinate(to: authCoordinator)
    }

    func showWelcome() {
        let preferenceRepository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let deleteUserUseCase: DeleteUserUseCase = DeleteUserUseCase(
            userRepository: userRepository,
            preferenceRepository: preferenceRepository
        )
        let signOutUseCase: SignOutUseCase = SignOutUseCase(
            preferenceRepository: preferenceRepository
        )
        let viewModel: WelcomeViewModel = WelcomeViewModel(
            signOutUseCase: signOutUseCase,
            deleteUserUseCase: deleteUserUseCase
        )
        let viewController: WelcomeViewController = WelcomeViewController(
            viewModel: viewModel
        )

        viewModel.signOutPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            .store(in: &viewController.cancellables)

        viewModel.deleteUserResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success: self?.navigationController.popViewController(animated: true)
                case .failure: break // TODO: error 처리
                }
            }
            .store(in: &viewController.cancellables)

        navigationController.pushViewController(viewController, animated: true)
    }
}
