//
//  SignOutUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

final class SignOutUseCase {
    private let preferenceRepository: PreferenceRepository

    init(preferenceRepository: PreferenceRepository) {
        self.preferenceRepository = preferenceRepository
    }

    func execute() {
        preferenceRepository.deleteSignedInUserInfo()
    }
}
