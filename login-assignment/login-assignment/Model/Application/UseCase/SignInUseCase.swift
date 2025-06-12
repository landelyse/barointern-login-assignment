//
//  SignInUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

final class SignInUseCase {
    private let userRepository: UserRepository
    private let preferenceRepository: PreferenceRepository

    init(userRepository: UserRepository, preferenceRepository: PreferenceRepository) {
        self.userRepository = userRepository
        self.preferenceRepository = preferenceRepository
    }

    @discardableResult
    func execute(email: String, password: String) async throws -> Bool {
        let email: Email = try Email(value: email)
        let password: Password = try Password(value: password)
        let matchedUser: User = try await userRepository.searchByEmail(email)

        if matchedUser.isCorrectPassword(password) {
            let signedInDto: SignedInDto = SignedInUserDtoFactory.create(by: matchedUser)
            preferenceRepository.saveSignedInUserInfo(signedInDto)
            return true
        } else {
            throw UseCaseError.failedToSignIn
        }
    }
}
