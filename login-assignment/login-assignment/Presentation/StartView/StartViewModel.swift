//
//  StartViewModel.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import Combine
import Foundation

@MainActor
final class StartViewModel {
    private let navigationUseCase: StartNavigationUseCase

    private let navigateToWelcomeSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private let navigateToSignInSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()

    var navigateToWelcomePublisher: AnyPublisher<Void, Never> {
        navigateToWelcomeSubject.eraseToAnyPublisher()
    }
    var navigateToSignInPublisher: AnyPublisher<Void, Never> {
        navigateToSignInSubject.eraseToAnyPublisher()
    }

    init(navigationUseCase: StartNavigationUseCase) {
        self.navigationUseCase = navigationUseCase
    }

    func startButtonTapped() {
#if DEBUG
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
#endif
        
        if navigationUseCase.execute() {
            navigateToWelcomeSubject.send(())
        } else {
            navigateToSignInSubject.send(())
        }
    }
}
