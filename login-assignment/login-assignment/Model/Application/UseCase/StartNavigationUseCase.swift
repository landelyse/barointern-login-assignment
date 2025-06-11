//
//  StartNavigationUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

final class StartNavigationUseCase {
    private let preferenceRepository: PreferenceRepository

    init(preferenceRepository: PreferenceRepository) {
        self.preferenceRepository = preferenceRepository
    }

    func execute() -> Bool {
        preferenceRepository.hasSignedInBefore()
    }
}
