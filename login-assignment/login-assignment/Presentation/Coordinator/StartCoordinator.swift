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
    private let navigateUseCase: StartNavigationUseCase
    private let userInfoUseCase: UserInfoUseCase
    private let coreDataStack: CoreDataStack<UserEntity>

    init(
        navigationController: UINavigationController,
        navigateUseCase: StartNavigationUseCase,
        userInfoUseCase: UserInfoUseCase,
        coreDataStack: CoreDataStack<UserEntity>
    ) {
        self.navigationController = navigationController
        self.navigateUseCase = navigateUseCase
        self.userInfoUseCase = userInfoUseCase
        self.coreDataStack = coreDataStack
    }

    func start() {
        let viewModel: StartViewModel = StartViewModel(
            navigationUseCase: navigateUseCase,
            userInfoUseCase: userInfoUseCase
        )
        let viewController: StartViewController = StartViewController(viewModel: viewModel)

        viewModel.navigateToSignInPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showSignIn()
            }
            .store(in: &viewController.cancellables)

        viewModel.navigateToWelcomePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.showWelcome(name: name)
            }
            .store(in: &viewController.cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showSignIn() {
        let preferenceRepository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let userRepository: UserRepository = CoreDataUserRepository(coreDataStack: coreDataStack)
        let signInUseCase: SignInUseCase = SignInUseCase(
            userRepository: userRepository,
            preferenceRepository: preferenceRepository
        )
        let userInfoUserCase: UserInfoUseCase = UserInfoUseCase(preferenceRepository: preferenceRepository)
        let authCoordinator: AuthCoordinator = AuthCoordinator(
            navigationController: navigationController,
            signInUseCase: signInUseCase,
            userInfoUseCase: userInfoUserCase,
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

    func showWelcome(name: String) {
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
            viewModel: viewModel,
            name: name
        )

        viewModel.signOutPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigationController.popToRootViewController(animated: true)
            }
            .store(in: &viewController.cancellables)

        viewModel.deleteUserResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success: self?.navigationController.popToRootViewController(animated: true)
                case .failure: break // TODO: error 처리
                }
            }
            .store(in: &viewController.cancellables)

        navigationController.pushViewController(viewController, animated: true)
    }
}
