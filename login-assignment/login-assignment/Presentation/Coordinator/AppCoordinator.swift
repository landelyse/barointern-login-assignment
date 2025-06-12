//
//  AppCoordinator.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

@MainActor
final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var  navigationController: UINavigationController
    private let coreDataStack: CoreDataStack<UserEntity>

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.coreDataStack = CoreDataStack<UserEntity>()

        setupWindow()
    }

    func start() {
        showStartFlow()
    }

    private func setupWindow() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showStartFlow() {
        let repository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let useCase: StartNavigationUseCase = StartNavigationUseCase(preferenceRepository: repository)
        let startCoordinator: StartCoordinator = StartCoordinator(
            navigationController: navigationController,
            useCase: useCase,
            coreDataStack: coreDataStack
        )

        startCoordinator.isCompleted = { [weak self, weak startCoordinator] in
            guard let coordinator = startCoordinator,
                  let self = self
            else { return }
            self.removeChildCoordinator(coordinator)
        }

        coordinate(to: startCoordinator)
    }
}
