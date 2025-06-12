//
//  StartCoordinator.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

@MainActor
final class StartCoordinator: Coordinator, Finishable {
    enum Result {
        case signedIn
        case signedOut
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var isCompleted: ((Result) -> Void)?
    private let useCase: StartNavigationUseCase
    
    init(
        navigationController: UINavigationController,
        useCase: StartNavigationUseCase
    ) {
        self.navigationController = navigationController
        self.useCase = useCase
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
    }
    
    func showWelcome() {
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
    }
}
