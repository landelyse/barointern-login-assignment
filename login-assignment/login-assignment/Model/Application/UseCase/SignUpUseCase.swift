//
//  SignInUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

final class SignUpUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(user: SignUpDto) async throws {
        let user: User = try UserFactory.create(by: user)

        if try await userRepository.isEmailExists(user.email) {
            throw UseCaseError.emailAlreadyExists
        }

        try await userRepository.save(user)
    }
}
