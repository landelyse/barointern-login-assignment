//
//  Coordinator.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import UIKit

@MainActor
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func coordinate(to coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

@MainActor
protocol Finishable: AnyObject {
    associatedtype Result = Void
    var isCompleted: ((Result) -> Void)? { get set }
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
