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
    private let userInfoUseCase: UserInfoUseCase

    private let navigateToWelcomeSubject: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    private let navigateToSignInSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()

    var navigateToWelcomePublisher: AnyPublisher<String, Never> {
        navigateToWelcomeSubject.eraseToAnyPublisher()
    }
    var navigateToSignInPublisher: AnyPublisher<Void, Never> {
        navigateToSignInSubject.eraseToAnyPublisher()
    }

    init(navigationUseCase: StartNavigationUseCase, userInfoUseCase: UserInfoUseCase) {
        self.navigationUseCase = navigationUseCase
        self.userInfoUseCase = userInfoUseCase
    }

    func startButtonTapped() {
        guard navigationUseCase.execute(),
              let name = try? userInfoUseCase.getNickName() else {
            navigateToSignInSubject.send()
            return
        }
        navigateToWelcomeSubject.send(name)
    }
}
